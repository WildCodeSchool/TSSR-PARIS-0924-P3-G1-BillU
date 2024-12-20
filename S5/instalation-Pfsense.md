















Installation de pfSense
---------------------------






![pfsensens](https://github.com/user-attachments/assets/91d2223c-0d8d-46ce-bdc3-957e255efc31)





















  -Processeur Intel ou AMD 64 bits (x86-64, amd64) sur pfSense 2.4 et versions ultérieures.
  -Doit pouvoir démarrer à partir d'une clé USB ou d'un lecteur optique et exécuter le programme d'installation sur pfSense 2.4 et versions ultérieures 64 bits ou 32 bits.
  

    
Machines virtuelles
---------------------
Les machines virtuelles, avec des hyperviseurs  Proxmox a ete utilise.


    
Télécharger pfSense
----------------------
    • Visitez https://www.pfsense.org/download
    • Choisissez la version , l'architecture et le type d'installateur choisis
    • Téléchargez le fichier de somme de contrôle SHA256 pour vérifier l'image ultérieurement
    • Choisissez un miroir et cliquez sur le lien sur sa ligne pour télécharger l'image à partir de là
    • Attendez que le téléchargement soit terminé

    
Vérifiez l'image téléchargée
---------------------------
Des fichiers de somme de contrôle SHA256 sont disponibles et peuvent être visualisés dans n'importe quel éditeur de texte brut. Ces fichiers SHA256 peuvent être utilisés pour vérifier que le téléchargement s'est terminé avec succès et qu'une version officielle est utilisée.
Les programmes de calcul de hachage varient selon le système d'exploitation. 

      Exemple:

      
   ..onglet::Linux

      Utilisez les utilitaires de ligne de commande « sha256sum » ou « md5sum » pour générer un
      hachage du fichier téléchargé.

      .. code-block:: aucun

         sha256sum pfSense-CE-2.4.4-RELEASE-p3-amd64.iso.gz

      Le hachage SHA256 généré peut être comparé au contenu du
      somme de contrôle **.sha256** fournie.

   

      

Préparer le support d'installation
-----------------------------------
L'image téléchargée doit être écrite sur le support cible avant de pouvoir être utilisée. Pour une installation complète, ce support est utilisé pour démarrer et installer, puis ne sera plus nécessaire. Pour une installation intégrée, le support cible est le disque (CF/SD) qui contiendra le système d'exploitation.
    • Écrire l'ISO d'installation : si le fichier .iso a été téléchargé, il doit être gravé sur un disque sous forme d'image ISO. Consultez :doc:`Écriture d'images ISO </install/writing-iso-images>` pour obtenir de l'aide.
    • Écriture d'images Memstick : cette tâche est traitée en détail dans Écriture d'une image d'installation du système d'exploitation sur un support Flash .

    
Se connecter à la console série
-------------------------------
Avant de tenter d'installer ou de démarrer, si une image série a été utilisée, telle que Memstick-Serial, connectez-vous à la console série avec un câble série et des options de terminal appropriés. Voir :doc:`Connexion à la console série </hardware/connecting-to-the-serial-console>` pour plus de détails.

Effectuer une installation complète
------------------------------------
Allumez le système cible et connectez le support d'installation : placez le CD dans le lecteur ou branchez le Memstick sur un port USB. Si le BIOS est configuré pour démarrer à partir du CD/USB, pfSense démarrera.
Pour les autres problèmes de démarrage, :doc:`Dépannage d'installation </install/installation-troubleshooting>` .
Lorsque le système d'exploitation démarre et que pfSense démarre, un assistant démarre et vous invite à accepter l'avis de droit d'auteur et de distribution.
Pour démarrer l’installation, sélectionnez OK lorsque l’option Installer est sélectionnée.


L'étape suivante consiste à sélectionner le système de fichiers. Par défaut, UFS est sélectionné. La prise en charge de ZFS est actuellement expérimentale. Sélectionnez OK pour continuer. Cette option configure automatiquement le disque dur.

L'étape suivante permet de sélectionner le clavier . La norme US est la valeur par défaut. Passez à l'étape suivante avec Sélectionner .

L'installation se poursuivra, en effaçant le disque cible et en installant pfSense. La copie des fichiers peut prendre un certain temps.

Une fois l'installation terminée, des options de configuration manuelle sont proposées, sélectionnez Non pour continuer.

Le système doit maintenant redémarrer pour que pfSense puisse démarrer à partir du disque cible. Sélectionnez Redémarrer , puis appuyez sur Entrée . Assurez-vous de retirer le disque ou la clé USB afin que le système ne tente pas de démarrer à partir de là la prochaine fois.

Après le redémarrage du système, pfSense s'exécutera à partir du disque cible. L'étape suivante consiste à attribuer des interfaces sur la console ci-dessous.
--------------------------------------------------------
Ce texte décrit la procédure d'attribution d'interfaces réseau sur pfSense, un pare-feu open source, lors de son installation et configuration initiale.

Attribution par défaut des interfaces :
Par défaut, pfSense attribue em0au WAN et em1au LAN si ces interfaces sont présentes sur le matériel. Si le matériel est reconnu (ex. SG, APU, ALIX), les interfaces sont automatiquement attribuées.

Reconnaissance manuelle des interfaces :
Si le matériel n'est pas identifié, pfSense affiche une liste des interfaces disponibles avec leurs adresses MAC et leur état de liaison ( upsi actif). L'utilisateur peut ensuite attribuer manuellement les interfaces WAN et LAN.

Support des VLAN :
Une étape optionnelle permet de configurer les VLAN, utiles uniquement pour des configurations réseau avancées avec du matériel compatible.

Processus d'attribution des interfaces :

L'utilisateur attribue les interfaces WAN et LAN en entrant leur nom (ex. em0, em1).
Si une seule interface (WAN) est attribuée, pfSense active le mode Appliance

Après l'installation et l'affectation de l'interface, pfSense a la configuration par défaut suivante :
------------------------------------------------------------
    • Le WAN est configuré comme un client DHCP IPv4.
    • Le WAN est configuré comme un client DHCP IPv6 et demandera une délégation de préfixe.
    • Le LAN est configuré avec une adresse IPv4 statique de 192.168.1.1/24 .
    • Le LAN est configuré pour utiliser une adresse/un préfixe IPv6 délégué obtenu par WAN (Track IPv6) si celui-ci est disponible.
    • Toutes les connexions entrantes vers le WAN sont bloquées .
    • Toutes les connexions sortantes du LAN sont autorisées .
    • NAT est exécuté sur le trafic IPv4 quittant le WAN depuis le sous-réseau LAN
    • Le pare-feu agira comme un serveur DHCP IPv4 :doc:`</dhcp/dhcp-server>`
    • Le pare-feu agira comme un serveur DHCPv6 IPv6 si une délégation de préfixe a été obtenue sur le WAN et active également SLAAC
    • Le :doc:`DNS Resolver </dns/unbound-dns-resolver>` est activé pour que le pare-feu puisse accepter et répondre aux requêtes DNS.
    • SSH est désactivé.
    • WebGUI s'exécute sur le port 443 en utilisant HTTPS.
    • Les informations d'identification par défaut sont définies sur un nom d'utilisateur admin avec le mot de passe pfsense .
    
Se connecter à l'interface graphique
-------------------------------------
Après l'installation et l'affectation, un menu shell est présenté sur la console avec un certain nombre d'options. pfSense est maintenant prêt à être accessible via le réseau, soit sur l'interface LAN (si une interface est attribuée), soit sur l'interface WAN dans un déploiement d'interface unique.
VMware Virtual Machine 

*** Welcome to pfSense 2.4.4-RELEASE (amd64) on pfSense ***

 WAN (wan)       -> em0        -> v4/DHCP4: 192.168.1.44/24
 LAN (lan)       -> em1        -> v4: 172.19.1.44/24
 DMZ ()          -> em2        -> V4 : 10.19.0.44/24
 0) Logout (SSH only)                  9) pfTop
 1) Assign Interfaces                 10) Filter Logs
 2) Set interface(s) IP address       11) Restart webConfigurator
 3) Reset webConfigurator password    12) PHP shell + pfSense tools
 4) Reset to factory defaults         13) Update from console
 5) Reboot system                     14) Disable Secure Shell (sshd)
 6) Halt system                       15) Restore recent configuration
 7) Ping host                         16) Restart PHP-FPM
 8) Shell

Enter an option:
L'interface WebGUI est utilisée pour configurer la grande majorité des éléments de pfSense.
Connectez un PC client au réseau local du pare-feu et assurez-vous qu'il a obtenu une adresse IP. Si ce n'est pas le cas, il est peut-être branché sur le mauvais port.
Ouvrez un navigateur Web et accédez à https://192.168.1.44/ , en utilisant le nom d'utilisateur par défaut admin et le mot de passe pfsense pour vous connecter.
La première visite sur l'interface Web sera redirigée vers l'assistant de configuration, qui est également accessible dans Système > Assistant de configuration . Suivez les instructions de l'assistant et configurez les éléments comme vous le souhaitez.

Dépannage d'installation
-------------------------
Si l'installation ne s'est pas déroulée comme prévu, consultez :doc:`Dépannage de l'installation </install/installation-troubleshooting>` pour obtenir de l'aide.
Informations Complémentaires
Pour plus d'informations sur l'installation de pfSense, consultez la section :doc:`/install/index` . Les guides |book_link| et |hangout_link| couvrent également une variété de sujets pertinents.
