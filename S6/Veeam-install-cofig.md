
---

## Objectif

Découvrez comment configurer Veeam Agent pour Microsoft Windows pour sauvegarder votre serveur Bare Metal Windows.

https://www.veeam.com/fr/products/downloads.html



### Télécharger et installer Veeam Agent

Téléchargez [Veeam Agent for Microsoft Windows 6.0.2](https://login.veeam.com/realms/veeamsso/protocol/openid-connect/auth?client_id=veeam-com&response_type=code&redirect_uri=https%3A%2F%2Fwww.veeam.com%2Foauth&scope=profile&state=e9a55dcbf050f86c5eb69ea264b8fb86) sur le serveur que vous souhaitez sauvegarder.

Installez Veeam Agent et sélectionnez `No`{.action} lorsque vous êtes invité à installer un fichier de licence.

Cliquez sur le bouton de menu et sélectionnez `+ Add New Job...`{.action}.
![Screenshot-33](https://github.com/user-attachments/assets/0ed399d2-0267-4f5a-8c3c-ede5266fba3a)







### Configuration de la sauvegarde

#### Nom

Vous pouvez modifier le nom et/ou la description par défaut. Cliquez ensuite sur `Next`{.action}.


#### Mode de sauvegarde

Choisissez les données à sauvegarder et cliquez sur `Next`{.action}.


#### Destination

Choisissez `Veeam backup repository`{.action}. et cliquez sur `Next`{.action}.


#### Serveur de sauvegarde

Entrez le nom ou l'adresse IP du serveur Veeam Backup et renseignez vos identifiants Veeam 

Cliquez sur `Next`{.action}.

Le chargement de votre licence va prendre quelques instants.


#### Répertoire de sauvegarde

Sélectionnez votre répertoire de sauvegarde (*backup repository*) et, si vous le souhaitez, modifiez la politique de rétention.

Cliquez sur `Next`{.action}.

![Screenshot-23](https://github.com/user-attachments/assets/f26373e6-fdae-4692-a311-e52fec936c8a)



#### Sauvegarde en cache (facultatif)

Si vous le souhaitez, vous pouvez activer le cache de sauvegarde, ce qui peut être utile le répertoire distant de sauvegarde est temporairement indisponible.

Cliquez sur `Next`{.action}.


#### Planification

Choisissez vos préférences de planification de sauvegarde et cliquez sur `Apply`{.action}.





### Lancer la sauvegarde

Cliquez sur le bouton ☰ du menu, sélectionnez la tâche que vous venez de créer puis cliquez sur `Backup Now`{.action}.


Vous pouvez suivre l'avancement de votre sauvegarde depuis l'application Veeam Agent :


Sur le serveur Veeam Backup and Recovery, la tâche de sauvegarde apparaîtra :


## Aller plus loin

[Restaurer un serveur Bare Metal avec Veeam Enterprise](/pages/bare_metal_cloud/dedicated_servers/veeam-enterprise-server-restore)

[Page d'assistance de Veeam](https://www.veeam.com/knowledge-base.html)

