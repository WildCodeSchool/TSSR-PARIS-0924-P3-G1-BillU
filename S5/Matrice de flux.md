# Régles de gestion des alias

## Alias IP

| Firewall Alias      | Type        | IP(s)                   | Description                                 |
|---------------------|-------------|-------------------------|---------------------------------------------|
| AdminAccount        | Host(s)     | 172.19.1.41, 172.19.50.57 | PC pouvant accéder à pfsense                |
| DMZ_Subnet          | Network(s)  | 10.19.0.0/16             | Réseau de la DMZ                            |
| Lan_Commercial      | Network(s)  | 172.19.80.0/24           | Département Commercial                      |
| Lan_Communication   | Network(s)  | 172.19.10.0/24           | Département Communication et RP             |
| Lan_Direction       | Network(s)  | 172.19.40.0/32           | Département Direction                       |
| Lan_DSI             | Network(s)  | 172.19.50.0/24           | Département DSI                            |
| Lan_Externe         | Network(s)  | 172.19.100.0/24          | Réseaux dédiés aux externes                 |
| Lan_Finance         | Network(s)  | 172.19.60.0/24           | Département Finance et Comptabilité         |
| Lan_Juridique       | Network(s)  | 172.19.20.0/24           | Département Juridique                       |
| Lan_Logiciel        | Network(s)  | 172.19.30.0/24           | Département développement de logiciel       |
| Lan_QHSE            | Network(s)  | 172.19.70.0/24           | Département QHSE                            |
| Lan_Recrutement     | Network(s)  | 172.19.90.0/24           | Département Recrutement                     |
| LAN_Server          | Network(s)  | 172.19.1.0/24            | Réseau qui contient les serveurs            |
| Lan_Subnet          | Network(s)  | 172.19.0.0/16            | Réseau interne global                       |
| Wan_Subnet          | Network(s)  | 198.168.0.0/16           | Réseau extérieur                            |


## Alias Port

| Firewall Alias | Type      | Port(s)   | Description                                                      |
|----------------|-----------|-----------|------------------------------------------------------------------|
| Database       | Port(s)   | 3306:5432 | Port utilisé pour les bases de données MySQL et PostgreSQL      |
| DHCP           | Port(s)   | 67:68     | Attribution dynamique des adresses IP                           |
| DNS            | Port(s)   | 53        | Résolution de nom de domaine                                    |
| FTP            | Port(s)   | 20:21     | Transfert de fichier                                            |
| HTTP           | Port(s)   | 80        | Navigation web non sécurisé                                     |
| HTTPS          | Port(s)   | 443       | Navigation web sécurisé                                         |
| Kerberos       | Port(s)   | 88        | Authentification réseau utilisée pour sécuriser les échanges clients/serveurs |
| LDAP           | Port(s)   | 389       | Authentification annuaire                                        |
| NTP            | Port(s)   | 123       | Synchronisation de l'heure                                       |
| SFTP           | Port(s)   | 22        | Transfert de fichier sécurisé                                    |
| SMTP           | Port(s)   | 25        | Envoi d'email                                                   |
| SSH            | Port(s)   | 22        | Accès distant et sécurisé à un serveur                           |
| VPN            | Port(s)   | 1194      | Connexion à distance sécurisée                                   |


## Alias URL 

| Firewall Alias      | Type        | IP(s)                   | Description                                 |
|---------------------|-------------|-------------------------|---------------------------------------------|
| Streaming           | Host(s)     | netflix.com             |  Site de streaming                          |
| SocialNetwork       | Host(s)     | facebook.com, twitter.com| Réseaux sociaux non professionnels          |


# Régles d'autorisation et de restrictions des pare-feux

## WAN
|Protocole|IP Source|IP Destination|Port Destination|Action|Explication|
|:--------:|:--------:|:-------:|:-------:|:---------:|:----------:| 
|UDP | Réseau DMZ | Réseau WAN     | 123 | Autoriser |  Autorisation de synchronisation des horloges |
|SMTP,TCP | Réseau DMZ | Réseau WAN     | 25,587,465 | Autoriser |  Autorisation pour l'envoie d'email  |
|FTP,TCP | Réseau DMZ | Réseau WAN     | 20.21 | Autoriser |  Autorisation des mises à jours et des transferts de fichier |
|SSH,TCP | Réseau DMZ | Réseau WAN     | 22 | Autoriser |  Autoriser la communication sécurisé |
|Any  | *             |172.19.1.44      | *        | Bloquer           |   Bloquer toutes interactions vers le WAN     |

## DMZ 
|Protocole|IP Source|IP Destination|Port Destination|Action|Explication|
|:--------:|:--------:|:-------:|:-------:|:---------:|:----------:| 
|UDP | Réseau DMZ | Réseau WAN     | 123 | Autoriser |  Autorisation de synchronisation des horloges |
|SMTP,TCP | Réseau WAN | Réseau DMZ     | 25,587,465 | Autoriser |  Autorisation pour l'envoie d'email  |
|FTP,TCP | Réseau WAN | Réseau DMZ    | 20.21 | Autoriser |  Autorisation des mises à jours et des transferts de fichier |
|SSH,TCP |  Admin | Réseau DMZ     | 22 | Autoriser |  Autoriser la connexion du compte administrateur vers la DMZ |
|TCP | Any | serverWeb   | 80(HTTP) 443(HTTPS) | Autoiser  | Autoriser l'entrée d'internet à partir du serverWeb |
|Any  | *             | Any    | *        | Bloquer           |   Bloquer toutes interactions vers la DMZ     |

## LAN 
|Protocole|IP Source|IP Destination|Port Destination|Action|Explication|
|:--------:|:--------:|:-------:|:-------:|:---------:|:----------:| 
|UDP | Réseau DMZ | Réseau WAN     | 123 | Autoriser |  Autorisation de synchronisation des horloges |
|SMTP,TCP | Réseau WAN | Réseau DMZ     | 25,587,465 | Autoriser |  Autorisation pour l'envoie d'email  |
|FTP,TCP | Réseau WAN | Réseau DMZ    | 20.21 | Autoriser |  Autorisation des mises à jours et des transferts de fichier |
|SSH,TCP | Réseau WAN | Réseau DMZ     | 22 | Autoriser |  Autoriser SSH entre la DMZ et la WAN |
|TCP | Any | Réseau DMZ     | 80(HTTP) 443(HTTPS) | Autoiser  | Autoriser l'entrée d'internet à partir du serverWeb |
|Any  | *             | Any    | *        | Bloquer           |   Bloquer toutes interactions vers la DMZ     |
