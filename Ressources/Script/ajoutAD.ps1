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

$ip = "172.19.1.7"  # Remplacez par l'IP de l'ordinateur distant
$credential = Get-Credential  # Pour obtenir les informations d'identification de l'administrateur

Invoke-Command -ComputerName $ip -Credential $credential -ScriptBlock {
    Add-Computer -DomainName "billu.remindme.lan" -Credential $using:credential -Restart
}
