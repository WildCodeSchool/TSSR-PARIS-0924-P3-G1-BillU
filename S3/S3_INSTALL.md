# 

## **Étapes d'installation et de configuration : instruction étape par étape**


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

____________
Dans la fenêtre _Add Servers_:
- Cliquer sur `Find Now`.
- Sélectionner le serveur à ajouter et le passer dans la colonne de droite en cliquant sur la flèche au milieu.

___________
De retour dans le menu _Server Manager_:
Cliquer sur le flag en haut puis _Promote this server to a domain controller_
__________

Cocher l'option de déploiement et le domaine, puuis cliquer `Next`  
_________
- Cocher les capacités du DC (GC ou RODC).
- Si besoin définir le site du serveur.
- Définir le mot de passe de restauration.
- Cliquer `Next`

__________
Arriver à la fenêtre _Additional Options_, sélectionner le serveur à répliquer, puis `Next` 

____________

Arriver sur la fenêtre _Prerequisites Check_, si tout est bon, cliquer sur `Install` 

_____________

Un message confirme l'installation, appuyer sur `Close` 
________________
________________


 

