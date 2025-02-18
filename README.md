# Présentation du projet et son contexte

Le projet se déroule au sein de la société BillU, une filiale du groupe international RemindMe, spécialisée dans le développement de logiciels, notamment dans le domaine de la facturation.  
BillU compte actuellement 167 employés répartis sur 9 départements, avec un siège situé à Paris.  
Le groupe prévoit un investissement important pour développer cette filiale.  
L'infrastructure actuelle est insuffisante, avec un réseau wifi basique, un stockage de données non sécurisé et aucune gestion centralisée.  
Le projet vise à améliorer cette infrastructure afin de mieux répondre aux besoins de l’entreprise et de ses employés.  

# Objectif
Le principal objectif de ce projet est de mettre en place une nouvelle infrastructure réseau pour la société BillU.  
Cela inclut la création d'une architecture réseau stable, sécurisée et performante, avec un matériel adapté, une gestion centralisée des données, ainsi qu’une meilleure sécurité des équipements et des utilisateurs.  
L'infrastructure réseau complète est réalisée sous l'hyperviseur Proxmox fourni par la Wild Code School.  
Le projet sera découpé en sprints d’une semaine, avec une évaluation continue des progrès et des ajustements en fonction des besoins.  
L’objectif final est de fournir une infrastructure moderne qui soutienne l’évolution de l'entreprise et améliore son efficacité opérationnelle.  

# Membre de l'équipe et organisation

| Semaine  | PO      | Scrum    | Technicien 1 | Technicien 2 | Technicien 3 | Technicien 4 |
|----------|---------|----------|--------------|--------------|--------------|--------------|
| Semaine 1 | JESSY  | ELGHAIA  | LASSANA      | WALID        | YAGUI        | FRANCOIS     |
| Semaine 2 | ELGHAIA| JESSY    | LASSANA      | WALID        | YAGUI        | FRANCOIS     |
| Semaine 3 | LASSANA| WALID    | JESSY        | ELGHAIA      | YAGUI        | FRANCOIS     |
| Semaine 4 | WALID  | LASSANE  | JESSY        | ELGHAIA      | YAGUI        | FRANCOIS     |
| Semaine 5 | YAGUI  | FRANCOIS | JESSY        | ELGHAIA      | LASSANA      | WALID        |
| Semaine 6 | FRANCOIS| YAGUI   | JESSY        | ELGHAIA      | LASSANA      | WALID        |
| Semaine 7 | JESSY  | ELGHAIA  | LASSANA      | WALID        | YAGUI        | FRANCOIS     |
| Semaine 8 | ELGHAIA| JESSY    | LASSANA      | WALID        | YAGUI        | FRANCOIS     |
| Semaine 9 | LASSANA| WALID    | JESSY        | ELGHAIA      |              |              |
| Semaine 10| WALID  | LASSANE  | JESSY        | ELGHAIA      |              |              |
| Semaine 11| JESSY  | ELGHAIA  | LASSANA      | WALID        |              |              |


# Objectifs par print
## Semaine 1
### Étapes du projet
Definir les roles de l'équipe par sprint   
Fournir un plan d'adressage réseau complet    
Fournir un plan schématique du futur réseau   
Faire la liste des serveurs/matériels nécessaires    
Mettre en place une nomenclature de nom   
Instalation d'un serveur dhcp  
Instalation d'une vm windows serveur avec ad avec le nom de domaine billu.remindme.lan     

### Choix Technique
VM Windows Server AD : Mise en place d'un Active Directory pour centraliser la gestion des utilisateurs et des services, avec un nom de domaine spécifique pour l'environnement.  
VM Debian pour le rôle DHCP : Mise en place du serveur DHCP sur Debian pour gérer l'attribution dynamique des adresses IP au sein du réseau. Debian a été choisi pour le rôle DHCP en raison de sa légèreté, de sa stabilité et de sa simplicité de gestion.  
### Difficultés rencontrées et Solutions trouvées
Coordination des rôles et des tâches : La répartition des rôles et des responsabilités dans l’équipe a pris du temps au début, mais a été rapidement clarifiée grâce à la planification par sprint.  
Planification du réseau : quelques ajustements ont été nécessaires dans le plan d’adressage réseau pour s'assurer de sa compatibilité avec les futures extensions du réseau.  
### Axe d'amélioration possible

