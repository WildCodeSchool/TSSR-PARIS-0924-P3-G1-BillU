INSTALL GUIDE Infrastructure sécurisée pour BillU
Semaine_S7
Date de documentation: 16/01/2025

Besoins initiaux : besoins du projet:
installer un serveur Zabbix pour la supervision des serveurs du parc informatique

Choix techniques:
Étapes d'installation et de configuration :
Installation serveur Zabbix :
Un serveur avec une distribution Linux (Debian, Ubuntu, CentOS, etc).
Un serveur web (Apache ou Nginx).
Un SGBD ou DBMS (MariaDB/MySQL ou PostgreSQL).
Un Windows 11 où installer l'agent Zabbix.


mysql_secure_installation
Installation de PHP:
Zabbix 7.2 peut nécessiter PHP 7.4 ou une version plus récente. Installez PHP et les modules nécessaires:

apt install php php-cli php-common php-mbstring php-gd php-xml php-bcmath php-ldap php-mysql
Pour l'installation de Zabbix se rendre sur : https://www.zabbix.com/download?zabbix=6.4&os_distribution=debian&os_version=11&components=server_frontend_agent&db=mysql&ws=apache

Choisir la version Debian 11 (bullseye), Server, Mysql, Apache.

a. Installation du dépôt Zabbix

 wget https://repo.zabbix.com/zabbix/7.2/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.2+debian12_all.deb 
 dpkg -i zabbix-release_latest_7.2+debian12_all.deb

apt update
b. Installation du serveur Zabbix, frontend, et l'agent
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
c. Création d'une base de données SQL

mysql -uroot -p
password
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;
mysql> create user zabbix@localhost identified by 'password';
mysql> grant all privileges on zabbix.* to zabbix@localhost;
mysql> set global log_bin_trust_function_creators = 1;
mysql> quit;

Sur l'hôte du serveur Zabbix, importez le schéma et les données initiales. Vous serez invité à saisir votre mot de passe nouvellement créé.

zcat /usr/share/zabbix/sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
Désactivation de l'option log_bin_trust_function_creators après l'importation du schéma de la base de données.

mysql -uroot -p  
password  
mysql> set global log_bin_trust_function_creators = 0;  
mysql> quit;

d. Configurer la base de données su serveur Zabbix
Éditer le fichier de configuration de Zabbix server (/etc/zabbix/zabbix_server.conf) et définir les paramètres de la base de données.

nano /etc/zabbix/zabbix_server.conf
Dans ce fichier, chercher et modifier les lignes suivantes avec nos propres valeurs:

DBHost=localhost DBName=zabbixdb DBUser=zabbix DBPassword=Azerty1*
e. Démarrer les services du serveur et de l'agent Zabbix
systemctl restart zabbix-server zabbix-agent apache2  
systemctl enable zabbix-server zabbix-agent apache2
e. Configuration du frontend Zabbix
Ouvrir un navigateur web et accéder à : http://localhost/zabbix/ et entrer Admin comme nom d'utilisateur et zabbix comme mot de passe
![1](https://github.com/user-attachments/assets/902919af-5249-40a9-9247-9da22c2a08d0)

Fenêtre de Zabbix une fois configuré. Se reporter à la section ci-dessous pour intégrer l'infrastructure actuelle de Billu à notre superviseur.
![2](https://github.com/user-attachments/assets/a72801f5-32fd-40d5-81d9-3ae2d70d216b)

Mise en place de l'agent Zabbix 2 sur les serveurs du Parc
Pré-requis
Avoir téléchargé l'agent Zabbix pour les serveurs Windows sur https://www.zabbix.com/fr/download_agents et selectionner le bon fichier en fonction de la version de Zabbix choisi pendant l'installation pour nous ca sera l'agent zabbix 2 v6.4.10
Mise en place pour un serveur Windows
Apres avoir téléchargé l'agent lancer l'installation, cliquer sur Next, accepter les termes de licence et cliquer sur next (voir image 1 et 2)

![3](https://github.com/user-attachments/assets/aeb1d515-6b45-4406-a165-46c3e2d382e2)
![4](https://github.com/user-attachments/assets/545ea254-5ad2-4c30-891d-a131867de060)

La prochaine fenêtre propose de sélectionner l'emplacement de l'installation, laisser par défaut et cliquer sur Next

![5](https://github.com/user-attachments/assets/59a9c2b9-1e50-44c3-a919-ba85faf7d143)

La fenetre de configuration de l'agent arrive et demande le nom de la machine et l'adresse IP du serveur Zabbix, entrer les informations demandées et cliquer sur next puis Install et Finish

![6](https://github.com/user-attachments/assets/d7dbba81-1ac4-4870-9512-29e8716b63ca)



Modifier les paramètres suivants :
    Server=@IP serveur Zabbix
    ServerActive=127.0.0.1
    Hostname=nom de la machine ou l'agent est installer
Relancer le service Zabbix Agent 2 avec les commandes suivantes :
sudo systemctl start zabbix-agent2
sudo systemctl enable zabbix-agent2
sudo systemctl status zabbix-agent2
Le service étant bien en Running notre configuration client est fini.
Mise en place Debian :
Lancer la liste de commande suivante afin d'installer l'agent:
sudo apt update
wget https://repo.zabbix.com/zabbix/6.4/debian/pool/main/z/zabbix-release/zabbix-release_6.4-1+debian$(lsb_release -rs)_all.deb
sudo dpkg -i zabbix-release_6.4-1+debian$(lsb_release -rs)_all.deb
sudo apt update
sudo apt install zabbix-agent2
Configurer le fichier zabbix_agent2.conf avec la commande suivante :
sudo nano /etc/zabbix/zabbix_agent2.conf
Modification des paramètres suivants :
    Server=@IP serveur Zabbix
    ServerActive=127.0.0.1
    Hostname=nom de la machine ou l'agent est installer
    Relancer le service Zabbix Agent 2 avec les commandes suivantes :
sudo systemctl start zabbix-agent2
sudo systemctl enable zabbix-agent2
sudo systemctl status zabbix-agent2
Le service est bien en mode "Running" notre configuration client est finie.
Configuration sur le Serveur Zabbix pour la surveillance du Client.
Une fois l'Agent Zabbix installé et configuré passer sur la partie graphique du serveur Zabbix afin de configurer le client.
Se Connecter à l'interface graphique de Zabbix et aller sur l'onglet "Collecte de données/hotes"
![9](https://github.com/user-attachments/assets/68ddb18a-ce8f-491c-8fa3-aa202f6ec77b)


Création d'un nouvel hôte et renseigner tous les eléments permettant la surveillance de celui ci
![8](https://github.com/user-attachments/assets/bf4293e4-81f6-461a-9d23-1a9890c363f2)

Renseigner le nom de l'hôte (machine où l'agent Zabbix est installé) le modèle "windows by Zabbix Agent", le groupe d'hôte auquel il va etre affecté et l'interface en cliquant sur ajouter type "Agent" @IP "IP du serveur à surveiller" 
valide.
Apres quelques minutes le nouvel h^pte devrait apparaître en disponible et les informations de surveillance sont disponibles en visuel.
![9](https://github.com/user-attachments/assets/ccf62ad0-2410-44d2-8c56-bd6bc4e8b65b)
![10](https://github.com/user-attachments/assets/105fc8ac-8ed3-43a0-9bdf-7987de611c4f)







