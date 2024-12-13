# Sommaire

## S4
- [Installation d'un serveur GPLPI sur Debian](#installation-dun-serveur-gplpi-sur-debian)
  - [Étape 1 : Installation d'un serveur web Apache](#étape-1--installation-dun-serveur-web-apache)
  - [Étape 2 : Installation de PHP](#étape-2--installation-de-php)
  - [Étape 3 : Installation de la base de données MariaDB](#étape-3--installation-de-la-base-de-données-mariadb)
  - [Étape 4 : Téléchargement et extraction de GLPI](#étape-4--téléchargement-et-extraction-de-glpi)
  - [Étape 5 : Configuration du chemin d'accès du serveur web](#étape-5--configuration-du-chemin-daccès-du-serveur-web)
  - [Connexion au serveur GPLPI depuis un client](#connexion-au-serveur-gplpi-depuis-un-client)

- [Synchronisation AD](#synchronisation-ad)
  - [Étape 1 : Synchronisation AD](#étape-1--synchronisation-ad)
  - [Étape 2 : Import en masse des utilisateurs depuis la BaseDN](#étape-2--import-en-masse-des-utilisateurs-depuis-la-basedn)
  - [Étape 3 : Import des groupes](#étape-3--import-des-groupes)
  - [Étape 4 : Gestionnaire de ticket](#étape-4--gestionnaire-de-ticket)
  - [Étape 5 : Import des ordinateurs AD dans GLPI via une GPO](#étape-5--import-des-ordinateurs-ad-dans-glpi-via-une-gpo)
  - [Étape 6 : Test de connexion et création de ticket depuis un utilisateur AD](#étape-6--test-de-connexion-et-création-de-ticket-depuis-un-utilisateur-ad)

- [Automatisation de l'installation d'AD-DS sur Windows Server Core](#automatisation-de-linstallation-dad-ds-sur-windows-server-core)
  - [Introduction](#1-introduction)
  - [Prérequis techniques](#2-prérequis-techniques)
  - [Structure des fichiers](#3-structure-des-fichiers)
  - [Script PowerShell](#4-script-powershell)
  - [Étapes d'exécution](#5-étapes-dexécution)
  - [Vérifications post-installation](#6-vérifications-post-installation)


# Installation d'un serveur GPLPI sur Debian 

### Etape 1 : Installation d'un serveur web Apache 

- Commencer par la mise-à-jour du système  : `sudo apt-get update && sudo apt-get upgrade`

- Installer le serveur web Apache : `sudo apt-get install apache2 -y`

- Activer Apache au démarrage de la machine : `sudo systemctl enable apache2`

### Etape 2 : Installation de PHP

La version PHP 8.1 est requise pour assurer la compatibilité avec les dernières versions de GLPI

- Ajouter le dépôt pour PHP 8.1 `deb https://packages.sury.org/php/ bookworm main` dans le fichier `/etc/apt/sources.list`

- Téléchargez la clé depuis l'URL officielle **Sury** : `wget https://packages.sury.org/php/apt.gpg`
    
- Ajoutez ensuite cette clé au système de gestion de paquets APT : `sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/sury-archive-keyring.gpg apt.gpg`

- Installez PHP :

```bash
sudo apt-get install php8.1 libapache2-mod-php8.1 -y
sudo apt-get install php8.1-{ldap,imap,apcu,xmlrpc,curl,common,gd,mbstring,mysql,xml,intl,zip,bz2}
```

- Modifier les configuration  de PHP

Editer le fichier /etc/php/8.1/apache2/php.ini et modifier les paramètres suivants :
- memory_limit = `64M`
- max_execution_time = `600`


### Etape 3 : Installation de la base de donnée MariaDb

- Installer la base de donnée MariaDb `sudo apt-get install mariadb-server -y`

- Lancer du processus d'initialisation de la base de données : `sudo mysql_secure_installation`

*Répondre `Y` à toutes les questions qui seront posées pendant l'initialisation*.

*Suite à la question `Change the root password?` il faudra entrer le mot de passe de la base de données*

- Lancer la connexion à la base de données  `mysql -u root -p`

- Configurer de la base de donnée : 

```bash
create database glpidb character set utf8 collate utf8_bin;
grant all privileges on glpidb.* to glpi@localhost identified by 'Azerty1*';
flush privileges;
quit
```

### Etape 4 : Téléchargement et extraction de GLPI

- Récupérer les sources Glpi via wget `wget https://github.com/glpi-project/glpi/releases/download/10.0.2/glpi-10.0.2.tgz`

- Extraire l'archive et déplacer GLPI dans le répertoire web :

```bash
sudo tar -xzvf glpi-10.0.2.tgz
sudo mkdir /var/www/glpi.billu.remindme.lan
sudo cp -R glpi/* /var/www/glpi.billu.remindme.lan/
```

- Modifier les droits d'acces sur les fichiers pour que l'utilisateur et le groupe www-data (utilisé par le serveur web Apache) aient les droits nécessaires pour accéder, modifier et exécuter les fichiers. :

```bash
sudo chown -R www-data:www-data /var/www/glpi.billu.remindme.lan/
sudo chmod -R 775 /var/www/glpi.billu.remindme.lan/
```

### Etape 5 : Configuration chemin d'acces du serveur web 

- Èditer le fichier /etc/apache2/sites-available/000-default.conf

- Modifier le chemin de Document Root `DocumentRoot /var/www/glpi.billu.remindme.lan`

Fermer le fichier et redémarrer la machine.

# Connexion au serveur GPLPI sur depuis un client 

Ladresse IP de notre serveur GLPI est 172.19.1.54, voici la procédure pour nous connecter à GLPI depuis notre navigateur web

- Ouvrir notre Navigateur saisir l'URL dans la barre d'adresse du navigateur, entrez http://172.19.1.54/glpi..billu.remindme.lan

 Nous devrions maintenant visualiser la page de connexion de GLPI.

![installation](https://github.com/user-attachments/assets/5c869706-e26d-4596-9e16-30c6e04518ab)

- Suivre les instructions d'installation de GLPI en spécifiant les informations de la base de données MariaDB configurées précédemment.

![selectiondb](https://github.com/user-attachments/assets/4cac5b36-5ba5-45be-b523-21e5a1cdf547)

![setup](https://github.com/user-attachments/assets/72e82b86-3dd7-4746-ad18-defde4deb8b3)

![ok](https://github.com/user-attachments/assets/58c190b1-aa18-413c-9ef9-b7f9a5756be3)

Attention à l'étape 6 se trouve les informations de connexion par défaut à la base de donnée il faut bien les garder et les changer à la premiere connexion.
![password](https://github.com/user-attachments/assets/5732207e-4aee-4ffe-abec-9c4aab9fa8c4)


# Synchronisation AD

### Etape 1 : Synchronisation AD

- Connectez vous en tant que super-admin ( avec compte glpi par défaut) sur l’interface web de GLPI.
  
- Aller dans le menu Configuration > Authentification > Annuaire LDAP![annuaire](https://github.com/user-attachments/assets/01b8dc17-2a65-4eb6-8601-4042722929c2)

- Cliquer sur ajouter en haut à droite de la page ![image](https://github.com/user-attachments/assets/69987452-6e3c-4e8b-acd5-876f8489acb3)

- Remplir les champs suivants 

  ![image](https://github.com/user-attachments/assets/b9971243-f021-43fd-9218-561d1ab33e0e)

•	Nom de l'annuaire : Un nom que vous souhaitez donner à cette configuration, ici Billu

•	Serveur : adresse ip du serveur AD 

•	Base DN : renseignez le Distinguished Name du domaine entier , ici DC=billu,DC=remindme,DC=lan

•	Filtre d'utilisateur : (&(objectClass=user)(sAMAccountName=*)) (filtre standard pour obtenir tous les utilisateurs)

•	Nom d'utilisateur : l’identifiant complet d’un utilisateur ayant les droits d’accès sur le domaine ici administraror@billu.remindme.lan

•	Mot de passe : Le mot de passe de l'administrator.


![image](https://github.com/user-attachments/assets/574dee7e-5534-4712-8937-332a0d6f72f1)

- Cliquez sur Ajouter pour enregistrer la configuration.

Après cet ajout, un test de connexion à l’AD est automatiquement effectué.

La configuration du serveur est terminée. Les utilisateurs du domaine pourront s’identifier directement. Leurs informations seront ajoutées automatiquement à GLPI.

### Etape 2 : Import en masse tous les utilisateurs depuis la BaseDN 

- Aller dans le menu Administration > Utilisateur

- Cliquer sur le bouton Liaison annuaire LDAP.

![image](https://github.com/user-attachments/assets/823bb92b-9b46-4cce-a683-3348d219480c)

- Cliquer sur Importation de nouveaux utilisateurs.

 ![image](https://github.com/user-attachments/assets/74658f81-a33f-4559-a854-2bf9d16716b3)

- Cliquer sur le bouton rechercher

![image](https://github.com/user-attachments/assets/735e7330-d89c-4e25-a466-e14ae181a378)

- Cocher les cases des utilisateurs que vous voulez importer puis menu Actions > Importer.

![import user](https://github.com/user-attachments/assets/3a375842-aa83-4c0e-9cb1-2c57e0c2a3c6)

Les utilisateurs importés depuis l’AD seront disponibles dans GLPI dans le menu .

![image](https://github.com/user-attachments/assets/32c13061-ce26-4e3c-9c7a-1f2a384ec100)

### Etape 3 : Import des groupes 

- Aller dans le menu Administration > Groupes
  
- Cliquer sur le bouton de liaison LDAP

- Cliquez sur « Importation de nouveaux groupes »

GLPI vous proposera en bas de page tous les groupes disponibles dans le BaseDN. Cocher les cases des groupes que vous voulez importer, menu Actions puis Importer.

Les groupes importés depuis l’AD seront disponibles dans GLPI dans le menu .

![image](https://github.com/user-attachments/assets/0790ced0-30e0-4aa9-9666-5a0fd6ce697a)


### Etape 4 : Gestionnaire de ticket

- **Configurer les entités :**  
  - Allez dans **Administration > Entités**.  
  - Ajoutez des entités pour organiser votre support (par exemple, Département A, Département B, etc.).

- **Configurer les catégories de tickets :**  
  - Allez dans **Assistance > Configuration > Catégories**.  
  - Ajoutez des catégories de tickets selon vos besoins (par exemple, Incident, Demande, Maintenance, etc.).

- **Configurer les règles de gestion des tickets :**  
  - Allez dans **Configuration > Règles**.  
  - Créez des règles pour automatiser l’affectation des tickets,  
    la notification ou l’escalade.

- **Configurer les règles de notification :**  
  - Allez dans **Configuration > Notifications**.  
  - Ajoutez des règles de notification pour les tickets (par exemple, notification par e-mail lors de la création d'un ticket, de l'assignation, etc.).

- **Configurer les profils et les droits d'accès :**  
  - Allez dans **Administration > Profils**.  
  - Configurez les profils d'utilisateurs pour définir les droits d'accès (par exemple, Technicien, Demandeur, Administrateur, etc.).

- **Configurer le formulaire de ticket :**  
  - Allez dans **Assistance > Tickets > +**.  
  - Configurez le formulaire de ticket selon vos besoins.  
  - Ajoutez des champs personnalisés.  
  - Définissez des types de demandes, etc.
 

### Etape 5 : Import des ordinateurs AD dans GLPI via une GPO

- **Préparer l'agent GLPI**
   - Téléchargez et préparez l'agent GLPI sur un partage réseau accessible par tous les ordinateurs.

- **Création des GPO pour l’installation de l’agent GLPI**

- GPO 1 : Dossier partagé réseau — Crée un partage réseau contenant l'agent GLPI accessible aux postes clients.
- GPO 2 : Copie de l'agent GLPI en local — Copie l'agent sur chaque poste dans un répertoire local.
- GPO 3 : Exécution de l'agent GLPI — Exécute l'agent localement pour qu'il envoie les informations au serveur GLPI.

- **Déployer la GPO**
   - Lier les GPO à l’unité organisationnelle (OU) contenant les ordinateurs sur lesquels vous souhaitez installer l’agent.
   - Vérifiez que les permissions de la GPO sont correctement définies pour permettre l’application sur les machines cibles.

- **Vérifier l’installation de l’agent GLPI**
   - Sur les ordinateurs clients, l’agent GLPI s’installe automatiquement au prochain démarrage.
   - Vous pouvez vérifier l’installation en consultant les journaux d’événements ou en vérifiant la présence de l'agent dans la liste des applications installées.

- **Importation des ordinateurs dans GLPI**
   - Une fois l'agent installé, les ordinateurs apparaîtront automatiquement dans GLPI, sous la section **Gestion > Ordinateurs**.
   - L’agent communiquera avec le serveur GLPI et enregistrera les informations des machines (nom, adresse IP, matériel, etc.).


### Etape 6 : Test de Connexion et création de ticket depuis un utilisateur AD  : 

-  **Accéder à la page de connexion de GLPI :**
   - Ouvrez votre navigateur et allez sur la page de connexion de GLPI.
   - Vous remarquerez que la page de connexion a changé et permet désormais de se connecter via le domaine Active Directory Billu, en plus de la base de données interne de GLPI.

- **Saisir les informations de connexion :**
   - Dans le champ "Identifiant", entrez l'identifiant d'un utilisateur AD.
   - Dans le champ "Mot de passe", entrez le mot de passe de votre utilisateur AD.
     
- **Valider la connexion :**
   - Cliquez sur le bouton de connexion.
   - Si les informations saisies sont correctes, l'utilisateur sera connecté à GLPI.

- **Accès et profil par défaut :**
   - Une fois connecté, l'utilisateur aura par défaut le profil **"Self-Service"**.
   - Avec ce profil, l'utilisateur pourra :
     - Créer et suivre l’état de ses propres tickets.
     - Accéder à la base de connaissance de GLPI en mode FAQ, si celle-ci est utilisée.

- **Vérification de l’accès :**
   - Vérifiez que l'utilisateur peut bien créer des tickets et consulter les informations de la base de connaissances.

  

# automatisation de l'installation d'AD-DS sur Windows Server Core


## 1-Introduction

### automatisation de l'installation du rôle Active Directory Domain Services (AD-DS) sur un serveur Windows Server Core.
- Objectifs :
        - Installer et configurer AD-DS sur un serveur Windows Server Core.
        - Automatiser le processus pour éviter des erreurs manuelles.
        - Réduire le temps nécessaire pour l’installation et la configuration.
- Pré-requis :
        - Serveur Windows Server Core opérationnel.
        - Accès administrateur local au serveur.
        - Accès réseau au contrôleur de domaine .
        

## 2. Pré-requis techniques

  
- Réseau :
        - IP statique configurée.
        - Connectivité réseau au contrôleur de domaine ou au réseau d’entreprise.
- Logiciels :
        - Windows Server Core avec PowerShell configuré.
        - Rôle Active Directory Domain Services disponible.

## 3. Structure des fichiers

- Scripts PowerShell :
        - Nom du script principal : Install_ADDS.ps1.
        - Description des autres scripts ou fichiers nécessaires.
- Fichier de configuration :
        - Format utilisé : CSV 
        Exemple de contenu :

        ServerName,IPAddress,DNSServer,DomainName,DomainAdmin,DomainPassword
        ServerCore01,172.19.1.10,172.19.1.41,billu.remindme.lan,Administrator,Azerty1*

    Dossier de stockage :
        Exemple : C:\Scripts.
        
## 4. Script PowerShell

- Description du script :
   

# Charger le fichier de configuration
$config = Import-Csv -Path ".\config.csv"

# Extraire les valeurs du fichier
$ServerName = $config.ServerName
    $IPAddress = $config.IPAddress
    $DNSServer = $config.DNSServer
    $DomainName = $config.DomainName
    $DomainAdmin = $config.DomainAdmin
    $DomainPassword = $config.DomainPassword

# Installer le rôle AD-DS
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -Verbose

# Configurer le serveur comme contrôleur de domaine
Install-ADDSForest -DomainName $DomainName -SafeModeAdministratorPassword (ConvertTo-SecureString "P@ssword123" -AsPlainText -Force)

# Redémarrer le serveur
Restart-Computer -Force

- Personnalisation :
        Ajouter des options pour adapter le script selon les besoins (exemple : nom de domaine ou plage IP).

## 5. Étapes d'exécution

- 1ère étape : Copier le fichier de configuration et le script sur le serveur.
- 2e étape : Exécuter le script sur le serveur Core a partir du serveur adds
        Commande :

   Invoke-Command -ComputerName "NomDuServeurCore" -FilePath "C:\Chemin\Vers\NomDuScript.ps1"


- 3e étape : Vérifier l’installation via PowerShell.

    - Commandes :

        Get-WindowsFeature -Name AD-Domain-Services
        Get-ADDomainController

## 6. Vérifications post-installation

- État des rôles installés :
        Commande : Get-WindowsFeature.
- Statut du contrôleur de domaine :
        Commande : Get-ADDomainController.
- Test de connectivité DNS :
        - Commande :

     Resolve-DnsName example.local




















