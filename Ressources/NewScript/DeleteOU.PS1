# Paramètres pour le fichier de log
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
}

# Récupérer le Distinguished Name du domaine
$domainDN = (Get-ADDomain).DistinguishedName

# Récupérer toutes les OUs existantes dans le domaine
$OUs = Get-ADOrganizationalUnit -Filter * -SearchBase $domainDN | Select-Object Name, DistinguishedName

# Afficher toutes les OUs disponibles dans le terminal sans Event ID et niveau
Write-Host "=== Liste des OUs disponibles ==="
$index = 1
$OUs | ForEach-Object {
    Write-Host "$index) $_.Name"
    $index++
}

# Demander à l'utilisateur de sélectionner l'OU à supprimer
$choice = Read-Host -Prompt "Entrez le numéro de l'OU que vous souhaitez supprimer"

# Vérifier si le choix est valide
if ($choice -gt 0 -and $choice -le $OUs.Count) {
    # Obtenir l'OU sélectionnée
    $selectedOU = $OUs[$choice - 1]
    Write-Host "Vous avez sélectionné l'OU : $($selectedOU.Name)" -ForegroundColor Green
    
    # Confirmer la suppression
    $confirmation = Read-Host -Prompt "Êtes-vous sûr de vouloir supprimer l'OU '$($selectedOU.Name)' ? (O/N)"
    
    if ($confirmation -eq "O" -or $confirmation -eq "o") {
        try {
            # Supprimer l'OU
            Remove-ADOrganizationalUnit -Identity $selectedOU.DistinguishedName -Recursive
            Write-Host "L'OU '$($selectedOU.Name)' a été supprimée avec succès." -ForegroundColor Green
            
            # Enregistrer dans les logs sans les informations qui apparaissent dans le terminal
            Write-Log -Message "L'OU '$($selectedOU.Name)' a été supprimée avec succès." -Severity "INFO" -EventID 1007
        } catch {
            Write-Host "Une erreur est survenue lors de la suppression de l'OU. Détails de l'erreur : $_" -ForegroundColor Red
            
            # Enregistrer dans les logs l'erreur avec Event ID et sévérité
            Write-Log -Message "Erreur lors de la suppression de l'OU '$($selectedOU.Name)'. Détails : $_" -Severity "ERROR" -EventID 1008
        }
    } else {
        Write-Host "Suppression annulée." -ForegroundColor Yellow
        
        # Enregistrer dans les logs l'annulation de la suppression
        Write-Log -Message "Suppression de l'OU '$($selectedOU.Name)' annulée par l'utilisateur." -Severity "INFO" -EventID 1009
    }
} else {
    Write-Host "Numéro de sélection invalide. Aucune action effectuée." -ForegroundColor Red
    
    # Enregistrer dans les logs l'erreur de sélection invalide
    Write-Log -Message "Numéro de sélection invalide lors de la suppression de l'OU." -Severity "ERROR" -EventID 1010
}
