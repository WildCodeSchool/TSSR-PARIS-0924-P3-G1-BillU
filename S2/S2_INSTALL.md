#S2
## Creation d'Un serveur Windows Server 2022 GUI avec les rôles AD-DS, DNS
procedure à noter

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
![Capture d’écran du 2024-12-12 22-39-51](https://github.com/user-attachments/assets/56ba87d5-06e2-42d6-abd5-7641a7ab25e7)
![Capture d’écran du 2024-12-12 22-40-11](https://github.com/user-attachments/assets/dc71b5e7-dc2a-4288-a240-62eef251f386)
![Capture d’écran du 2024-12-12 22-40-24](https://github.com/user-attachments/assets/5035f094-4ce4-44dc-b4ff-39fc943b503c)

**Vérification de la configuration DHCP** 
```bash 
sudo nano dhcp -t -cf /etc/dhcp/dhcp.conf 
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


## Creation d'un serveur Windows Server 2022 Core avec le rôle AD-DS
procedure à noter

## Création d'une VM Serveur Linux Debian 
procedure à noter

## Création d'une VM client Windows10 avec GUI sur le domaine AD
procedure à noter

## Mise en place du SSH sur le serveur Debian et le client Windows10
procedure à noter

## Création  l'organigramme de la société

## Creation des scripts pour l'automatisation : (voir ressource)
- la création auto des OU
- la création auto des groupes
- la création auto des utilisateurs
- la création auto des ordinateurs
  
  
