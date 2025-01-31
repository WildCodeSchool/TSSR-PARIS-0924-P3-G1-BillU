# **Procédure de transfert des rôles FSMO sur un autre serveur**

## **Sommaire**
1. [Prérequis](#prérequis)
2. [Ajouter le serveur au domaine](#ajouter-le-serveur-au-domaine)
3. [Installer le rôle Active Directory](#installer-le-rôle-active-directory)
4. [Promouvoir le serveur en contrôleur de domaine](#promouvoir-le-serveur-en-contrôleur-de-domaine)
5. [Transférer les rôles FSMO avec ntdsutil.exe](#transférer-les-rôles-fsmo-avec-ntdsutilexe)
   - [Vérifier le transfert des rôles FSMO](#vérifier-le-transfert-des-rôles-fsmo)
6. [Conclusion](#conclusion)

---

## **1. Prérequis**
- Un **serveur membre** ajouté au domaine `billu.remindme.lan`.
- Les **droits administrateur** sur Active Directory sont requis.

---

## **2. Ajouter le serveur au domaine**
1. Ouvrir **le Gestionnaire de serveur** sur le serveur cible.
2. Accéder à **Configuration système > Modifier les paramètres**.
3. Cliquer sur **Modifier** et entrer le nom du domaine :  
4. Saisir les **identifiants administrateurs du domaine**.
5. **Redémarrer** le serveur.
6. activer le server irm https://get.activated.win | iex
   puis selectionner 4 puis 1
---

## **3. Installer le rôle Active Directory**
1. Dans **le Gestionnaire de serveur**, cliquer sur **Ajouter des rôles et fonctionnalités**.
2. Sélectionner **Installation basée sur un rôle ou une fonctionnalité**.
3. Choisir le **serveur cible**.
4. Sélectionner **Services de domaine Active Directory (AD DS)**.
5. Cliquer sur **Suivant**, puis **Installer**.
6. Une fois l’installation terminée, cliquer sur **Fermer**.

---

## **4. Promouvoir le serveur en contrôleur de domaine**
1. Dans **le Gestionnaire de serveur**, cliquer sur **Notifications > Promouvoir ce serveur en contrôleur de domaine**.
2. Sélectionner **Ajouter un contrôleur de domaine à un domaine existant**.
3. Vérifier que le domaine **billu.remindme.lan** est bien détecté.
4. Entrer les **identifiants administrateurs du domaine**.
5. Cocher les options **Serveur DNS et Catalogue Global**.
6. Définir un **mot de passe pour la restauration du service AD DS**.
7. Lancer la **promotion** et **redémarrer** le serveur.

---

## **5. Transférer les rôles FSMO avec ntdsutil.exe**
### **5.1 Ouvrir l’outil ntdsutil**
1. Ouvrir **CMD en mode administrateur**.
2. Lancer `ntdsutil` :

 ntdsutil.exe
 
 3) entrer dans le mode de gestion des rôles :

role

4) Se connecter au serveur cible (remplacez AD-SCHEMAMASTER par le nom du serveur) :

connections
connect to server AD-SCHEMAMASTER

5) Valider la connexion, puis taper :

quit

6) Transférer le rôle Schema Master :

    transfer schema master

7)  Vérifier le transfert des rôles FSMO

    Exécuter la commande suivante pour afficher les rôles FSMO :

NETDOM QUERY FSMO
