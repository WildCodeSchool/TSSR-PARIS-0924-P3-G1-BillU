# Procédure de création des GPOs


## Pour installer l'agent GLPI : 

### 1. Créer la GPO pour le partage réseau
- Créer une nouvelle GPO :
    - Sur votre serveur, ouvrez Group Policy Management (GPMC).
    - Clic droit sur Group Policy Objects et sélectionnez New.
    - Donnez un nom à la GPO, par exemple : "GPO - Partage Réseau".
    - Cliquez sur OK.

- Édition de la GPO :



- Lier la GPO à l’OU cible :

    - Faites un clic droit sur l'unité organisationnelle (OU) contenant les ordinateurs cibles, puis sélectionnez Link an Existing GPO.
    - Sélectionnez la GPO "GPO - Partage Réseau" et cliquez sur OK.
 
### 2. Créer la GPO pour créer le dossier ou sera stocker l'agent GLP en local
- Créer une nouvelle GPO :
    - Sur votre serveur, ouvrez Group Policy Management (GPMC).
    - Clic droit sur Group Policy Objects et sélectionnez New.
    - Donnez un nom à la GPO, par exemple : "GPO - Partage Réseau".
    - Cliquez sur OK.

- Édition de la GPO :



- Lier la GPO à l’OU cible :

    - Faites un clic droit sur l'unité organisationnelle (OU) contenant les ordinateurs cibles, puis sélectionnez Link an Existing GPO.
    - Sélectionnez la GPO "GPO - Partage Réseau" et cliquez sur OK.

### 3. Créer la GPO pour copier l'agent GLPI en local
- Créer une nouvelle GPO :

    - Dans Group Policy Management, créez une nouvelle GPO (par exemple : "GPO - Copie Agent GLPI").
    - Cliquez sur OK.

- Édition de la GPO :
    - Faites un clic droit sur la GPO nouvellement créée et sélectionnez Edit.
    - Dans l’écran de l’éditeur de stratégies de groupe, développez le dossier de configuration de l’ordinateur et recherchez l’élément suivant.
`Computer Configuration > Preferences > Windows Settings > Folders
    -Créez un nouveau dossier.
Sur l’onglet Général, effectuez la configuration suivante.

• Action – Mise à jour.
• Chemin – Entrez le chemin vers le dossier.

Cliquez sur le bouton OK.`

- Lier la GPO à l’OU cible :

    - Retournez dans Group Policy Management et liez cette GPO à l’OU contenant les ordinateurs cibles.

### 4. Créer la GPO pour executer l'agent GLPI

- Créer une nouvelle GPO :

    - Créez une nouvelle GPO (par exemple : "GPO - Exécution Agent GLPI").
    - Cliquez sur OK.

- Édition de la GPO :

    - Faites un clic droit sur la GPO nouvellement créée et sélectionnez Edit.
    - Dans l’écran de l’éditeur de stratégies de groupe, développez le dossier de configuration de l’ordinateur et recherchez l’élément suivant.
`Computer Configuration > Policies > Software Settings > Software installation`
    - Cliquez avec le bouton droit sur le dossier d’installation du logiciel et sélectionnez l’option pour ajouter un package.
    - Sélectionnez l'exécutable de l'agent GLPI installé localement sur le poste (par exemple : C:\Program Files\GLPI\agent_glpi_installer.msi).
    - Sélectionnez l’option ASSIGNÉ.
    - Fermez l’éditeur de GPO et retournez dans Group Policy Management.

- Lier la GPO à l’OU cible :

    - Retournez dans Group Policy Management et liez cette GPO à l’OU contenant les ordinateurs cibles.

### 5. Déployer la GPO
Une fois les GPOs créées et liées aux bonnes unités organisationnelles, vous pouvez forcer l'application des GPOs avec la commande suivante sur les postes cibles :
`gpupdate /force`
Vous pouvez également redémarrer les machines pour que les GPOs soient appliquées.
