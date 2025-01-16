### Paramètre(s) à modifier
$FilePath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)
$File = "$FilePath\Utilisateurs.txt"  # Assurez-vous que le fichier est bien en CSV
$LogDirectory = "C:\Users\Public\Documents"  # Répertoire pour les fichiers de log

# Importer les données CSV
$Users = Import-Csv -Path $File -Delimiter ";" -Encoding UTF8

# Fonction pour supprimer les accents et mettre en minuscules une chaîne
function CleanString {
    param (
        [string]$string
    )

    # Nettoyage des accents sans supprimer les espaces
    $stringWithoutAccents = $string -replace "é", "e" -replace "è", "e" -replace "à", "a" -replace "ù", "u" -replace "ç", "c" -replace "î", "i" -replace "ô", "o" -replace "û", "u" -replace "ñ", "n" -replace "[^a-zA-Z0-9 ]", ""  # Conserver les espaces

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
}

# Appliquer CleanString uniquement sur le champ 'Departement' pour chaque utilisateur
$Users = $Users | ForEach-Object {
    $_.'Departement' = CleanString $_.'Departement'  # Appliquer CleanString uniquement sur Departement
    $_
}

# Récupérer le Distinguished Name du domaine
$domainDN = (Get-ADDomain).DistinguishedName

# Définir les chemins pour les OU parents (USER et COMPUTER)
$ouUserPath = "OU=USER,$domainDN"
$ouComputerPath = "OU=COMPUTER,$domainDN"

# Créer les OUs USER et COMPUTER si elles n'existent pas
if (-not (Get-ADOrganizationalUnit -Filter {Name -eq "USER"} -SearchBase $domainDN)) {
    New-ADOrganizationalUnit -Name "USER" -Path $domainDN
    Write-Host "L'OU 'USER' a été créée avec succès."
    Write-Log -Message "L'OU 'USER' a été créée avec succès." -Severity "INFO" -EventID 1001
} else {
    Write-Host "L'OU 'USER' existe déjà."
    Write-Log -Message "L'OU 'USER' existe déjà." -Severity "INFO" -EventID 1002
}

if (-not (Get-ADOrganizationalUnit -Filter {Name -eq "COMPUTER"} -SearchBase $domainDN)) {
    New-ADOrganizationalUnit -Name "COMPUTER" -Path $domainDN
    Write-Host "L'OU 'COMPUTER' a été créée avec succès."
    Write-Log -Message "L'OU 'COMPUTER' a été créée avec succès." -Severity "INFO" -EventID 1001
} else {
    Write-Host "L'OU 'COMPUTER' existe déjà."
    Write-Log -Message "L'OU 'COMPUTER' existe déjà." -Severity "INFO" -EventID 1002
}

# Créer les sous-OUs pour chaque département dans USER et COMPUTER
foreach ($User in $Users) {
    $ouName = $User.Departement  

    # Créer la sous-OU dans USER
    $ouPathUser = "OU=$ouName,$ouUserPath"
    if (-not (Get-ADOrganizationalUnit -Filter {Name -eq $ouName} -SearchBase $ouUserPath)) {
        New-ADOrganizationalUnit -Name $ouName -Path $ouUserPath
        Write-Host "L'OU 'USER\\$ouName' a été créée avec succès." -ForegroundColor Green
        Write-Log -Message "L'OU 'USER\\$ouName' a été créée avec succès." -Severity "INFO" -EventID 1001

        # Protéger contre la suppression accidentelle (mais on peut la supprimer explicitement)
        Set-ADOrganizationalUnit -Identity "OU=$ouName,$ouUserPath" -ProtectedFromAccidentalDeletion $false
    } else {
        Write-Host "L'OU 'USER\$ouName' existe déjà."
        Write-Log -Message "L'OU 'USER\$ouName' existe déjà." -Severity "INFO" -EventID 1002
    }

    # Créer la sous-OU dans COMPUTER
    $ouPathComputer = "OU=$ouName,$ouComputerPath"
    if (-not (Get-ADOrganizationalUnit -Filter {Name -eq $ouName} -SearchBase $ouComputerPath)) {
        New-ADOrganizationalUnit -Name $ouName -Path $ouComputerPath
        Write-Host "L'OU 'COMPUTER\$ouName' a été créée avec succès." -ForegroundColor Green
        Write-Log -Message "L'OU 'COMPUTER\$ouName' a été créée avec succès." -Severity "INFO" -EventID 1001

        # Protéger contre la suppression accidentelle (mais on peut la supprimer explicitement)
        Set-ADOrganizationalUnit -Identity "OU=$ouName,$ouComputerPath" -ProtectedFromAccidentalDeletion $false
    } else {
        Write-Host "L'OU 'COMPUTER\$ouName' existe déjà." 
        Write-Log -Message "L'OU 'COMPUTER\$ouName' existe déjà." -Severity "INFO" -EventID 1002
    }
}
