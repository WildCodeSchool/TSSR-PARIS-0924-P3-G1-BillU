Installation de pfSense
---------------------------


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
Affecter des interfaces sur la console.

Le fichier de configuration par défaut de pfSense 2.3 a em0 attribué au WAN et em1 au LAN. Si le matériel cible a em0 et em1 , l'invite d'attribution est ignorée et l'installation se déroulera normalement. Plusieurs autres plates-formes courantes telles que nos systèmes SG, APU et ALIX sont également reconnues et leurs interfaces seront attribuées dans l'ordre attendu.
Si la plate-forme matérielle ne peut pas être identifiée, une liste des interfaces réseau et de leurs adresses MAC situées sur le système s'affiche, ainsi qu'une indication de leur état de liaison si celui-ci est pris en charge par la carte réseau. L'état de liaison est indiqué par le signe « (up) » apparaissant après l'adresse MAC si une liaison est détectée sur cette interface. L'adresse MAC (Media Access Control) d'une carte réseau est un identifiant unique attribué à chaque carte, et deux cartes réseau ne doivent pas avoir la même adresse MAC. Après cela, une invite s'affiche pour la configuration du VLAN.
Réseaux locaux virtuels.

L'option permettant d'attribuer des VLAN est présentée en premier. Si les VLAN ne sont pas nécessaires ou s'ils ne sont pas connus, entrez Non ici. Les VLAN sont facultatifs et ne sont nécessaires que pour la mise en réseau avancée. Un équipement compatible VLAN est également requis s'il doit être utilisé. Voir :doc:`VLAN Trunking </interfaces/vlan-trunking>` pour plus de détails.
Réseau local, réseau étendu, OPTx

La première invite d'interface concerne l' interface WAN . Si l'interface est connue, entrez son nom, tel que igb0 ou em0 , puis appuyez sur Entrée . Si l'identité de la carte n'est pas connue, reportez-vous à la section suivante pour connaître la procédure d'attribution automatique.
La deuxième invite d'interface concerne l' interface LAN . Entrez l'interface appropriée, telle que igb1 ou em1 , puis appuyez à nouveau sur Entrée . Si seule l'interface WAN doit être utilisée et aucune interface LAN, appuyez sur Entrée sans donner d'autre entrée.
Une seule interface (WAN) est nécessaire pour configurer pfSense. Si plusieurs interfaces sont disponibles, elles peuvent être affectées aux interfaces LAN et OPTx. La procédure est la même pour les interfaces supplémentaires : saisissez le nom de l'interface appropriée, puis appuyez sur Entrée .
Lorsqu'il n'y a plus d'interfaces à ajouter, appuyez sur Entrée . La liste des interfaces attribuées s'affiche. Si les mappages sont corrects, saisissez y , sinon saisissez n et répétez l'attribution.
REMARQUE : si une seule carte réseau est attribuée (WAN), cela s'appelle le mode Appliance. Dans ce mode, pfSense déplace la règle anti-verrouillage de l'interface graphique vers l'interface WAN afin que le pare-feu soit accessible à partir de là. Les fonctions de routage habituelles ne seraient pas actives puisqu'il n'y a pas d'interface « interne ». Ce type de configuration est utile pour les appareils VPN, les serveurs DNS, etc.
Procédure d'attribution automatique.

Pour l'attribution automatique d'interface, débranchez d'abord tous les câbles réseau du système, puis tapez a et appuyez sur Entrée . Branchez maintenant un câble réseau sur l'interface qui doit se connecter au WAN et appuyez sur Entrée . Si tout s'est bien passé, pfSense devrait maintenant savoir quelle interface utiliser pour le WAN. Le même processus peut être répété pour le LAN et toutes les interfaces facultatives qui seront nécessaires. Si un message s'affiche tel que Aucune liaison détectée, consultez :doc:`Dépannage de l'installation </install/installation-troubleshooting>` pour plus d'informations sur le tri des identités de cartes réseau.
Configuration par défaut de pfSense

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
