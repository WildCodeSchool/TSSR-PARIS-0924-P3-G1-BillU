# Définir les informations nécessaires
$domain = "billu.remindme.lan"  # Nom du domaine AD
$username = "Administrateur"    # Utilisateur ayant les droits pour ajouter des machines au domaine
$password = "Azerty1*"  # Mot de passe de l'utilisateur

# Convertir le mot de passe en un objet sécurisé
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

# Créer un objet d'identification avec le nom d'utilisateur et le mot de passe sécurisé
$credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)

# Nom de l'ordinateur à joindre au domaine
$computerName = "NomDuPC" 

# Exécuter la commande à distance sur le PC cible
Invoke-Command -ComputerName $computerName -ScriptBlock {
    Add-Computer -DomainName "billu.remindme.lan" -Credential $using:credential -Restart
} -Credential $credential
