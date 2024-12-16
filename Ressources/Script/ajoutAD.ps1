# Adresse IP de l'ordinateur distant
$remoteComputer = Read-Host "Veuillez entrer l'IP ou le nom de la machine distante"

# Demander les informations d'authentification une seule fois
$credential = Get-Credential

# Fonction pour écrire des logs dans un fichier
function Log {
    $LOG_DATE = Get-Date -Format "yyyy-MM-dd"
    $LOG_FILE = "C:\Users\Public\Documents\log_evt_$LOG_DATE.log"
    Add-Content -Path $LOG_FILE -Value "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") - $($args -join ' ')"
}

# Fonction pour exécuter des commandes à distance
function Execute-RemoteCommand {
    param (
        [string]$remoteComputer,
        [scriptblock]$scriptBlock
    )
    try {
        # Exécution de la commande à distance
        Invoke-Command -ComputerName $remoteComputer -ScriptBlock $scriptBlock -Credential $credential -ErrorAction Stop
        Log "Commande exécutée avec succès sur $remoteComputer"
    } catch {
        Write-Host "Erreur lors de l'exécution de la commande à distance : $_"
        Log "Erreur lors de l'exécution de la commande à distance sur $remoteComputer : $_"
    }
}

# Définir les informations nécessaires
$domain = "billu.remindme.lan"  # Nom du domaine AD
$username = "Administrator"     # Utilisateur ayant les droits pour ajouter des machines au domaine
$password = "Azerty1*"          # Mot de passe de l'utilisateur

# Convertir le mot de passe en un objet sécurisé
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

# Créer un objet d'identification avec le nom d'utilisateur et le mot de passe sécurisé
$domainCredential = New-Object System.Management.Automation.PSCredential($username, $securePassword)

# Exécuter la commande à distance pour ajouter l'ordinateur au domaine
Invoke-Command -ComputerName $remoteComputer -Credential $credential -ScriptBlock {
    param ($domain, $domainCredential)
    try {
        # Ajouter l'ordinateur au domaine
        Add-Computer -DomainName $domain -Credential $domainCredential -Restart -Force
        Write-Host "L'ordinateur a été ajouté au domaine avec succès."
    } catch {
        Write-Host "Erreur lors de l'ajout de l'ordinateur au domaine : $_"
    }
} -ArgumentList $domain, $domainCredential
