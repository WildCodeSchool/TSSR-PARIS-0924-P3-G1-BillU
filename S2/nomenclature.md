


# **Nomenclature**

## **Groupes d'utilisateurs et ordinateurs**

| **Groupe**                     | **Utilisateur**             | **Ordinateur**        |
|:------------------------------:|:---------------------------:|:--------------------:|
| **Serveurs Internes**          | SI_AccèsStandard           | SI_PcStandard         |
|                                | SI_AccèsAvancé             | SI_PcAdmin            |
| **Communication et RP**        | COM_AccèsStandard          | COM_PcStandard        |
|                                | COM_AccèsAvancé            | COM_PcAdmin           |
| **Département Juridique**      | JUR_AccèsStandard          | JUR_PcStandard        |
|                                | JUR_AccèsAvancé            | JUR_PcAdmin           |
| **Développement Logiciel**     | DEV_AccèsStandard          | DEV_PcStandard        |
|                                | DEV_AccèsAvancé            | DEV_PcAdmin           |
| **Direction**                  | DIR_AccèsStandard          | DIR_PcStandard        |
|                                | DIR_AccèsAvancé            | DIR_PcAdmin           |
| **DSI**                        | DSI_AccèsStandard          | DSI_PcStandard        |
|                                | DSI_AccèsAvancé            | DSI_PcAdmin           |
| **Finance et Comptabilité**    | FIN_AccèsStandard          | FIN_PcStandard        |
|                                | FIN_AccèsAvancé            | FIN_PcAdmin           |
| **QHSE (Qualité, Hygiène, Sécurité, Environnement)** | QHSE_AccèsStandard        | QHSE_PcStandard      |
|                                | QHSE_AccèsAvancé           | QHSE_PcAdmin          |
| **Service Commercial**         | COMMER_AccèsStandard       | COMMER_PcStandard     |
|                                | COMMER_AccèsAvancé         | COMMER_PcAdmin        |
| **Service Recrutement**        | RH_AccèsStandard           | RH_PcStandard         |
|                                | RH_AccèsAvancé             | RH_PcAdmin            |
| **Invités/Externes**           | EXT_AccèsStandard          | EXT_PcStandard        |
|                                | EXT_AccèsAvancé            | EXT_PcAdmin           |



## **GPO (Group Policy Objects)**

| **Catégorie**      | **Description**                                                                |
|--------------------|-------------------------------------------------------------------------------|
| **SEC (Sécurité)** | GPOs liées à la sécurité (mots de passe, restrictions d'accès, audit).         |
| **ENV (Environnement)** | GPOs modifiant l'environnement utilisateur (fond d'écran, redirection de dossiers). |
| **NET (Réseau)**   | GPOs liées aux paramètres réseau (proxy, DNS, restrictions d'URL).            |
| **APP (Applications)** | GPOs qui gèrent les applications (déploiement ou restriction).              |
| **ADM (Administration)** | GPOs destinées aux administrateurs (RDP, gestion des permissions).        |



## **Détail des GPOs**

| **Catégorie**       | **GPO**                                      |
|---------------------|----------------------------------------------|
| SEC (Sécurité)      | Sec_Comptabilité_MDP_complexe                |
|                     | Sec_Comptabilité_MDP_expiration              |
|                     | Sec_Comptabilité_MDP_verrouillage_Echec      |
|                     | Sec_Comptabilité_Verrouillage_inactivité     |
| ENV (Environnement) | ENV_Tous_Réduire_Bureau                      |
|                     | ENV_Tous_Masquer_icônes_Bureau               |
| APP (Applications)  | APP_Tous_Bloquer_install_logiciel            |
| NET (Réseau)        | NET_Tous_Bloquer_site                        |
| ADM (Administration)| ADM_DSI_Activation_RDP                      |
