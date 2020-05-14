Title:     Mode sombre au lancement pour une application compatible iOS 10  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      May 14, 2020  
Update:    
Keywords:  dev, iOS  
Summary:   Un écran de lancement iOS doit passer par un storyboard avec uniquement des classes de base. Et si votre projet supporte encore iOS 10, un asset catalog ne peut pas inclure des couleurs personnalisées. Tout cela signifie a priori qu’il est impossible de supporter le mode sombre au lancement. Flash blanc aveuglant garanti à chaque fois.  
Image:     https://www.vtourraine.net/blog/img/2020/ios-dark-mode-launch-screen-ios-10/xcode-asset-catalog.png  
Language:  fr  


Un écran de lancement iOS doit passer par un storyboard avec uniquement des classes de base. Et si votre projet supporte encore iOS 10, un asset catalog ne peut pas inclure des couleurs personnalisées. Tout cela signifie a priori qu’il est impossible de supporter le mode sombre au lancement. Flash blanc aveuglant garanti à chaque fois.

Il existe pourtant une astuce pour résoudre ce problème. Un asset catalog sur iOS 10 peut bien sûr définir des images, y compris des variantes pour le mode sombre. Ces images alternatives seront ignorées pour un appareil avant iOS 13, mais Xcode n’aura aucun mal à compiler l’application correctement.

La solution consiste donc à créer des images avec une couleur unie correspondant à chaque mode :

1. Créez les images pour la couleur claire et la couleur sombre avec n’importe quel éditeur d’image
2. Ajoutez une image à l’asset catalog
3. Activez la variante du mode sombre dans le menu _Appearances_ pour cette image (dans l’inspecteur à droite)
4. Glissez-déposez les images
5. Ajoutez une `UIImageView` en fond du Storyboard de lancement, avec l’image précédemment définie, en mode _Scale to Fill_
6. Ajustez les contraintes de positionnement sur l’`UIImageView` pour remplir l’écran (n’oubliez pas d’ignorer les marges automatiques)

![Asset catalog Xcode, image avec variante mode sombre](/blog/img/2020/ios-dark-mode-launch-screen-ios-10/xcode-asset-catalog.png)

![Interface Builder, écran de lancement avec image de fond](/blog/img/2020/ios-dark-mode-launch-screen-ios-10/xcode-launch-screen.png)

> Cet article est essentiellement une traduction en français de [ma réponse à cette question sur Stack Overflow](https://stackoverflow.com/a/58197120/135712). Je l’ai mis en pratique avec succès pour [Air Grenoble](https://itunes.apple.com/app/air-grenoble/id1183533416?mt=8&at=1000lMiD).