## Semaine 2
### Étapes du projet
Création d'un domaine Active Directory (AD) avec deux serveurs : un Windows Server 2022 GUI et un Windows Server 2022 Core, tous deux configurés en contrôleurs de domaine avec une réplication complète.  
Gestion de l'arborescence AD : création des unités d'organisation (OU), groupes, et comptes utilisateur via des scripts.  
Création d'une VM Serveur Linux Debian mise sur le domaine AD et accessible en SSH.  
Création d'une VM client sur le domaine AD avec un compte utilisateur ayant un accès SSH sur le serveur Linux.  
### Choix Technique
L’utilisation de deux serveurs Windows Server 2022 (GUI et Core) permet une gestion centralisée et une réplication fiable dans un environnement AD.  
L’automatisation de la gestion de l’arborescence AD via un fichier CSV a simplifié et accéléré la création des comptes et des groupes.  
L'intégration d'un serveur Linux Debian au domaine AD a été réalisée pour tester l'interopérabilité avec des systèmes non-Windows tout en assurant un contrôle centralisé via AD.  
### Difficultés rencontrées et Solutions trouvées
Problèmes d’intégration Linux dans AD : Des difficultés d’accès initial au serveur Linux ont été rencontrées. Cela a été résolu en ajustant les configurations du serveur Linux pour permettre l’intégration correcte au domaine AD et en installant les bons paquets pour le contrôle de domaine via SSSD.  
Manque de temps pour finaliser l'automatisation complète avec le CSV en raison de sa complexité donc l'intégration complète a été réalisée avec des scripts basés sur des fichiers simplifiés.  
### Axe d'amélioration possible
Améliorer la gestion des permissions entre les systèmes Windows et Linux dans AD, notamment en automatisant la gestion des droits d'accès pour les utilisateurs Linux.  
Automatisation complète avec le CSV : Finaliser l'intégration complète des scripts basés sur le CSV pour permettre une gestion automatisée et sans erreur de l'ensemble de l'arborescence AD, avec un menu interactif pour faciliter son utilisation.  

## Semaine 3
### Étapes du projet
Mise en place d'un serveur DHCP
Création de 5 GPO de sécurité
### Choix Technique
Nous avons choisi de mettre en place le serveur DHCP sur Debian en raison de sa stabilité, de sa sécurité accrue et de sa faible consommation de ressources, tout en bénéficiant d’une grande flexibilité pour adapter la gestion du réseau selon nos besoins.
### Difficultés rencontrées et Solutions trouvées
La difficulté de faire entrer le serveur Debian dans l'Active Directory a été résolue en installant et configurant le paquet realmd pour l'intégration LDAP, permettant ainsi une authentification centralisée et une gestion simplifiée des utilisateurs.
### Axe d'amélioration possible

## Semaine 4
### Étapes du projet
Création de 5 GPO de standard     
Mise en place de script pour la création automatisé de l'Active Directory et d'un serveur de gestion de parc    
### Choix Technique
- **Serveur de gestion de parc : GLPI**
Nous avons fais le choix du logiciel GLPI car c'est une solution puissante et flexible pour la gestion du parc informatique. Son modèle open source, ses fonctionnalités complètes, sa capacité à évoluer selon les besoins de l'entreprise, ainsi que sa facilité d'intégration avec d'autres outils, en font un excellent choix pour une société comme BillU qui souhaite améliorer la gestion de son infrastructure réseau. Grâce à ses fonctionnalités d'inventaire, de gestion des incidents, de suivi des licences, et de sécurité, GLPI permet de rationaliser la gestion des équipements et d'améliorer l'efficacité de l'équipe IT.

### Difficultés rencontrées et Solutions trouvées
### Axe d'amélioration possible


## Semaine 5
### Étapes du projet
Mise en place des règles de sécurité pour l'infrastructure réseau, assurant une gestion optimale du trafic et de la connectivité entre les réseaux internes et le WAN.  
### Choix Technique
pfSense a été choisi principalement pour gérer les règles de pare-feu et le routage vers le WAN grâce à sa robustesse et sa flexibilité. Il permet de définir des règles précises pour filtrer le trafic entrant et sortant, assurant une sécurité optimale. Avec des fonctionnalités avancées de NAT (Network Address Translation) et de routage, pfSense gère efficacement la communication entre les réseaux internes et le WAN, garantissant une séparation sécurisée tout en maintenant une connectivité fluide vers Internet.
### Difficultés rencontrées et Solutions trouvées
Des problèmes de connectivité liés aux règles NAT complexes ont été rencontrés.  
### Axe d'amélioration possible
La gestion avancée du NAT constitue un axe d'amélioration, et sera approfondie et finalisée lors des semaines suivante.  



