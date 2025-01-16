
# Fonction pour ajouter un utilisateur au groupe
function Add-UserToGroup {
    param (
        [string]$UserName,
        [string]$GroupName
    )
   try {
        # Vérifier si l'utilisateur existe déjà dans le groupe
        $groupMembers = Get-ADGroupMember -Identity "$GroupName" -ErrorAction SilentlyContinue
        $user = Get-ADUser -Filter {SamAccountName -eq $UserName}

        if ($user) {
            if ($groupMembers -contains $user) {
                # Indiquer que l'utilisateur est déjà membre sans ajouter
                Write-Host "L'utilisateur $UserName est déjà membre du groupe $GroupName" -ForegroundColor Cyan
            } else {
                # Ajouter l'utilisateur au groupe
                Add-ADGroupMember -Identity "$GroupName" -Members $user
                Write-Host "L'utilisateur $UserName a été ajouté au groupe $GroupName" -ForegroundColor Green
            }
        } else {
            Write-Host "Utilisateur $UserName non trouvé dans AD" -ForegroundColor Red
        }
    } catch {
        Write-Host "Erreur lors de l'ajout de l'utilisateur $UserName au groupe $GroupName : $_" -ForegroundColor Red
    }
}


# Fonction pour supprimer les accents et mettre en minuscules une chaîne
function CleanString {
    param (
        [string]$string
    )

    # Nettoyage des accents et des caractères spéciaux
    $stringWithoutAccents = $string -replace "é", "e" -replace "è", "e" -replace "à", "a" -replace "ù", "u" -replace "ç", "c" -replace "î", "i" -replace "ô", "o" -replace "û", "u" -replace "ñ", "n"
    
    # Conversion en minuscules et suppression des espaces en début/fin
    return $stringWithoutAccents.Trim().ToLower()
}

# Fonction de log avec gestion du niveau de criticité et de l'Event ID
function Write-Log {
    param (
        [string]$Message,
        [string]$Severity = "INFO",  # INFO, ALERT, ERROR
        [int]$EventID = 1000         # Par défaut ID d'événement = 1000
    )
    $LOG_DATE = Get-Date -Format "yyyy-MM-dd"
    $LOG_FILE = "$LogDirectory\log_evt_$LOG_DATE.log"
    
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $logMessage = "$timestamp - [$Severity] (Event ID: $EventID) - $Message"
    
    # Enregistrement dans le fichier de log
    Add-Content -Path $LOG_FILE -Value $logMessage
    
    # Affichage également dans la console
    Write-Host $logMessage
}

### Parametre(s) à modifier
$FilePath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

$File = "$FilePath\Utilisateurs.txt"
$LogDirectory = "C:\Users\Public\Documents"  # Répertoire pour les fichiers de log

### Main program

Clear-Host
If (-not(Get-Module -Name activedirectory)) {
    Import-Module activedirectory
}

# Importer et nettoyer les données CSV
$Users = Import-Csv -Path $File -Delimiter ";" -Encoding UTF8

# Appliquer CleanString à tous les champs
$Users = $Users | ForEach-Object {
    $_.'Nom' = CleanString $_.'Nom'
    $_.'Prenom' = CleanString $_.'Prenom'
    $_.'Departement' = CleanString $_.'Departement'
    $_.'Service' = CleanString $_.'Service'
    $_.'Societe' = CleanString $_.'Societe'
    $_.'fonction' = CleanString $_.'fonction'
    $_.'Manager-Nom' = CleanString $_.'Manager-Nom'
    $_.'Manager-Prenom' = CleanString $_.'Manager-Prenom'
    $_
}

$ADUsers = Get-ADUser -Filter * -Properties *
$count = 1

