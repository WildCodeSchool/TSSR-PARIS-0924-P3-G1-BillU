
     #Vérifier si un paquet est installé
 
function Check-Installed {
    param(
        [string]$package
    )
    $result = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name LIKE '%$package%'"
    return $result -ne $null
}

     # Installer Apache, PHP et MariaDB si non installés
if (-not (Check-Installed -package "Apache HTTP Server")) {
    Write-Host "Installation d'Apache..."
    choco install apache-httpd -y
}

if (-not (Check-Installed -package "PHP")) {
    Write-Host "Installation de PHP..."
    choco install php -y
}

if (-not (Check-Installed -package "MariaDB")) {
    Write-Host "Installation de MariaDB..."
    choco install mariadb -y
}

     # Démarrer Apache et MariaDB
Write-Host "Démarrage des services Apache et MariaDB..."
Start-Service -Name "Apache2.4"
Start-Service -Name "MariaDB"

     # Attente pour que le services sois bien démarrés
Start-Sleep -Seconds 10

     # Vérifier que les services sont en cours d'exécution
if ((Get-Service -Name "Apache2.4").Status -eq 'Running' -and (Get-Service -Name "MariaDB").Status -eq 'Running') {
    Write-Host "Apache et MariaDB sont maintenant en cours d'exécution."
} else {
    Write-Host "Erreur lors du démarrage des services."
}

     # Configuration de la base de données MySQL/MariaDB
$rootPassword = "rootpassword"  # Mot de passe pour l'utilisateur root de MariaDB
$dbName = "glpi_db"  # Nom de la base de données GLPI
$dbUser = "glpi_user"  # Utilisateur GLPI
$dbPassword = "glpipassword"  # Mot de passe de l'utilisateur GLPI

      # Créer la base de données GLPI
Write-Host "Création de la base de données GLPI..."
mysql -u root -p$rootPassword -e "CREATE DATABASE $dbName;"
mysql -u root -p$rootPassword -e "CREATE USER '$dbUser'@'localhost' IDENTIFIED BY '$dbPassword';"
mysql -u root -p$rootPassword -e "GRANT ALL PRIVILEGES ON $dbName.* TO '$dbUser'@'localhost';"
mysql -u root -p$rootPassword -e "FLUSH PRIVILEGES;"

Write-Host "Base de données GLPI créée avec succès."

     # Télécharger et extraire GLPI
$glpiDownloadUrl = "https://github.com/glpi-project/glpi/releases/download/10.0.4/glpi-10.0.4.tgz"
$glpiDir = "C:\inetpub\wwwroot\glpi"

Write-Host "Téléchargement de GLPI..."
Invoke-WebRequest -Uri $glpiDownloadUrl -OutFile "C:\glpi-10.0.4.tgz"

Write-Host "Extraction de GLPI..."
New-Item -Path $glpiDir -ItemType Directory -Force
tar -xvzf "C:\glpi-10.0.4.tgz" -C $glpiDir

Write-Host "GLPI téléchargé et extrait avec succès."

    # Configuration de PHP (activation de certaines extensions)
Write-Host "Activation des extensions PHP nécessaires..."
$phpIniPath = "C:\tools\php\php.ini"
    
    # Modifier php.ini pour activer les extensions nécessaires (exemple pour mysqli)
$phpIniContent = Get-Content -Path $phpIniPath
$phpIniContent = $phpIniContent -replace ";extension=mysqli", "extension=mysqli"
$phpIniContent | Set-Content -Path $phpIniPath

      # Redémarrer Apache pour appliquer les changements PHP
Write-Host "Redémarrage d'Apache pour appliquer les changements PHP..."
Restart-Service -Name "Apache2.4"

      # Finaliser l'installation
Write-Host "L'installation de GLPI est terminée. Accédez à l'URL suivante pour finaliser la configuration via le navigateur web :"
Write-Host "http://localhost/glpi"

