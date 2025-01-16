# Sommaire de la procédure

---

## **Partie 1 : Configuration RAID 1**

### 1. Accéder au Gestionnaire de disques
- Ouvrir le Gestionnaire de disques via le menu Windows.

### 2. Créer des partitions (I, J, K)
- Partitionner les disques en volumes avec des lettres spécifiques.

### 3. Convertir les disques en disques dynamiques
- Préparer les disques pour la mise en place d’un RAID logiciel.

### 4. Configurer les volumes en miroir (RAID 1)
- Configurer le RAID 1 pour chaque partition (I, J, K).

### 5. Vérifier la configuration
- Contrôler l’état des partitions en miroir via le Gestionnaire de disques.

### 6. Tester la redondance
- Déconnecter un disque pour valider la continuité des données.

---

## **Partie 2 : Dossier de partage**

### 1. Préparation Initiale
- Vérification et formatage des disques I, J, K.
- Création des dossiers racines.

### 2. Configuration du Dossier "Individuel" (I:)
- Définir les permissions manuellement.
- Utilisation d’un script PowerShell pour automatiser la création et configuration des sous-dossiers.

### 3. Configuration du Dossier "Services" (J:)
- Définir les permissions manuelles.
- Utilisation d’un script PowerShell pour configurer des sous-dossiers par service.

### 4. Configuration du Dossier "Départements" (K:)
- Définir les permissions manuelles.
- Utilisation d’un script PowerShell pour configurer des sous-dossiers par département.

---

## **Remarques générales**
- **RAID 1** assure une redondance pour la sécurité des données mais ne remplace pas une sauvegarde externe.
- Les permissions doivent être soigneusement configurées pour garantir la sécurité et l’accès approprié des utilisateurs.


# configuration Raid 1
### **1. Accéder au Gestionnaire de disques**
1. Faites un clic droit sur le logo **Windows** (menu Démarrer).
2. Cliquez sur **Disk Management** (Gestion des disques) pour ouvrir l'outil de gestion des disques.

---

### **2. Créer des partitions (I, J, K)**
1. Sélectionnez le disque que vous voulez partitionner (exemple : Disk 0).
2. Faites un clic droit sur l'espace non alloué et choisissez **New Simple Volume**.
3. Dans l'assistant qui s'ouvre :
   - Cliquez sur **Next**.
   - Spécifiez la taille de la partition.
   - Attribuez une lettre de lecteur (**I** pour la première partition).
   - Formatez la partition en **NTFS** et donnez-lui un nom, par exemple "Dossier Individuel".
   - Cliquez sur **Finish**.
4. Répétez cette procédure pour créer deux autres partitions :
   - Partition **J**, avec le label "Dossier Services".
   - Partition **K**, avec le label "Dossier Départements".

---

### **3. Convertir les disques en disques dynamiques**
1. Faites un clic droit sur **Disk 0** et **Disk 1** (les disques où vous voulez configurer le RAID).
2. Sélectionnez **Convert to Dynamic Disk**.
3. Suivez l’assistant pour convertir les deux disques en **Dynamic Disks**.

---

### **4. Configurer les volumes en miroir (RAID 1)**
1. Faites un clic droit sur la partition **I** de **Disk 0** (Dossier Individuel).
2. Sélectionnez **Add Mirror**.
3. Dans la liste des disques disponibles, sélectionnez la partition correspondante sur **Disk 1** (I de Disk 1).
4. Cliquez sur **OK** pour démarrer le processus de mise en miroir.
5. Répétez cette procédure pour les partitions **J** et **K** :
   - **J** sur Disk 0 avec **J** sur Disk 1.
   - **K** sur Disk 0 avec **K** sur Disk 1.

---

### **5. Vérifier la configuration**
1. Dans le **Gestionnaire de disques**, vous devriez voir les partitions **I**, **J**, et **K** apparaître comme des **Mirrored Volumes**.
2. Chaque volume doit afficher l’état **Healthy**, indiquant que la redondance est active.

---

### **6. Test de redondance**
1. Déconnectez temporairement l’un des disques dans le **BIOS** ou via le Gestionnaire de disques.
2. Vérifiez que les données restent accessibles à partir de l’autre disque.
3. Si tout fonctionne correctement, reconnectez le disque et synchronisez à nouveau si nécessaire.

---

### Remarque importante :
- **RAID 1** assure une redondance pour les données, mais il n’est pas une solution de sauvegarde. En cas de suppression ou de corruption de données, le problème est immédiatement reflété sur le miroir.
- Pensez à maintenir des sauvegardes régulières sur un autre support pour une sécurité optimale.

Si vous avez d'autres questions ou besoin d'aide pour un script ou une automatisation, faites-moi savoir ! 😊

# **Dossier de partage**

## Mettre en place des dossiers réseaux pour les utilisateur

### **1. Préparation Initiale**

#### **1.1. Vérification et préparation des disques**
- Assurez-vous que les disques **I:**, **J:**, et **K:** sont disponibles et formatés.
- Créez les dossiers racines pour chaque catégorie si cela n’est pas déjà fait :
  - `I:\Individuel`
  - `J:\Services`
  - `K:\Departements`

---

### **2. Configuration du Dossier "Individuel" (I:)**

#### **2.1. Configuration manuelle**
1. Ouvrez l’**Explorateur de fichiers**.
2. Cliquez droit sur **I:\Individuel** > **Propriétés** > **Onglet Sécurité**.
3. Ajoutez les permissions suivantes :
   - **Users (BILLU\Users)** : Autorisez uniquement :
     - **Read & Execute** (Lire et exécuter)
     - **List Folder Contents** (Lister le contenu des dossiers)
   - **Administrators (BILLU\Administrators)** : Full Control.
   - **SYSTEM** : Full Control.

