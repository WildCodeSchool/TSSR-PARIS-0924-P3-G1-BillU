
# WAN
|Protocole|IP Source|IP Destination|Port Destination|Action|Explication|
|:--------:|:--------:|:-------:|:-------:|:---------:|:----------:| 
|UDP | Réseau DMZ | Réseau WAN     | 123 | Autoriser |  Autorisation de synchronisation des horloges |
|SMTP,TCP | Réseau DMZ | Réseau WAN     | 25,587,465 | Autoriser |  Autorisation pour l'envoie d'email  |
|FTP,TCP | Réseau DMZ | Réseau WAN     | 20.21 | Autoriser |  Autorisation des mises à jours et des transferts de fichier |
|SSH,TCP | Réseau DMZ | Réseau WAN     | 22 | Autoriser |  Autoriser la communication sécurisé |
|Any  | *             |172.19.1.44      | *        | Bloquer           |   Bloquer toutes interactions vers le WAN     |

# DMZ 
|Protocole|IP Source|IP Destination|Port Destination|Action|Explication|
|:--------:|:--------:|:-------:|:-------:|:---------:|:----------:| 
|UDP | Réseau DMZ | Réseau WAN     | 123 | Autoriser |  Autorisation de synchronisation des horloges |
|SMTP,TCP | Réseau WAN | Réseau DMZ     | 25,587,465 | Autoriser |  Autorisation pour l'envoie d'email  |
|FTP,TCP | Réseau WAN | Réseau DMZ    | 20.21 | Autoriser |  Autorisation des mises à jours et des transferts de fichier |
|SSH,TCP |  Admin | Réseau DMZ     | 22 | Autoriser |  Autoriser la connexion SSH du compte administrateur vers la DMZ |
|TCP | Any | serverWeb   | 80(HTTP) 443(HTTPS) | Autoiser  | Autoriser l'entrée d'internet à partir du serverWeb |
|Any  | *             | Any    | *        | Bloquer           |   Bloquer toutes interactions vers la DMZ     |

# LAN 
|Protocole|IP Source|IP Destination|Port Destination|Action|Explication|
|:--------:|:--------:|:-------:|:-------:|:---------:|:----------:| 
|UDP | Réseau DMZ | Réseau WAN     | 123 | Autoriser |  Autorisation de synchronisation des horloges |
|SMTP,TCP | Réseau WAN | Réseau DMZ     | 25,587,465 | Autoriser |  Autorisation pour l'envoie d'email  |
|FTP,TCP | Réseau WAN | Réseau DMZ    | 20.21 | Autoriser |  Autorisation des mises à jours et des transferts de fichier |
|SSH,TCP | Réseau WAN | Réseau DMZ     | 22 | Autoriser |  Autoriser SSH entre la DMZ et la WAN |
|TCP | Any | Réseau DMZ     | 80(HTTP) 443(HTTPS) | Autoiser  | Autoriser l'entrée d'internet à partir du serverWeb |
|Any  | *             | Any    | *        | Bloquer           |   Bloquer toutes interactions vers la DMZ     |


# Pfsense
|Protocole|IP Source|IP Destination|Port Destination|Action|Explication|
|:--------:|:--------:|:-------:|:-------:|:---------:|:----------:| 
|TCP   |Admin    |Any      |443         | Autoriser| Autoriser |
|TCP   |Admin    |Any      |443         | Refuser | Refuser |
