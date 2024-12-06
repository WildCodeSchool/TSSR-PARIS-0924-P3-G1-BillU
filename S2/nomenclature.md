



# **Nomenclature**

## **Groupes d'utilisateurs et ordinateurs**

| **Departement**              |  **groupe**     | **Utilisateur** (1ère lettre du prénom + nom de famille)             | **Ordinateur**        |
|:----------------|:--------------:|:--------------------------:|:--------------------:|
| **Serveurs Internes(SRV)**     |     | PNOM          |          |
|                                |              | |SRV-PC-<marque>-<ref>            |
| **Communication et RP(CRP)**    |  Relation Médias(RME), Communication interne(CIN), Gestion des marques(GMA)  |       PNOM   |        |
|                                |           | |CRP_PC-<marque>-<ref>           |
| **Département Juridique(DJU)**  |  Propriété intellectuelle(PIN), Droit des sociétés(DSO), Protection des données et conformité(PDC)  | PNOM          |        |
|                                |             | |DJU-PC-<marque>-<ref>           |
| **Développement Logiciel(DLO)**  |  Développement(DEV), analyse et conception(ANC), Test et qualité(TEQ), Recherche et Prototype(RPT) | PNOM         |
  |
|                                |            | |DLO-PC-<marque>-<ref>           |
| **Direction(DIR)**              |    | PNOM         |         |
|                                |           | |DIR-PC-<marque>-<ref>           |
| **DSI**                  |   Exploitation(EXP), Administration Systèmes et Réseaux(ASR), Développement et Intégration(DIN), Support(SUP)   | PNOM          |         |
|                                |            | |DSI-PC-<marque>-<ref>           |
| **Finance et Comptabilité(FCO)**|  Finance(FIN), Service Comptabilité(SCO), Fiscalité(FIS)  | PNOM         |         |
|                                |             | |FCO-PC-<marque>-<ref>           |
| **QHSE (Qualité, Hygiène, Sécurité, Environnement)(QHS)**|Contrôle Qualité(CQL), Gestion environnementale(GEN), Certification(CER) | PNOM        |      |
|                                |            | |QHS-PC-<marque>-<ref>          |
| **Service Commercial(SCO)**    |  ADV, Service achat(ACH), B2B, Service Client(CLI)   | PNOM       |      |
|                                |         | |SCO-PC-<marque>-<ref>        |
| **Service Recrutement(SRH)**  |      | PNOM           |         |
|                                |              | |SRH-PC-<marque>-<ref>            |
| **Invités/Externes(EXT)**      |     | PNOM          |        |
|                                |             | |EXT-PC-<marque>-<ref>           |



## **GPO (Group Policy Objects)**

| **Catégorie**      | **Description**                                                                |
|--------------------|-------------------------------------------------------------------------------|
| **SEC (Sécurité)** | GPOs liées à la sécurité (mots de passe, restrictions d'accès, audit).         |
| **ENV (Environnement)** | GPOs modifiant l'environnement utilisateur (fond d'écran, redirection de dossiers). |
| **NET (Réseau)**   | GPOs liées aux paramètres réseau (proxy, DNS, restrictions d'URL).            |
| **APP (Applications)** | GPOs qui gèrent les applications (déploiement ou restriction).              |
| **ADM (Administration)** | GPOs destinées aux administrateurs (RDP, gestion des permissions).        |



## **Détail des GPOs**

| **Catégorie**       | **cateegorie+ departement+groupe+GPO**                                      |
|---------------------|----------------------------------------------|
| SEC (Sécurité)      | Sec_CRP_MDP-complexe                |
|                     | Sec_DJU_PIN_MDP-expiration              |
|                     | Sec_DIR_MDP_verrouillage-Echec      |
|                     | Sec_TOUS_Verrouillage-inactivité     |
| ENV (Environnement) | ENV_Tous_Réduire-Bureau                      |
|                     | ENV_Tous_Masquer_icônes-Bureau               |
| APP (Applications)  | APP_Tous_Bloquer_install-logiciel            |
| NET (Réseau)        | NET_Tous_Bloquer-site                        |
| ADM (Administration)| ADM_DSI_EXP_Activation-RDP                      |
