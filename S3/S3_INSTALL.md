
# **INSTALL GUIDE Infrastructure sécurisée pour BillU**
## _Semaine_10_


## **Besoins initiaux : besoins du projet**

Réalisation d'une infrastructure sécurisé pour l'entreprise BillU. Un domaine AD a été installé et sera complété par un serveur de gestion de mot de passe et un deuxième serveur DC
avec réplication. Gestion automatique des salariés de la société dans le répertoire AD.


## **Choix techniques**

Utilisation de Windows Server 2022 pour le DC supplémentaire. 
Utilisation de Bitwarden pour gérer les mots de passe. 
Utilisation de powershell afin d'automatiser la gestion des utilisateurs AD BillU, OU et groupe.

## **Étapes d'installation et de configuration : instruction étape par étape**

# Installation Bitwarden :
ressources pour installer à partir de proxmox sud Debian format LXC : Docker puis Bitwarden

installer d'abord Docker:

https://docs.docker.com/engine/install/debian/#install-from-a-package

installer ensuite Bitwarden :

https://bitwarden.com/help/install-on-premise-linux/

login : bitwarden

password : Billu2023!

# Installation et configuration du serveur core :

renommer, config réseau ip statique, peut se faire à partir de Sconfig

installer les rôles du serveur :


```batch
Install-WindowsFeature -Name RSAT-AD-Tools -IncludeManagementTools -IncludeAllSubFeature

Install -WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature

install-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature
```
ajout du contrôleur de domaine :

```batch
Install-ADDSDomainController -DomainName "billu.lan" -Credential (Get-Credential)
```
- Redémarrer le serveur.  

test :
```batch
Get-ADDomainController -Identity <server_name>
```
**Intégration du DC à l'AD avec la réplication:**  
 - Sur le serveur AD, aller dans _Server Manager_.  
 - Cliquer sur _Manage_ puis _Add Servers.  
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto%20DC_Core/0.1.png?raw=true)
____________
Dans la fenêtre _Add Servers_:
- Cliquer sur `Find Now`.
- Sélectionner le serveur à ajouter et le passer dans la colonne de droite en cliquant sur la flèche au milieu.
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto%20DC_Core/0.2.png?raw=true)

![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto%20DC_Core/0.3.png?raw=true)
___________
De retour dans le menu _Server Manager_:
Cliquer sur le flag en haut puis _Promote this server to a domain controller_
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto%20DC_Core/0.4.png?raw=true)
__________

Cocher l'option de déploiement et le domaine, puuis cliquer `Next`  
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto%20DC_Core/1.png?raw=true)
_________
- Cocher les capacités du DC (GC ou RODC).
- Si besoin définir le site du serveur.
- Définir le mot de passe de restauration.
- Cliquer `Next`
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto%20DC_Core/2.png?raw=true)

__________
Arriver à la fenêtre _Additional Options_, sélectionner le serveur à répliquer, puis `Next` 
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto%20DC_Core/3.png?raw=true)

____________

Arriver sur la fenêtre _Prerequisites Check_, si tout est bon, cliquer sur `Install` 
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto%20DC_Core/4.png?raw=true)

_____________

Un message confirme l'installation, appuyer sur `Close` 
![](https://github.com/Bilal-Aldimashq/TSSR-Projet3-Groupe_2-BuildYourInfra/blob/main/Resources/Tuto%20DC_Core/5.png?raw=true)

________________
________________


# **Script Powershell gestionad.ps1**

### _Présentation:_ 
Le script gestionad.ps1 permet de créer et gérer le domaine AD de la société BillU.  
Il gère la création d'utilisateur, d'OU, de sous-OU ainsi que des groupes. 
Les Utilisateurs sont automatiquement dirigés dans l'OU dont ils dépendent. 
Il permet également de prendre en compte les informations des utilisateurs et de les renseigner dans la fiche profil.  
Tout ceci est pris en compte suivant les fichiers CSV que le service DRH de l'entreprise fourni .  
Les mise à jour des salariés rentrant et sortant sont aussi géré par le script gestionad.ps1 via le fichier de mise à jour fourni par le service DRH de BillU.

### _Pré-requis:_ 
Pour le bon fonctionnement du script les fichiers csv du service DRH seront stockés sur C:\Users\Administrator\Desktop.

### _Utilisation:_ 
Lancer le script depuis la console Powershell. Il traîtera les fichiers renseigner dans les variables **\$path1** et **\$path2**.  
La variable **\$path1** aura comme chemin le fichier csv en cours d'actualité, et la variable **\$path2** aura le chemin du fichier csv de mise à jour.
Le MAIN du script est composé des fonctions utiles au script:   
- _Verif AD_: Contrôle l'activation du service AD.
- _CreateADForest_: Créé la fôret du domaine.  
- _Create1erOU_: Créé les OU principaux de l'organisation AD.
- _FormatCsv_: Utilise 2 fonctions, NormalizeCsv et RemplaceMot, afin de formater les fichiers csv au format nécessaire à l'utilisation du script.  
- _CreateOU_: Créé les OU intermédiare de l'organisation AD.  
- _DptSrv_: Traîte le champs service qui n'est pas toujours utilisé suivant les utilisateurs.  
- _CreateSousOU_: Créé les sous OU.  
- _CreateSousOUFunction_: Créé les OU les plus bas de l'organisation AD.  
- _Creategrp1_: Créé les groupes 1 de la hiérarchie (Managers et direction).  
- _Creategrp2_: Créé les groupes des différent services.  
- _CreateUser_: Créé les utilisateurs dans AD.     
- _FormatCsv2_: Utilise les fonctions Normalize2 et RemplaceMot2, pour un traitement des fichiers csv nécessaires à la fonction ModifAD.  
- _ModifAD_: Implémente les descriptions des utilisateurs dans la BDD suivant les fichiers csv du service DRH.  
- _Rangement_: Compare les fichiers de mise à jour salariés et traîte les salariés arrivant et sortant de l'entreprise BillU.  

 
## **Difficultés rencontrées : problèmes techniques rencontrés**

- Installation de serveur windows core an tant que controlleur de domaine  
  
- Configuration de Debian LXC comme serveur Bitwarden  

- Adapter les fichiers csv du service DRH au besoins du script gestionda.ps1  

## **Solutions trouvées : Solutions et alternatives trouvées**




## **Tests réalisés : description des tests de performance, de sécurité, etc.**
 - Tests du script suivant les besoins.  
 - Tests ssh entre client et serveur Bitwarden.  


## **Résultats obtenus : ce qui a fonctionné**
- Connexion en ssh
- Script gère les mise à jour salariés, OU et groupe.  
- Server Core intégrer au domaine et la réplication fonctionne.  


## **Améliorations possibles : suggestions d’améliorations futures**
- Journalisation des actions du script AD.
