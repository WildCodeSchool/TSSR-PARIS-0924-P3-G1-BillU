# Paramètres
$LogDirectory = "C:\Users\Public\Documents"  # Répertoire pour les fichiers de log
$LOG_DATE = Get-Date -Format "yyyy-MM-dd"
$LOG_FILE = "$LogDirectory\log_evt_$LOG_DATE.log"

# Fonction pour écrire dans le fichier de log
function Write-Log {
    param (
        [string]$Message,
        [string]$Severity = "INFO",  # INFO, ALERT, ERROR
        [int]$EventID = 1000         # Par défaut ID d'événement = 1000
    )
    
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $logMessage = "$timestamp - [$Severity] (Event ID: $EventID) - $Message"
    
    # Enregistrer dans le fichier de log
    Add-Content -Path $LOG_FILE -Value $logMessage
    
    # Afficher uniquement le message dans le terminal sans les détails supplémentaires
    Write-Host $Message
}

# Demander à l'utilisateur de saisir le nom du département ou de l'OU
$ouName = Read-Host "Entrez le nom de l'OU à créer (ex : Marketing, IT, etc.)"

# Récupérer le Distinguished Name du domaine
$domainDN = (Get-ADDomain).DistinguishedName

# Définir les chemins pour les OUs parents (USER et COMPUTER)
$ouUserPath = "OU=USER,$domainDN"
$ouComputerPath = "OU=COMPUTER,$domainDN"

# Fonction pour créer une OU si elle n'existe pas
function Create-OU {
    param (
        [string]$ouName,
        [string]$ouPath
    )

    # Vérifier si l'OU existe déjà
    $ouExists = Get-ADOrganizationalUnit -Filter {Name -eq $ouName} -SearchBase $ouPath -ErrorAction SilentlyContinue

    if ($ouExists) {
        $message = "L'OU '$ouName' existe déjà dans '$ouPath'."
        Write-Log -Message $message -Severity "INFO" -EventID 1002
    } else {
        # Créer l'OU si elle n'existe pas
        New-ADOrganizationalUnit -Name $ouName -Path $ouPath

        # Retirer la protection contre la suppression
        Set-ADOrganizationalUnit -Identity "OU=$ouName,$ouPath" -ProtectedFromAccidentalDeletion $false

        $message = "L'OU '$ouName' a été créée avec succès dans '$ouPath'."
        Write-Log -Message $message -Severity "INFO" -EventID 1001
    }
}

# Créer l'OU dans USER
Create-OU -ouName $ouName -ouPath $ouUserPath

# Créer l'OU dans COMPUTER
Create-OU -ouName $ouName -ouPath $ouComputerPath
