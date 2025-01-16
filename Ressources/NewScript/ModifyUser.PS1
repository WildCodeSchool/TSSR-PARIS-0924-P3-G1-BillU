# Fonction pour écrire les logs dans un fichier et la console
function Write-Log {
    param (
        [string]$Message,
        [string]$Severity = "INFO",  # INFO, ALERT, ERROR
        [int]$EventID = 1000         # Par défaut ID d'événement = 1000
    )
    $LOG_DATE = Get-Date -Format "yyyy-MM-dd"
    $LOG_FILE = "C:\Users\Public\Documents\log_evt_$LOG_DATE.log"
    
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $logMessage = "$timestamp - [$Severity] (Event ID: $EventID) - $Message"
    
    # Enregistrement dans le fichier de log
    Add-Content -Path $LOG_FILE -Value $logMessage
    
    # Affichage dans la console (sans les informations détaillées)
    Write-Host $Message
}

# Demander le prénom et le nom de l'utilisateur
$prenom = Read-Host "Entrez le prénom de l'utilisateur"
$nom = Read-Host "Entrez le nom de l'utilisateur"

# Générer le SamAccountName
$SamAccountName = ($prenom.Substring(0,1).ToLower()) + $nom.ToLower()

# Afficher dans la console
Write-Host "SamAccountName généré : $SamAccountName"
Write-Log "SamAccountName généré : $SamAccountName" "INFO" 1000

# Vérifier si l'utilisateur existe dans Active Directory
$user = Get-ADUser -Filter {SamAccountName -eq $SamAccountName} -Properties *

if ($null -eq $user) {
    Write-Host "L'utilisateur $SamAccountName n'a pas été trouvé dans Active Directory." -ForegroundColor Red
    Write-Log "L'utilisateur $SamAccountName n'a pas été trouvé dans Active Directory." "ERROR" 1003
    exit
}

Write-Host "Utilisateur trouvé : $($user.DisplayName)" -ForegroundColor Green
Write-Log "Utilisateur trouvé : $($user.DisplayName)" "INFO" 1000

# Afficher les options disponibles
Write-Host "Quel champ souhaitez-vous modifier pour l'utilisateur $SamAccountName ?" -ForegroundColor Green
Write-Host "1. Nom complet (Name)"
Write-Host "2. Affichage du nom (DisplayName)"
Write-Host "3. Nom de compte (SamAccountName)"
Write-Host "4. Adresse de l'utilisateur (UserPrincipalName)"
Write-Host "5. Prénom (GivenName)"
Write-Host "6. Nom de famille (Surname)"
Write-Host "7. Numéro de téléphone (OfficePhone)"
Write-Host "8. Adresse e-mail (EmailAddress)"
Write-Host "9. Société (Company)"
Write-Host "10. Département (Department)"
Write-Host "11. Titre de fonction (Title)"
Write-Host "12. Responsable (Manager)"
Write-Host "13. Retour au menu précédent"
Write-Host "14. Exit"

# Demander à l'utilisateur de choisir un champ à modifier
$choice = Read-Host "Entrez le numéro de l'option souhaitée"

# Traitement en fonction du choix
switch ($choice) {
    1 {
        # Modifier le nom complet
        $newName = Read-Host "Entrez le nouveau nom complet (ex : Nom Prénom)"
        $names = $newName -split " "
        $lastName = $names[0]   # Nom
        $firstName = $names[1]  # Prénom

        # Générer le nouveau DistinguishedName
        $oldDN = $user.DistinguishedName
        $oldCN = $user.Name   # Le CN actuel de l'utilisateur (Nom complet)
        $newCN = "$lastName $firstName"  # Nouveau CN à partir du nom de famille du prénom

        # Renommer l'utilisateur
        Rename-ADObject -Identity $oldDN -NewName $newCN
        Write-Log "Renommage de l'utilisateur $SamAccountName en $newCN." "INFO" 2001

        # Récupérer l'utilisateur avec le nouveau DN
        $user = Get-ADUser -Identity "CN=$newCN,$($user.DistinguishedName.Substring($user.DistinguishedName.IndexOf('OU=')))" -Properties *

        # Générer le nouveau SamAccountName et UserPrincipalName
        $newSamAccountName = ($firstName.Substring(0,1).ToLower()) + $lastName.ToLower()
        $newUPN = (($firstName.Substring(0,1).ToLower() + $lastName.ToLower()) + "@" + (Get-ADDomain).Forest)

        # Mettre à jour l'utilisateur
        Set-ADUser -Identity $user -GivenName $firstName -Surname $lastName -DisplayName "$firstName $lastName" -SamAccountName $newSamAccountName -UserPrincipalName $newUPN
        Set-ADUser -Identity $user -EmailAddress $newUPN

        Write-Host "Le nom complet de l'utilisateur $SamAccountName a été modifié." -ForegroundColor Green
        Write-Log "Le nom complet, SamAccountName, UserPrincipalName et Email ont été modifiés pour l'utilisateur $SamAccountName." "INFO" 2000
    }

    2 {
        # Modifier le nom d'affichage
        $newDisplayName = Read-Host "Entrez le nouveau nom d'affichage"
        Set-ADUser -Identity $user -DisplayName $newDisplayName
        Write-Host "Le nom d'affichage de l'utilisateur $SamAccountName a été modifié en $newDisplayName." -ForegroundColor Green
        Write-Log "Le nom d'affichage de l'utilisateur $SamAccountName a été modifié en $newDisplayName." "INFO" 2002
    }

    3 {
        # Modifier le SamAccountName
        $newSamAccountName = Read-Host "Entrez le nouveau SamAccountName"
        Set-ADUser -Identity $user -SamAccountName $newSamAccountName
        $newUPN = (($user.GivenName.Substring(0,1).ToLower() + $user.Surname.ToLower()) + "@" + (Get-ADDomain).Forest)
        Set-ADUser -Identity $user -UserPrincipalName $newUPN

        Write-Host "Le SamAccountName de l'utilisateur $SamAccountName a été modifié en $newSamAccountName." -ForegroundColor Green
        Write-Host "Le UserPrincipalName a été modifié en $newUPN." -ForegroundColor Green
        Write-Log "Le SamAccountName et UserPrincipalName de l'utilisateur $SamAccountName ont été modifiés." "INFO" 2003
    }

    # Autres cases sont similaires et suivent la même logique...

    13 { return }
    14 { exit }
}

Write-Host "Modification terminée."
Write-Log "Modification terminée." "INFO" 1000
