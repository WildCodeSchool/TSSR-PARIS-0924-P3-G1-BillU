## Creation d'un serveur Debian avec le role DHCP
**Installer DHCP dans le serveur Debian** 

```bash 
sudo apt install isc-dhcp-server -y
``` 
**Configuration de l'interface réseau**

```bash 
sudo nano /etc/default/isc-dhcp-ser
```

**Ajouter à l'interface**
 
```bash
INTERFACESv4=ens19
``` 

**Configuration du serveur DHCP** 
```bash 
sudo nano /etc/dhcp/dhcp.conf
``` 

**Résultat de la configuation du serveur DHCP**


![Capture d’écran du 2025-02-17 15-07-26](https://github.com/user-attachments/assets/fe7384f4-d2e7-4225-8e17-45b5368bdd7d)


![Capture d’écran du 2025-02-17 15-07-44](https://github.com/user-attachments/assets/aa671091-5f4d-4b83-bec1-992fcf7be282)

**Vérification de la configuration DHCP** 
```bash 
sudo dhcp -t -cf /etc/dhcp/dhcp.conf 
``` 
![Capture d’écran du 2024-12-12 22-44-51](https://github.com/user-attachments/assets/899d635e-5179-4dc4-95c9-181f99bbb1d4)

**Redemarrer le serveur DHCP pour aplliquer les changements**
```bash 
sudo systemctl restart isc-dhcp-server
``` 
**! Attention si le serveur n'est pas démarrer et activez veuillez faire les commandes suivantes :**
```bash 
sudo systemctl start isc-dhcp-server
```
```bash 
sudo systemctl enable isc-dhcp-server
```
**Vérifier l'état du status DHCP** 
```bash 
sudo systemctl status isc-shcp-server
```
![Capture d’écran du 2024-12-12 22-51-03](https://github.com/user-attachments/assets/019021de-bee1-4175-b07d-6c3dde94b6fa)

> Le DHCP est focntionnel 

## Le Serveur Debian DHCP dans le domaine Active Directory Windows server 2022 

> Une fois que les configuration du DHCP sont effectués maintenant il faut le mettre dans le domaine

**Installer le client Kerberos** 

```bash 
sudo apt install krb5-user
``` 

**Configurer Kerberos** 
```bash 
sudo nano /etc/krb5.conf
```
![Capture d’écran du 2024-12-12 22-55-30](https://github.com/user-attachments/assets/1907e73b-9865-4a79-94ec-f2df53855b3e)
![Capture d’écran du 2024-12-12 22-55-41](https://github.com/user-attachments/assets/c6c6432d-7766-459b-a37c-436ffe77e387)
![Capture d’écran du 2024-12-12 22-56-01](https://github.com/user-attachments/assets/c47097aa-0d99-4a58-9c88-c8ab7bed2c6b)

**Installer les outils pour rejoindre le domaine**

```bash 
sudo apt install realmd sssd
``` 

**Joindre le domaine**

```bash
sudo realm join --user=Administrator billu.remindme.lan
``` 
> Puis il faudra fournir le mot de passe de l'Administrator 

**Verifier la configuration Kerberos**
 
```bash 
realm list billu.remindme.lan
```
> Cela montrera que la configuaration kerberos a bel et bien été effectué

**Verifier que la configuration SSSD est correct**

```bash 
sudo nano /etc/sssd/sssd.conf
```

**Mettre à jour le PAM (sans cela le serveur ne pourra rejoindre le domaine)**

```bash 
pam-auth-update --enable mkhomedir
```
**Verfier que le serveur Debian DHCP a bien rejoint le domaine BILLU**
![Capture d’écran du 2024-12-12 22-59-35](https://github.com/user-attachments/assets/4dfa4fc5-cb6d-4f4e-8527-433d4c043eb7)

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


 

