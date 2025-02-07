


# VoIP FreePBX


## Intro: FreePBX est un outil de communication unifiée. Les utilisateurs seront associés à une extension (ou plusieurs, le cas échéant), ce qui permettra de joindre un utilisateur sur son poste téléphonique.



## Sommaire



2. Installation et Configurations des matériels nécessaires


* Emplacement dans l'infrastructure : LAN
* Base OS : Linux RedHat
* Installation de FreePBX via l'image .iso officielle





## 2. b. Installation et Configuration de FreePBX

### Installation de FreePBX

1. Démarrez la VM.

2. Sélectionnez `FreePBX 16 Installation (Asterisk 18) - Recommanded` et cliquez sur la touche `Entrée`.
![freePBX-01](https://github.com/user-attachments/assets/8ab7ec28-0044-49c2-a9b6-f20b4a423494)



3. Sélectionnez `Graphical Installation - Output to VGA` et cliquez sur la touche `Entrée`.



4. Sélectionnez `FreePBX Standard` et cliquez sur la touche `Entrée`.



5. L'installation est automatique
![freePBX-02](https://github.com/user-attachments/assets/804086a3-6a45-4d43-8092-8c639d2938ca)



6. Une fois l'installation achevée, il est nécessaire de configurer le mot de passe de Root, cliquez sur `Root Password (Root password is not set)`
![freePBX-02](https://github.com/user-attachments/assets/f65e97ee-ae41-45d0-a8bb-cea81fb9cc75)



7. Saisissez le mot de passe et confirmez-le (Attention, le clavier est en anglais) et cliquez sur `Done`.



8. La vignette `Root Password` a changé en `Root password is set`. Cliquez sur `Finish configuration`.



9. Une fois la configuration achevé, cliquez sur `Reboot`.



10. Retirez l'image .iso, redémarrez la VM et connectez en tant que `Root`.
![freePBX](https://github.com/user-attachments/assets/8f41e264-39f0-49e0-9cc6-ab26982541be)


11. Saisissez la commande `localectl`, vous pouvez remarquer que le clavier est toujours en anglais.

```
System Locale: LANG=en_US.UTF-8
    VC Keymap: us
    X11 Layout: us
```

12. Assurez-vous que la langue française est disponible avec la commande `localectl list-locales`, la ligne `fr_FR.utf8` doit être présente.

13. Modifiez la langue du clavier avec les commandes :

```
localectl set-locale LANG=fr_FR.utf8
localectl set-keymap fr
localectl set-x11-keymap fr
```

14. Vérifiez que la langue a bien été prise en compte avec `localectl`. Vous devriez obtenir :

```
System Locale: LANG=fr_FR.UTF-8
    VC Keymap: fr
    X11 Layout: fr
```



### Configuration de FreePBX

1. Remplissez les champs pour vous connecter en tant que `root` puis cliquez sur `Setup System`.



2. Accédez à la partie Administration en cliquant sur `FreePBX Administration` et connectez-vous en `root`.



3. Cliquez sur `Skip`, l'activation interviendra plus tard.



4. Validez les langues en cliquant sur `Submit`.



5. Cliquez sur `Abort`.



6. Cliquez sur `Not Now`. 



7. Vous accédez au Tableau de bord, cliquez sur `Apply Config`.



8. Nous allons désormais procéder à l'activation afin de profiter de l'ensemble des fonctionnalités. Allez dans `Admin` puis `System Admin`.



9. Le message `This machine is not activated` est affiché, cliquez sur `Activation`.



10. Le message change, cliquez sur `Activate`.


11. Cliquez sur `Activate`.



12. Renseignez le champ `Email Address`, les autres champs vont apparaitre. Remplissez les champs nécessaires.



13. Sélectionnez `I use your products and services with my Business(s) and do not want to resell it` et cochez la cas `No` en bas, puis cliquez sur `Create`.



14. Cliquez sur `Activate`.


15. Cliquez sur `Skip` sur toutes les pages Partenaire.

 

16. La fenêtre de mise-à-jour va s'afficher. Cliquez sur `Update Now`



17. Patientez, la mise-à-jour est en cours.



18. De retour sur le Tableau de bord, cliquez sur `Apply Config`.




19. Sur le serveur, saisissez la commande `fwconsole reload --verbose`. Vous pourrez constater les module en erreur. Vous dedvrez réinstaller les modules impactés avec la commande `fwconsole ma install <module>` et les redémarrer avec `fwconsole ma enable <module>`. Retapez la commande `fwconsole reload --verbose` pour vous assurer qu'il n'y a plus d'erreur.



20. De retour sur la page d'Administration sur le Client, cliquez sur `Aply Config` (si nécessaire), puis allez `Admin` > `Modules Admin` > onglet `Modules Updates`. Sur les lignes en status `Disabled; Pending Upgrade to...`, sélectionnez `Upgrade to ... and Enable`. Cliquez sur `Process`.



21. Cliquez sur `Confirm`.



22. Patientez un moment, puis retournez sur le Tableau de bord et cliquez sur `Apply Config`. Réitérez les étapes **20** à **22** si nécessaire (certains modules peuvent avoir plusieurs mise-à-jour consécutives).



23. Si besoin, vous pouvez modifier différents paramètres du serveur depuis le Tableau de bord, `Admin` > `Admin Settings`, comme par exemple le `Hostname`, le `DNS` ou encore le `Network Setting`.



### Création de postes Client VoIP

1. Pour ajouter des utilisateurs et des lignes, allez dans `Applications` > . `Extensions` (Postes en français).



2. Rendez-vous dans l'onglet `SIP [chan_pjsip] Extensions` et cliquez sur `Add New SIP [chan_pjsip]`



3. Remplissez les champs `User Extension` (qui correspond au numéro de ligne), `Display Name`, `Secret` et `Password for New User`. Puis cliquez sur `Submit`, puis `Apply Config`.



4. Réitérez l'étape 3 pour ajouter les utilisateurs nécessaires.



5. Sur ECO-Maximus, téléchargez le fichier d'installation de [3CXPhone](https://3cxphone.software.informer.com/download/) disponible avec l'extension .msi et enregistrez le fichier dans le dossier partagé réservé à l'installation par déploiement via GPO.



6. Ouvrez le `Group Policy Management` et créez une nouvelle GPO sur l'OU `Billu.



7. Clic-droit sur la GPO fraichement créée, puis `Edit` > `Computer Configuration` > `Poilicies` > `Software Settings` > `Software Installation` > `New` > `Package` > sélectionnez `3CXPhone` puis `Open`



8. Désactivez la partie Utilisateur : `Edit` > `Properties` > `Disable User Configuration settings` > `Yes` > `Apply` > `OK`



9. Redémarrez les Clients, pour que la GPO s'applique et que le logiciel soit installé. Il sera nécessaire d'ajouter le raccourci de ``3CXPhone` sur le bureau.



10. Su le Client, cliquez sur `Set accounts` puis `New`. Remplissez les champs comme suit puis cliquez sur `OK`.




11. Pour initier une communication, il faut saisir sur le clavier le numéro de téléphone de votre contact et cliquez sur la touche `Appel`.



12. Vos communications en VoIP sont opérationnelles.
