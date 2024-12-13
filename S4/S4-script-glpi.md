#!/bin/bash

# **Mettre à jour les paquets existants**

echo "Mise à jour des paquets..."
sudo apt update -y
sudo apt upgrade -y

# **Installer Apache, PHP et MariaDB**

echo "Installation d'Apache, PHP et MariaDB..."
sudo apt install apache2 php libapache2-mod-php mariadb-server php-mysql php-cli php-xml php-mbstring php-curl php-json php-gd php-zip -y

# **Démarrer   Apache et MariaDB**

echo "Démarrage des services Apache et MariaDB..."
sudo systemctl start apache2
sudo systemctl start mariadb
sudo systemctl enable apache2
sudo systemctl enable mariadb

# **Sécuriser MariaDB (ajouter un mot de passe root)**

echo "Sécurisation de MariaDB..."
sudo mysql_secure_installation

# **Création de la base de données et de l'utilisateur GLPI**

DB_NAME="glpi_db"
DB_USER="glpi_user"
DB_PASSWORD="glpipassword"
ROOT_PASSWORD="rootpassword"  #le changer si on a besoin

echo "Création de la base de données GLPI..."
sudo mysql -u root -p$ROOT_PASSWORD -e "CREATE DATABASE $DB_NAME;"
sudo mysql -u root -p$ROOT_PASSWORD -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
sudo mysql -u root -p$ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
sudo mysql -u root -p$ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

# **Télécharger GLPI**

GLPI_VERSION="10.0.4"
GLPI_URL="https://github.com/glpi-project/glpi/releases/download/$GLPI_VERSION/glpi-$GLPI_VERSION.tgz"
GLPI_DIR="/var/www/html/glpi"

echo "Téléchargement de GLPI version $GLPI_VERSION..."
wget $GLPI_URL -O /tmp/glpi-$GLPI_VERSION.tgz

echo "Extraction de GLPI..."
sudo mkdir -p $GLPI_DIR
sudo tar -xvzf /tmp/glpi-$GLPI_VERSION.tgz -C /var/www/html/

# **Définir les permissions GLPI**

echo "Définition des permissions pour GLPI..."
sudo chown -R www-data:www-data $GLPI_DIR
sudo chmod -R 755 $GLPI_DIR

# **Activer les modules Apache**

echo "Activation des modules Apache..."
sudo a2enmod rewrite
sudo systemctl restart apache2

# **Configuration de PHP**

echo "Activation des extensions PHP nécessaires..."
sudo phpenmod mysqli
sudo phpenmod mbstring
sudo phpenmod curl
sudo phpenmod json
sudo systemctl restart apache2

# **Finalisation de l'installation**

echo "Installation terminée. Vous pouvez maintenant configurer GLPI via le navigateur."
echo "Accédez à : http://localhost/glpi"

# **Nettoyage des fichiers temporaires**

rm /tmp/glpi-$GLPI_VERSION.tgz

echo "Fin du script d'installation."





# **Nom du fichier: install_glpi.sh.
# **Donner les permissions pour executer: chmod +x install_glpi.sh
# **Pour lexecuter: ./install_glpi.sh
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------








-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--Explication du script--

    1) Mise à jour des paquets : Le script  mett à jour les paquets du système .

   2) Installation d'Apache, PHP et MariaDB : Le script installe Apache, PHP et MariaDB .

   3)  Démarrage des services Apache et MariaDB : Il démarre et active Apache et MariaDB pour qu'ils se lancent au démarrage.

   4) Sécurisation de MariaDB : pour sécuriser et configurer le mot de passe root de MariaDB.

    5) Création de la base de données GLPI : Le script crée une base de données appelée glpi_db, un utilisateur appelé glpi_user, et lui donne les privilèges nécessaires.

    6) Téléchargement et extraction de GLPI : GLPI est téléchargé depuis GitHub et extrait dans le répertoire /var/www/html/glpi.

    7) Définition des permissions : Les permissions des fichiers sont ajustées pour que le serveur Apache (utilisateur www-data) puisse accéder et modifier les fichiers de GLPI.

    8) Activation des modules Apache et PHP : Le script active le module rewrite d'Apache, essentiel pour GLPI

    9) Finalisation : Le script donne l'URL de l'installation (http://localhost/glpi) pour que tu puisses finaliser la configuration via l'interface web de GLPI.

   10) Nettoyage : Le fichier temporaire est supprimé à la fin du script.














































Utilisateur : glpi_user
Mot de passe : glpipassword
