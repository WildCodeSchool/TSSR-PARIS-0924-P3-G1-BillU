# Fonction pour écrire les logs dans un fichier
function Write-Log {
    param (
        [string]$Message,
        [string]$Severity = "INFO",  # INFO, ALERT, ERROR
        [int]$EventID = 1000         # Par défaut ID d'événement = 1000
    )
    $LOG_DATE = Get-Date -Format "yyyy-MM-dd"
    $LOG_FILE = "C:\Users\Public\Documents\log_evt_$LOG_DATE.log"
    
    # Formater le message de log avec les détails (timestamp, gravité, EventID)
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $logMessage = "$timestamp - [$Severity] (Event ID: $EventID) - $Message"
    
    # Enregistrer dans le fichier de log
    Add-Content -Path $LOG_FILE -Value $logMessage
}

# Demander le prénom et le nom de l'utilisateur
$prenom = Read-Host "Entrez le prénom de l'utilisateur"
$nom = Read-Host "Entrez le nom de l'utilisateur"

# Générer le SamAccountName
$SamAccountName = ($prenom.Substring(0,1).ToLower()) + $nom.ToLower()

Write-Host "SamAccountName généré : $SamAccountName"
Write-Log "SamAccountName généré : $SamAccountName" "INFO" 1000

# Vérifier si l'utilisateur existe dans Active Directory
$user = Get-ADUser -Filter {SamAccountName -eq $SamAccountName} -Properties Enabled

if ($null -eq $user) {
    Write-Host "L'utilisateur avec le SamAccountName $SamAccountName n'a pas été trouvé dans Active Directory." -ForegroundColor Red
    Write-Log "L'utilisateur avec le SamAccountName $SamAccountName n'a pas été trouvé dans Active Directory." "ERROR" 1001
    exit
}

Write-Host "L'utilisateur $SamAccountName a été trouvé dans Active Directory."
Write-Log "L'utilisateur $SamAccountName a été trouvé dans Active Directory." "INFO" 1002

# Vérifier si l'utilisateur est déjà activé
if ($user.Disabled -eq $false) {
    Write-Host "L'utilisateur $SamAccountName est déjà activé." -ForegroundColor Yellow
    Write-Log "L'utilisateur $SamAccountName est déjà activé." "ALERT" 1003
    exit
}

# Réactiver l'utilisateur
Set-ADUser -Identity $user -Enabled $true
Write-Host "L'utilisateur $SamAccountName a été réactivé avec succès." -ForegroundColor Green
Write-Log "L'utilisateur $SamAccountName a été réactivé avec succès." "INFO" 1004
