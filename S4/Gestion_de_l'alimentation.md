
## Une fois que la GPO " Gestion de l'alimentation" fut crée il faut faire clique droit sur la GPO et selectionner "Edit" 

![Capture d’écran du 2024-12-12 22-02-24](https://github.com/user-attachments/assets/37e13288-4ab3-4a36-8a3c-4262938f8f0c)

## Puis aller dans "Polices" et selectionner "Administrative templates" Puis "Systems" et "Power Management" 

![Capture d’écran du 2024-12-12 22-00-36](https://github.com/user-attachments/assets/a6f7a3f6-dc84-42d9-9b85-af324cfb8910)

## CLiquer sur "Notification settings" pour ensuite aller sur "Critical battery notification level" et mettre à "1O%" pour que l'ordinateur puisse annoncer que la batterie est faible 

![Capture d’écran du 2024-12-12 22-11-21](https://github.com/user-attachments/assets/49712d7e-23b8-480f-b0f2-c740c626c29f)

## On fait la même chose pour "Low battery notification level" pour "20%" et pour "Reserve Battery notification level" pour "80%" 

![Capture d’écran du 2024-12-12 22-16-07](https://github.com/user-attachments/assets/0064e77c-5b3a-4524-b0fa-480266080318)

![Capture d’écran du 2024-12-12 22-16-50](https://github.com/user-attachments/assets/832a48c5-2fdd-4acc-b339-1d8db0a944b2)

## Puis aller dans "Sleep Settings" et selectionner "Specify the unattended sleep timeout" et mettre "5min" pour "Plugin" et "Battery"

![Capture d’écran du 2024-12-12 22-21-50](https://github.com/user-attachments/assets/42c664d6-b1df-4b3c-9dfd-4b0307d6e35d)

> Une fois cela terminer veuilez mettre dans la console "gpupdate /force" ou redemarrer l'ordinateur pour que le GPO puisse etre appliqué sur le domaine.