Foreach ($User in $Users) {
    # Correction de la progression pour ne pas dépasser 100
    Write-Progress -Activity "Création des utilisateurs dans l'OU" -Status "% effectué" -PercentComplete ( [math]::Min($Count / $Users.Length * 100, 100) )
    
    # Extraction des informations utilisateur
    $Name              = "$($User.Nom) $($User.Prenom)"
    $DisplayName       = "$($User.Nom) $($User.Prenom)"
    $SamAccountName    = $($User.Prenom.Substring(0,1).ToLower()) + $($User.Nom.ToLower())
    $UserPrincipalName = (($User.prenom.Substring(0,1).ToLower() + $User.nom.ToLower()) + "@" + (Get-ADDomain).Forest)
    $GivenName         = $User.Prenom
    $Surname           = $User.Nom
    $OfficePhone       = $User.Tel
    $EmailAddress      = $UserPrincipalName
    $Company           = $User.Societe
    $Department        = "$($User.Departement)"
    $Title             = $User.fonction   # Fonction
    
    # Nettoyage du nom du manager : inversion du format "Prénom Nom" -> "Nom Prénom"
    $ManagerName       = "$($User.'Manager-Nom') $($User.'Manager-Prenom')"  # Nom et prénom nettoyés
    
    # Construire dynamiquement le chemin de l'OU basé sur le département
    $OUPath = "OU=$($User.Departement -replace ' ','\20'),OU=USER,DC=wilder,DC=lan"

    # Vérifier si l'OU existe avant de créer ou modifier l'utilisateur
    $OUExists = Get-ADOrganizationalUnit -Filter {DistinguishedName -eq $OUPath} -ErrorAction SilentlyContinue
    If (-not $OUExists) {
        Write-Log "L'OU pour le département $($User.Service) n'existe pas dans l'AD." "ERROR" 1001
        Write-Host "Veuillez créer l'OU manuellement ou ajuster le script." -ForegroundColor Yellow
        Continue
    }

    # Chercher l'utilisateur existant dans l'AD en utilisant SamAccountName
    $ExistingUser = Get-ADUser -Filter {SamAccountName -eq $SamAccountName} -Properties *

    If ($ExistingUser) {
        # Recherche du manager dans l'AD avec le nom "Nom Prénom"
        $Manager = Get-ADUser -Filter {DisplayName -eq $ManagerName} -Properties DistinguishedName

        If (-not $Manager) {
            # Si pas trouvé avec DisplayName, essayer avec le nom complet
            $Manager = Get-ADUser -Filter {Name -eq $ManagerName} -Properties DistinguishedName
        }

        If ($Manager) {
            $ManagerDN = $Manager.DistinguishedName
        } Else {
            Write-Log "Le manager $ManagerName n'a pas été trouvé dans l'AD" "ERROR" 1002
            $ManagerDN = $null  # Ou attribuer une valeur par défaut si nécessaire
        }

        # Comparaison et mise à jour des informations si nécessaire
        $ChangesMade = $false

        # Vérifier les champs et ne modifier que si nécessaire
        If ($ExistingUser.GivenName -ne $GivenName) {
            Set-ADUser -Identity $ExistingUser -GivenName $GivenName
            $ChangesMade = $true
            Write-Log "Mise à jour du prénom de l'utilisateur $SamAccountName" "INFO" 2001
        }

        If ($ExistingUser.Surname -ne $Surname) {
            Set-ADUser -Identity $ExistingUser -Surname $Surname
            $ChangesMade = $true
            Write-Log "Mise à jour du nom de l'utilisateur $SamAccountName" "INFO" 2002
        }

        If ($ExistingUser.OfficePhone -ne $OfficePhone) {
            Set-ADUser -Identity $ExistingUser -OfficePhone $OfficePhone
            $ChangesMade = $true
            Write-Log "Mise à jour du téléphone de l'utilisateur $SamAccountName" "INFO" 2003
        }

        If ($ExistingUser.EmailAddress -ne $EmailAddress) {
            Set-ADUser -Identity $ExistingUser -EmailAddress $EmailAddress
            $ChangesMade = $true
            Write-Log "Mise à jour de l'email de l'utilisateur $SamAccountName" "INFO" 2004
        }

        If ($ExistingUser.Title -ne $Title) {
            Set-ADUser -Identity $ExistingUser -Title $Title
            $ChangesMade = $true
            Write-Log "Mise à jour du titre de l'utilisateur $SamAccountName" "INFO" 2005
        }

        If ($ExistingUser.Department -ne $Department) {
            Set-ADUser -Identity $ExistingUser -Department $Department
            $ChangesMade = $true
            Write-Log "Mise à jour du département de l'utilisateur $SamAccountName" "INFO" 2006
        }

        If ($ExistingUser.Company -ne $Company) {
            Set-ADUser -Identity $ExistingUser -Company $Company
            $ChangesMade = $true
            Write-Log "Mise à jour de l'entreprise de l'utilisateur $SamAccountName" "INFO" 2007
        }

        If ($ExistingUser.Manager -ne $ManagerDN) {
            Set-ADUser -Identity $ExistingUser -Manager $ManagerDN
            $ChangesMade = $true
            Write-Log "Mise à jour du manager de l'utilisateur $SamAccountName" "INFO" 2008
        }

        # Si des modifications ont été faites, afficher le message
        If ($ChangesMade) {
            Write-Log "Mise à jour de l'utilisateur $SamAccountName" "INFO" 2000
        }

        # Ajouter l'utilisateur au groupe correspondant à son service
        $userGroupPrefix = "User-" + $User.Service
        Add-UserToGroup -UserName $SamAccountName -GroupName $userGroupPrefix

    } Else {
        # Créer un nouvel utilisateur si il n'existe pas
        Write-Log "Aucun utilisateur trouvé avec SamAccountName : $SamAccountName. Création d'un nouvel utilisateur." "INFO" 3000

        # Créer un nouvel utilisateur
        New-ADUser -Name $Name -DisplayName $DisplayName -SamAccountName $SamAccountName -UserPrincipalName $UserPrincipalName `
            -GivenName $GivenName -Surname $Surname -OfficePhone $OfficePhone -EmailAddress $EmailAddress `
            -Path $OUPath -AccountPassword (ConvertTo-SecureString -AsPlainText "Azerty1*" -Force) -Enabled $True `
            -OtherAttributes @{Company = $Company; Department = $Department; Title = $Title} `
            -Manager $ManagerDN -ChangePasswordAtLogon $True

        Write-Log "Création du USER $SamAccountName" "INFO" 3001

        # Ajouter l'utilisateur au groupe correspondant à son service
        $userGroupPrefix = "User-" + $User.Service
        Add-UserToGroup -UserName $SamAccountName -GroupName $userGroupPrefix
        Write-Log "Ajout du USER $SamAccountName dans le groupe $$userGroupPrefix" "INFO" 3001
    }

    $Count++
    sleep -Milliseconds 100
}