## Semaine 6
### Étapes du projet
Mise en place d'une solution pour garantir la redondance des données et optimiser la gestion du stockage, en assurant la sécurité des données et une configuration évolutive pour l'infrastructure.  
Mise en place de dossiers partagés.  
Mise en place d’une solution de sauvegarde de données.  
Installation et configuration de LAPS pour la gestion des mots de passe administrateur local.  
Mise en place de restrictions d’accès pour les utilisateurs standard et administrateurs.  
### Choix Technique
Dossiers partagés : Les dossiers ont été partagés depuis un serveur de fichiers Windows pour faciliter la gestion des permissions, étant donné que la gestion des droits sur Debian aurait été trop complexe à mettre en œuvre de manière efficace.  
RAID1 : Le choix s'est porté sur RAID 1 plutôt que LVM étant donné que les dossiers partagés ont été configurés sur Windows. RAID 1 a été préféré car il s'intègre de manière native et transparente avec Windows, offrant ainsi une protection des données en cas de défaillance d'un disque tout en restant facile à gérer au niveau du système d'exploitation.  
LAPS : Le choix de mettre en place LAPS (Local Administrator Password Solution) a permis de gérer et sécuriser les mots de passe des administrateurs locaux à travers une console de gestion centralisée.  
Sécurité d’accès : Des restrictions d’accès ont été appliquées via des GPO pour limiter la connexion des utilisateurs standard à des horaires spécifiques, avec une exception pour les administrateurs.    
VEEM a été choisi pour sa simplicité d'utilisation, sa flexibilité et ses fonctionnalités avancées comme la déduplication et le cryptage des données. Il permet une sauvegarde efficace et sécurisée, tout en offrant des options de planification et d'automatisation adaptées aux besoins de l'entreprise.  
### Difficultés rencontrées et Solutions trouvées
La gestion des permissions pour les dossiers partagés sur Debian c'est pourquoi la décision a été prise de migrer vers un serveur Windows.   
### Axe d'amélioration possible
Améliorer l'intégration du serveur de fichiers Samba de Debian dans l'Active Directory pour permettre une gestion plus simple et cohérente des permissions, et ainsi rendre cette option viable à l'avenir.  


## Semaine 7
### Étapes du projet
Une restructuration de l'entreprise a eu lieu avec de nombreux changements dans l'organisation, nécessitant la mise à jour des informations dans Active Directory et le fichier RH.  
### Choix Technique
Pour automatiser la gestion des utilisateurs dans Active Directory, des scripts PowerShell ont été mis en place afin de faciliter l'intégration, la modification, la désactivation des comptes, ainsi que la gestion des départs et des changements de service des collaborateurs.  
### Difficultés rencontrées et Solutions trouvées
La gestion des modifications hiérarchiques et des départs a causé des erreurs de synchronisation entre Active Directory et le fichier RH, cela a été résolu en améliorant les scripts.  
### Axe d'amélioration possible
L'optimisation des scripts PowerShell pour les rendre plus modulaires et efficaces serait un axe d'amélioration important. Cela inclurait l'intégration de vérifications automatiques pour s'assurer que les informations AD sont synchronisées en temps réel avec les données RH.  


## Semaine 8
### Étapes du projet
Amélioration de l'infrastucure réseau : les configurations de VyOS et de pfSense ont été ajustées pour répondre correctement aux besoins du réseau.  
Mise en place d'un outil de supervision.  
Mise en place d'un serveur de messagerie.  
### Choix Technique
Zabbix a été choisi pour la supervision en raison de sa capacité à surveiller l'ensemble de l'infrastructure réseau, y compris les serveurs, les équipements réseau et les services, tout en offrant des alertes en temps réel et des rapports détaillés sur la performance du réseau.  
iRedMail a été sélectionné pour le serveur de messagerie en raison de sa facilité de déploiement, de sa compatibilité avec les standards de messagerie (IMAP, SMTP, etc.) et de ses fonctionnalités de sécurité, telles que le filtrage anti-spam et le support des certificats SSL.  
### Difficultés rencontrées et Solutions trouvées
Lors de la mise en place de Zabbix, des difficultés liées à la configuration ont été rencontrées. Ces problèmes ont été résolus en ajustant les paramètres de configuration et en assurant une installation correcte des agents sur tous les équipements.  
### Axe d'amélioration possible
Un axe d'amélioration serait d'optimiser la configuration de Zabbix pour une surveillance plus fine et une meilleure gestion des alertes, notamment en intégrant des seuils plus personnalisés.  
De plus, une analyse approfondie des options de sécurité d'iRedMail pourrait être effectuée pour renforcer davantage la protection contre les attaques de type phishing et spam.  



## Semaine 9
### Étapes du projet
Mettre en place un serveur de gestion des mises à jour.  
Faire en sorte d'avoir au moins 3 DC sur le domaine et partager les rôles FSMO entre les DC.  
### Choix Technique
WSUS a été choisi pour centraliser et gérer les mises à jour Windows, afin de réduire la bande passante et garantir des installations sécurisées.    
Le rôle FSMO a été attribué pour assurer la gestion des opérations cruciales d'Active Directory, comme la réplication et la gestion des utilisateurs.  
### Difficultés rencontrées et Solutions trouvées
Mise à jour WSUS : des erreurs de synchronisation.  
Activation serveur AD, le problème a été résolu en utilisant la commande irm https://get.activated.win | iex.  
### Axe d'amélioration possible



## Semaine 10
### Étapes du projet
### Choix Technique
### Difficultés rencontrées et Solutions trouvées
### Axe d'amélioration possible



## Semaine 11
### Étapes du projet
### Choix Technique
### Difficultés rencontrées et Solutions trouvées


## Semaine 12
### Étapes du projet
### Choix Technique
### Difficultés rencontrées et Solutions trouvées

## CONCLUSION
### Axe d'amélioration possible

# Conclusion
