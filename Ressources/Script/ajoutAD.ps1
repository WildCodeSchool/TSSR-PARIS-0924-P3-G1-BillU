# Définir les informations nécessaires
$domain = "billu.remindme.lan"  # Nom du domaine AD
$username = "Administrateur"    # Utilisateur ayant les droits pour ajouter des machines au domaine
$password = "Azerty1*"  # Mot de passe de l'utilisateur

# Convertir le mot de passe en un objet sécurisé
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

# Créer un objet d'identification avec le nom d'utilisateur et le mot de passe sécurisé
$credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)

# Ajouter l'ordinateur au domaine
Add-Computer -DomainName $domain -Credential $credential -Restart

# Redémarrer l'ordinateur pour appliquer les changements
Write-Host "L'ordinateur va maintenant redémarrer et rejoindre le domaine $domain."