4. Cliquez sur **Avancé** et activez l’héritage pour permettre aux sous-dossiers de bénéficier des permissions de la racine.

#### **2.2. Script PowerShell pour créer et configurer les sous-dossiers**
Le script suivant automatise la création des sous-dossiers pour chaque utilisateur et configure les permissions.

```powershell
# Variables
$BasePath = "I:\Individuel"  # Dossier racine
$Users = Get-ADUser -Filter *  # Récupère tous les utilisateurs AD

# Boucle pour chaque utilisateur
foreach ($User in $Users) {
    $UserFolder = Join-Path $BasePath $User.SamAccountName

    # Créer le dossier si inexistant
    if (-Not (Test-Path $UserFolder)) {
        New-Item -Path $UserFolder -ItemType Directory
        Write-Host "Dossier créé pour : $($User.SamAccountName)"
    }

    # Configurer les permissions
    icacls $UserFolder /inheritance:d  # Désactiver l'héritage
    icacls $UserFolder /grant "${env:USERDOMAIN}\$($User.SamAccountName):(OI)(CI)F"  # Full Control pour l'utilisateur
    icacls $UserFolder /grant "Administrators:(OI)(CI)F"  # Full Control pour les administrateurs
    icacls $UserFolder /grant "SYSTEM:(OI)(CI)F"  # Full Control pour le système
}

Write-Host "Configuration des dossiers 'Individuel' terminée."
```

---

### **3. Configuration du Dossier "Services" (J:)**

#### **3.1. Configuration manuelle**
1. Créez le dossier `J:\Services` si cela n’a pas encore été fait.
2. Cliquez droit sur **J:\Services** > **Propriétés** > **Onglet Sécurité**.
3. Ajoutez les permissions suivantes :
   - **Users (BILLU\Users)** : Autorisez uniquement :
     - **Read & Execute** (Lire et exécuter)
     - **List Folder Contents** (Lister le contenu des dossiers)
   - **Administrators (BILLU\Administrators)** : Full Control.
   - **SYSTEM** : Full Control.

#### **3.2. Script PowerShell pour créer les dossiers et configurer les permissions**
Le script suivant crée un sous-dossier pour chaque service et configure les permissions.

```powershell
# Variables
$BasePath = "J:\Services"  # Dossier racine
$Groups = Get-ADGroup -Filter * | Where-Object { $_.Name -like "User-*" }  # Récupère tous les groupes de services

# Boucle pour chaque groupe
foreach ($Group in $Groups) {
    $GroupFolder = Join-Path $BasePath $Group.SamAccountName

    # Créer le dossier si inexistant
    if (-Not (Test-Path $GroupFolder)) {
        New-Item -Path $GroupFolder -ItemType Directory
        Write-Host "Dossier créé pour : $($Group.SamAccountName)"
    }

    # Configurer les permissions
    icacls $GroupFolder /inheritance:d  # Désactiver l'héritage
    icacls $GroupFolder /grant "${env:USERDOMAIN}\$($Group.SamAccountName):(OI)(CI)F"  # Full Control pour le groupe
    icacls $GroupFolder /grant "Administrators:(OI)(CI)F"  # Full Control pour les administrateurs
    icacls $GroupFolder /grant "SYSTEM:(OI)(CI)F"  # Full Control pour le système
}

Write-Host "Configuration des dossiers 'Services' terminée."
```

---

### **4. Configuration du Dossier "Départements" (K:)**

#### **4.1. Configuration manuelle**
1. Créez le dossier `K:\Departements` si cela n’a pas encore été fait.
2. Cliquez droit sur **K:\Departements** > **Propriétés** > **Onglet Sécurité**.
3. Ajoutez les permissions suivantes :
   - **Users (BILLU\Users)** : Autorisez uniquement :
     - **Read & Execute** (Lire et exécuter)
     - **List Folder Contents** (Lister le contenu des dossiers)
   - **Administrators (BILLU\Administrators)** : Full Control.
   - **SYSTEM** : Full Control.

#### **4.2. Script PowerShell pour créer les dossiers et configurer les permissions**
Le script suivant crée un sous-dossier pour chaque département et configure les permissions.

```powershell
# Variables
$BasePath = "K:\Departements"  # Dossier racine
$Groups = Get-ADGroup -Filter * | Where-Object { $_.Name -like "*Departement*" }  # Récupère tous les groupes de départements

# Boucle pour chaque groupe
foreach ($Group in $Groups) {
    $GroupFolder = Join-Path $BasePath $Group.SamAccountName

    # Créer le dossier si inexistant
    if (-Not (Test-Path $GroupFolder)) {
        New-Item -Path $GroupFolder -ItemType Directory
        Write-Host "Dossier créé pour : $($Group.SamAccountName)"
    }

    # Configurer les permissions
    icacls $GroupFolder /inheritance:d  # Désactiver l'héritage
    icacls $GroupFolder /grant "${env:USERDOMAIN}\$($Group.SamAccountName):(OI)(CI)F"  # Full Control pour le groupe
    icacls $GroupFolder /grant "Administrators:(OI)(CI)F"  # Full Control pour les administrateurs
    icacls $GroupFolder /grant "SYSTEM:(OI)(CI)F"  # Full Control pour le système
}

Write-Host "Configuration des dossiers 'Départements' terminée."
```






