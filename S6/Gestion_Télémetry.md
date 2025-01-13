
                                                    # Gestion de Télémetry #
## 1. Désactivez l'évaluateur de compatibilité Microsoft via le planificateur de tâches 
 Microsoft Compatibility Appraiser analyse les fichiers d'application Windows 10/11 résidant sur l'ordinateur pour évaluer leur compatibilité avec Windows 10 si une mise à niveau est effectuée.
Pour résoudre votre problème, vous pouvez désactiver ce service depuis le Planificateur de tâches en suivant les étapes ci-dessous :
### Étape 1. Cliquez sur Démarrer, tapez Planificateur de tâches, puis appuyez sur Entrée.
### Étape 2. Dans la fenêtre TaskScheduler, accédez à ce chemin : Task Scheduler Library\Microsoft\Windows\Application Experience.
Étape 3. Dans le dossier Application Experience, recherchez « Microsoft Compatibility Appraiser ».
Étape 4. Faites un clic droit dessus, sélectionnez « Désactiver », puis confirmez pour terminer le processus. Ensuite, vérifiez si le problème persiste. 

![1](https://github.com/user-attachments/assets/9b3f54ec-175d-4161-92aa-7c705545b079)

## 2. Désactivez la télémétrie de compatibilité Windows via l'éditeur de stratégie de groupe
Étape 1. Appuyez sur la touche du logo Windows + R, puis tapez gpedit.msc et cliquez sur « OK ».
Étape 2. Accédez à « Configuration ordinateur > Modèles d'administration > Composants Windows > 
Collecte des données et versions d'évaluation Preview ».

![2](https://github.com/user-attachments/assets/7cd8f748-f4c7-4ccd-9911-ec1d8b468839)

## Étape 3. Double-cliquez sur « Autoriser la télémétrie ». Sélectionnez « Désactivé », puis cliquez sur « OK ».  

![3](https://github.com/user-attachments/assets/9e98afb7-0963-4413-a78d-c74649931544)

Maintenant, vous pouvez accéder à votre gestionnaire de tâches pour vérifier si cela fonctionne ou non. 
Si cela ne fonctionne pas très bien, optez pour la deuxième solution.
## 3. Désactivez la télémétrie de compatibilité Microsoft à l'aide de l'Éditeur du Registre
Étape 1. Appuyez sur les touches Windows + R, puis tapez regedit dans la case et cliquez sur « OK ». 
Cliquez sur "OUI" lorsque vous y êtes invité par le contrôle de compte d'utilisateur.
Étape 2. Accédez à « HKEY_LOCAL_MACHINE > SOFTWARE > Policies > Microsoft > Windows > DataCollection ».

![4](https://github.com/user-attachments/assets/6f21cbfc-e64a-47d3-8b38-7821ced4b3be)

Faites un clic droit sur « DataCollection » et choisissez « Nouveau > Valeur DWORD (32 bits) ».
Nommez ensuite la nouvelle valeur Allow Telemetry, puis double-cliquez sur « Allow Télémétry ».
## Étape 4. Définissez la date de valeur sur 0 (zéro) et cliquez sur « OK ».

![5](https://github.com/user-attachments/assets/dfb442c3-413d-4c8c-a3b6-e3655475307e)

## Etape 5. Sous Windows 10 et 11, il existe plusieurs services Windows liés à la télémétrie, dont le service DiagTrack qui était déjà présent sous Windows 7. 
Dans la liste des services Windows, repérez le service "Expériences des utilisateurs connectés et télémétrie" et faites un double clic sur celui-ci.

![6](https://github.com/user-attachments/assets/941510ba-f28a-4133-8030-35ca23959781)

## Etape 6. Désactivez ce service DiagTrack et cliquez sur le bouton : Appliquer.
Ensuite, arrêtez-le.
![7](https://github.com/user-attachments/assets/f8f0cc64-2161-4309-8bcd-8843e2aff196)

## Etape 7. Le service suivant s'appelle : Service de rapport d'erreurs Windows.
Ce service permet à Windows de collecter des données sur votre ordinateur lorsqu'un programme plante sur votre ordinateur pour les envoyer à Microsoft.

![8](https://github.com/user-attachments/assets/de794841-6244-460c-ae51-56dc51ef116d)

## Etape 8. Le vrai nom de ce service est : WerSvc.
Désactivez-le, puis arrêtez le service.
#### Attention : la désactivation de ce service empêchera la fonctionnalité "Rapport d'erreurs Windows" de fonctionner. 

![9](https://github.com/user-attachments/assets/02d49623-f3b0-48b3-86bd-935e0a424e13)


## Etape 9. Suite à des recherches sur Internet, il existe aussi un service nommé "Service de routage de messages Push du protocole WAP (Wireless Application Protocol) de gestion des appareils" 
qui collecte aussi des données sur votre ordinateur.

![10](https://github.com/user-attachments/assets/1cd86638-99d1-464f-83d0-41753e49d87c)

Le vrai nom de service est : dmwappushservice.

![image](https://github.com/user-attachments/assets/b9956b59-7228-4204-86bd-2f674c7b7e64)

## Outre la désactivation de l'option de télémétrie de compatibilité Windows, vous pouvez également vous débarrasser de l'utilisation élevée du disque de la télémétrie de compatibilité Microsoft ou du problème du processeur en supprimant CompatTelRunner.exe. 
Cette méthode nécessite que vous vous connectiez à votre ordinateur en utilisant le compte d'administrateur dont vous êtes propriétaire.
Voici les guides étape par étape.
#### Étape 1. Tapez CompatTelRunner dans la zone de recherche. Faites un clic droit sur CompatTelRunner et sélectionnez « Ouvrir l'emplacement du fichier ».
#### Étape 2. Cliquez avec le bouton droit sur CompatTelRunner.exe et choisissez « Propriétés ». Passez à l'onglet Sécurité et cliquez sur « Avancé ». Cliquez sur le bouton « Modifier » à côté du propriétaire.
#### Étape 3. Cliquez sur « Avancé » > « Rechercher maintenant ». Faites défiler vers le bas pour sélectionner le compte que vous utilisez actuellement et cliquez sur « OK ». Ensuite, cliquez sur « Appliquer » et cliquez sur « OK » lorsqu'une fenêtre de note apparaît.

![11](https://github.com/user-attachments/assets/a2e68bb7-d49d-4497-b158-916c54da76c9)

### Étape 4. Ensuite, vous devez modifier les paramètres d'autorisation. Cliquez avec le bouton droit sur le fichier CompatTelRunner.exe et ouvrez à nouveau « Propriétés ». Allez dans « Sécurité > « Avancé » > Sélectionnez un utilisateur dans une liste > Modifier ». 
Dans la nouvelle fenêtre pop-up, sélectionnez « Contrôle total » et cliquez sur « OK ». Cliquez ensuite sur « Appliquer » et « OK ».
### Étape 5. Vous avez désormais le contrôle total de votre ordinateur. Cliquez avec le bouton droit sur le fichier CompatTelRunner.exe et choisissez « Supprimer ».

![12](https://github.com/user-attachments/assets/c3706389-e782-4a60-92c6-4e724ecc3ae8)

La télémétrie de compatibilité Microsoft est liée à la mise à jour de Windows 10. Si vous obtenez les dernières mises à jour, vous pouvez résoudre votre problème.
### Étape 1. Cliquez sur l'icône « Démarrer ».
### Étape 2. Accédez à « Paramètres > Paramètres de mise à jour et de sécurité > Windows Update ». Téléchargez et installez la nouvelle mise à jour.

![13](https://github.com/user-attachments/assets/9d8471d9-169b-4fd7-8115-351011df3873)



