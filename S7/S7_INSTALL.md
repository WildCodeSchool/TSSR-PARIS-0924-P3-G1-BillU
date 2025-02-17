# S7
# Restriction d'utilisation Pour les utilisateurs standard


### Étapes principales

1. **Configuration dans Active Directory** :
   - Créer une stratégie de restriction horaire sur les utilisateurs standards.
   - Ajouter un groupe nommé `bypass` dans Active Directory pour gérer les exceptions.

2. **Script PowerShell** :
   - Appliquer les plages horaires pour les utilisateurs standards.
   - Vérifier les membres des groupes (administrateurs ou *bypass*) et les exclure des restrictions.
   - Automatiser l'exécution des règles pour garantir une mise à jour régulière.

Voici un script PowerShell pour cette configuration :


# Script pour appliquer des restrictions d'accès horaires à une OU spécifique

# Définir les variables
$OU_Users = "OU=Communication et Relations publiques,OU=UTILISATEUR,DC=billu,DC=remindme,DC=lan"

# Générer les horaires pour un jour : 7h30 à 20h
$DayHours = @("7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20")
$FullDay = @("0")*24
foreach ($hour in $DayHours) { $FullDay[$hour] = "1" }
$WorkingDay = -join $FullDay

# Créer les horaires de la semaine
$Sunday = "0"*24    # Dimanche : pas d'accès
$Monday = $WorkingDay
$Tuesday = $WorkingDay
$Wednesday = $WorkingDay
$Thursday = $WorkingDay
$Friday = $WorkingDay
$Saturday = "0"*24  # Samedi : pas d'accès

# Combiner les jours pour former la semaine complète
$AllDays = "$Sunday$Monday$Tuesday$Wednesday$Thursday$Friday$Saturday"

# Diviser la chaîne binaire en blocs de 8 bits et convertir en octets
$BinaryResult = $AllDays -split '(\d{8})' | Where-Object { $_ -match '(\d{8})' }
$LogonHours = New-Object "byte[]" 21
$i = 0
foreach ($byte in $BinaryResult) {
    $TempVar = $byte.ToCharArray()
    [array]::Reverse($TempVar)
    $LogonHours[$i] = [Convert]::ToByte((-join $TempVar), 2)
    $i++
}

# Appliquer les restrictions horaires aux utilisateurs de l'OU
Get-ADUser -Filter * -SearchBase $OU_Users -Properties SamAccountName | ForEach-Object {
    $User = $_.SamAccountName
    try {
        Set-ADUser -Identity $User -Replace @{logonhours = $LogonHours}
        Write-Host "Restrictions appliquées avec succès à l'utilisateur : $User" -ForegroundColor Green
    } catch {
        Write-Host "Erreur lors de l'application des restrictions à l'utilisateur : $User. $_" -ForegroundColor Red
    }
}

Write-Host "Configuration terminée pour tous les utilisateurs de l'OU : $OU_Users." -ForegroundColor Cyan

### Instructions d'utilisation

1. **Prérequis** :
   - Exécuter le script sur un serveur ayant le module Active Directory installé.
   - Adapter les valeurs des variables comme l'OU, les horaires, et le nom du groupe *bypass*.

2. **Exécuter le script** :
   - Sauvegardez le script dans un fichier `.ps1`.
   - Exécutez-le avec des privilèges d'administrateur.

3. **Planification des mises à jour** :
   - Utilisez le Planificateur de tâches Windows pour exécuter le script régulièrement, garantissant la mise à jour des restrictions.

### Test et validation
- Vérifiez qu'un utilisateur standard ne peut pas se connecter en dehors des horaires définis.
- Confirmez que les membres du groupe *bypass* et les administrateurs n’ont aucune restriction.
