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
| Semaine 9 | LASSANA| WALID    | JESSY        | ELGHAIA      | YAGUI        | FRANCOIS     |
| Semaine 10| WALID  | LASSANE  | JESSY        | ELGHAIA      | YAGUI        | FRANCOIS     |
| Semaine 11| YAGUI  | FRANCOIS | JESSY        | ELGHAIA      | LASSANA      | WALID        |


# Objectifs par print
## Semaine 1
### Étapes du projet
Definir les roles de l'équipe par sprint   
Fournir un plan d'adressage réseau complet  
Fournir un plan schématique du futur réseau  
Faire la liste des serveurs/matériels nécessaires  
Mettre en place une nomenclature de nom  
Instalation d'une vm windows serveur dhcp  
Instalation d'une vm windows serveur avec ad avec le nom de domaine billu.remindme.lan   

### Choix Technique
### Difficultés rencontrées et Solutions trouvées
### Axe d'amélioration possible

## Semaine 2
### Étapes du projet
AD-DS - Création d'un domaine AD  
	1. Un serveur Windows Server 2022 GUI avec les rôles AD-DS, DHCP, DNS
	2. Un serveur Windows Server 2022 Core avec le rôle AD-DS
	3. Les 2 serveurs sont des DC du domaine et ont une réplication complète gérée
Gestion de l'arborescence AD  
	1. Création des OU
	2. Création des groupes
	3. Création des comptes
Gestion de l'arborescence AD  entièrement automatisée à partir du fichier CSV  
	1. Création des groupes
	2. Création des comptes
Création d'une VM Serveur Linux Debian mise sur le domaine AD accessible en SSH  
Création d'une VM client  
	1. Sur le domaine AD
	2. Avec un compte utilisateur ayant un accès SSH sur le serveur Linux
### Choix Technique
### Difficultés rencontrées et Solutions trouvées
### Axe d'amélioration possible


## Semaine 3
### Étapes du projet
### Choix Technique
### Difficultés rencontrées et Solutions trouvées
### Axe d'amélioration possible

## Semaine 4
### Étapes du projet
Création de 5 GPO de sécurité  
Création de 5 GPO de standard  
Mise en place de script pour la création automatisé de l'Active Directory et d'un serveur de gestion de parc  

### Choix Technique
- **Serveur de gestion de parc : GLPI**
Nous avons fais le choix du logiciel GLPI car c'est une solution puissante et flexible pour la gestion du parc informatique. Son modèle open source, ses fonctionnalités complètes, sa capacité à évoluer selon les besoins de l'entreprise, ainsi que sa facilité d'intégration avec d'autres outils, en font un excellent choix pour une société comme BillU qui souhaite améliorer la gestion de son infrastructure réseau. Grâce à ses fonctionnalités d'inventaire, de gestion des incidents, de suivi des licences, et de sécurité, GLPI permet de rationaliser la gestion des équipements et d'améliorer l'efficacité de l'équipe IT.

### Difficultés rencontrées et Solutions trouvées
### Axe d'amélioration possible


## Semaine 5
### Étapes du projet
### Choix Technique
### Difficultés rencontrées et Solutions trouvées
### Axe d'amélioration possible




## Semaine 6
### Étapes du projet
### Choix Technique
### Difficultés rencontrées et Solutions trouvées
### Axe d'amélioration possible




## Semaine 7
### Étapes du projet
### Choix Technique
### Difficultés rencontrées et Solutions trouvées
### Axe d'amélioration possible



## Semaine 8
### Étapes du projet
### Choix Technique
### Difficultés rencontrées et Solutions trouvées
### Axe d'amélioration possible



## Semaine 9
### Étapes du projet
### Choix Technique
### Difficultés rencontrées et Solutions trouvées
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
### Axe d'amélioration possible

# Conclusion
