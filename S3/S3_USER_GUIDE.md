# TSSR-Projet3-Groupe_2-BuildYourInfra
## _Semaine_S3_


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
La variable **\$path1** aura comme chemin le fichier csv en cours d'actualité, et la variable **$path2** aura le chemin du fichier csv de mise à jour.
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
