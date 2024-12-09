Déployer un fond d'écran par GPO
Nous allons voir comment déployer un fond d'écran par gpo sur les postes de notre AD.

On crée et lie notre GPO à une OU Utilisateur.

![lADOUpOHL8Lvl47K-image-1647180184298(1)](https://github.com/user-attachments/assets/381895f8-78fe-45f8-ad3f-babfa2368bfe)

![KKZIU3m1GFwgfhMr-image-1647180213817 (2)](https://github.com/user-attachments/assets/67d5e81a-440f-471f-9846-a9b569fa5667)

![qTx6RdeObSZHgnmD-image-16471869624403](https://github.com/user-attachments/assets/c4955ec8-6a24-4cc3-9e63-caf576c9b84b)

Dans le partage, on désactive l'héritage (on choisit convertir), on retire "Utilisateurs du domaine" et on rajoute "Ordinateurs du domaine" en lecture.

![44](https://github.com/user-attachments/assets/13ba97da-658a-4e6e-9d5a-ad63157af12a)


Et concernant les autorisations du partage, on remplace "Tout le monde" par "Ordinateurs du domaine" en CT (On s'occupe des permissions via NTFS).

![55](https://github.com/user-attachments/assets/d840d59a-bde1-4e49-a642-086130c03dd9)



On crée une deuxième GPO ordinateur :

![66](https://github.com/user-attachments/assets/0b636d1d-7b57-4351-8567-449dc659dbfb)


![777](https://github.com/user-attachments/assets/ef83fce3-de7a-4395-85be-92b11d745041)


Sous "Fichiers" :

![88](https://github.com/user-attachments/assets/4a842761-3df3-4f16-844e-ed4021931ecc)
