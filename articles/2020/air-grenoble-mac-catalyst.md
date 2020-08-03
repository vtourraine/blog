Title:     Air Grenoble pour Mac  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      August 3, 2020  
Update:    
Keywords:  dev, macOS  
Summary:   Air Grenoble est maintenant disponible sur le Mac App Store. Vous pouvez ainsi consulter la qualité de l’air depuis votre ordinateur.  
Image:     https://www.vtourraine.net/blog/img/2020/air-grenoble-mac-catalyst/air-grenoble-mac-book-pro.png  
Language:  fr  


Air Grenoble est maintenant [disponible sur le Mac App Store](https://apps.apple.com/app/air-grenoble/id1183533416). Vous pouvez ainsi consulter la qualité de l’air depuis votre ordinateur.

![Air Grenoble pour Mac](/blog/img/2020/air-grenoble-mac-catalyst/air-grenoble-mac-book-pro.png)

Côté technique, il s’agit d’une application « Catalyst », directement compilée à partir du code source de l’application mobile. La vue principale est la même, mais c’est surtout l’écran d’informations qui expose les fondations UIKit. Il aura suffit de cocher une case dans le projet Xcode, comme promis par Apple.

Je suis ravi de pouvoir enfin proposer cette application sur le Mac. L’application était pourtant compatible depuis 2017. J’avais développé une interface AppKit, puisque Catalyst n’existait pas encore. Malheureusement, l’application avait été rejetée par l’équipe de validation du Mac App Store, avec pour argument le manque de fonctionnalités. Trop basique pour le Mac. Cela m’avait découragé. Les annonces de la WWDC cette année m’ont motivé pour enfin m’intéresser à la solution Catalyst.

Pour la postérité, voici donc à quoi ressemblait l’application en version AppKit. Évidemment, sans les nuages, l’interface n’était pas aussi réussie.

![Air Grenoble pour Mac, version AppKit (2017)](/blog/img/2020/air-grenoble-mac-catalyst/air-grenoble-appkit.jpg)
