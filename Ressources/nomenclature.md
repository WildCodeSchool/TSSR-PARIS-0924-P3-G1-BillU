
                                           NOMENCLATURE


**les vm**


Le nom de VM est crée de la manière suivante :
G<x>-<Nomdelavm><rôle>

1) G1-Wserver2022-DHCP
2)  G1- Wserver2022-ADDS : 172.19.1.41
3)  G1-WServer-Exchange ou Cloud Microsoft365
4) G1-Linux-Apache-Serveurweb
5) G1-BackupServeur
6) G1-Firewall
7) Debian : 172.19.1.49

   

**les CT**

G<x>-<Nomduct><rôle>

les Utilisateurs

ID Utilisateur : Premierlettreduprénom. nomdefamille 
Ex : Alban Dumas = adumas
Adresse e-mail : prenom.nom@ BillU.fr
Ex : Alban Dumas = alban.dumas@BillU.fr




**les Ordinateurs**

(Departement_Type d'appareil_MarquePC_NomduPC) en sachant que nous avons 9 départements

                                          -Département-
| Département                       | Raccourcis |
|------------------------------------|------------|
| Communication et Relations publiques | CRP        |
| Département Juridique              | DJU        |
| Développement logiciel             | DLO        |
| Direction                          | DIR        |
| DSI                                | DSI        |
| Finance et Comptabilité            | FCO        |
| QHSE                               | QHS        |
| Service Commercial                 | SCO        |
| Service recrutement                | SRE        |
| Serveur                            | SRV        |
                                        - MArque des PC -
TOSHIBA TOSH
LENOVO LNVO


                                      - Type d’appareil - 

1) DESKTOP : pour un ordinateur de bureau
2) PC : pour un ordinateur portable
3) PRINT: pour une imprimante
4) SVR: pour un serveur
5) TEL: téléphone

Ex pour Alban Dumas : CRP-PC-HP-PA78671

**les Équipements réseau**

Routeur Principal (Router0paris)
Routeur de Secours (Router1paris)
Switch 1 (switch0paris)
Switch 2 (switch1paris)
Switch 3 (switch2paris)
Point d’acces wifi
Serveur VPN





# **Nomenclature**

## **Groupes d'utilisateurs et ordinateurs**

| **Département**                               | **Groupe**                                                                                     | **Utilisateur** (1ère lettre du prénom + nom de famille) | **Ordinateur+marque+ref**           |
|:---------------------------------------------|:---------------------------------------------------------------------------------------------:|:-------------------------------------------------------:|:-------------------------:|
| **Serveurs Internes (SRV)**                  |                                                                                               | PNOM                                  | SRV-PC-<marque>-<ref>    |
| **Communication et RP (CRP)**                | Relation Médias (RME), Communication interne (CIN), Gestion des marques (GMA)                | PNOM                                                   | CRP-PC-<marque>-<ref>    |
| **Département Juridique (DJU)**              | Propriété intellectuelle (PIN), Droit des sociétés (DSO), Protection des données et conformité (PDC) | PNOM                                                   | DJU-PC-<marque>-<ref>    |
| **Développement Logiciel (DLO)**             | Développement (DEV), Analyse et conception (ANC), Test et qualité (TEQ), Recherche et Prototype (RPT) | PNOM                                                   | DLO-PC-<marque>-<ref>    |
| **Direction (DIR)**                          |                                                                                               | PNOM                                                   | DIR-PC-<marque>-<ref>    |
| **DSI**                                      | Exploitation (EXP), Administration Systèmes et Réseaux (ASR), Développement et Intégration (DIN), Support (SUP) | PNOM                                                   | DSI-PC-<marque>-<ref>    |
| **Finance et Comptabilité (FCO)**            | Finance (FIN), Service Comptabilité (SCO), Fiscalité (FIS)                                    | PNOM                                                   | FCO-PC-<marque>-<ref>    |
| **QHSE (Qualité, Hygiène, Sécurité, Environnement) (QHS)** | Contrôle Qualité (CQL), Gestion environnementale (GEN), Certification (CER)                   | PNOM                                                   | QHS-PC-<marque>-<ref>    |
| **Service Commercial (SCO)**                 | ADV, Service achat (ACH), B2B, Service Client (CLI)                                           | PNOM                                                   | SCO-PC-<marque>-<ref>    |
| **Service Recrutement (SRH)**                |                                                                                               | PNOM                                                   | SRH-PC-<marque>-<ref>    |
| **Invités/Externes (EXT)**                   |                                                                                               | PNOM                                                   | EXT-PC-<marque>-<ref>    |


## **Serveurs de l'infrastructure**

| **Nom du Serveur**        | **Rôle**                                                                                          | **Adresse IP**  |
|:--------------------------|:-------------------------------------------------------------------------------------------------:|:---------------:|
| G1-Wserver2022-ADDS       | Le serveur Active Directory (ADDS) gère les comptes utilisateurs, les groupes et le DNS pour la société.| 172.19.1.41     |
| G1-Debian-DHCP            | Le serveur DHCP attribue automatiquement des adresses IP en fonction des plages par département.         | 172.19.1.48     |
| G1-WserverCore-ADDS       | Serveur ADDS sans GUI : Backup du serveur Active Directory, accessible uniquement à distance           | 172.19.1.56     |



## **GPO (Group Policy Objects)**

| **Catégorie**      | **Description**                                                                |
|--------------------|-------------------------------------------------------------------------------|
| **SEC (Sécurité)** | GPOs liées à la sécurité (mots de passe, restrictions d'accès, audit).         |
| **ENV (Environnement)** | GPOs modifiant l'environnement utilisateur (fond d'écran, redirection de dossiers). |
| **NET (Réseau)**   | GPOs liées aux paramètres réseau (proxy, DNS, restrictions d'URL).            |
| **APP (Applications)** | GPOs qui gèrent les applications (déploiement ou restriction).              |
| **ADM (Administration)** | GPOs destinées aux administrateurs (RDP, gestion des permissions).        |



## **Détail des GPOs**

| **Catégorie**       | **categorie+ departement+groupe+GPO**                                      |
|---------------------|----------------------------------------------|
| SEC (Sécurité)      | Sec_CRP_MDP-complexe                |
|                     | Sec_DJU_PIN_MDP-expiration              |
|                     | Sec_DIR_MDP-verrouillage-Echec      |
|                     | Sec_TOUS_Verrouillage-inactivité     |
| ENV (Environnement) | ENV_Tous_Réduire-Bureau                      |
|                     | ENV_Tous_Masquer-icônes-Bureau               |
| APP (Applications)  | APP_Tous_Bloquer-install-logiciel            |
| NET (Réseau)        | NET_Tous_Bloquer-site                        |
| ADM (Administration)| ADM_DSI_EXP_Activation-RDP                      |
