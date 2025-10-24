Title:    PlayGuide : paire de boutons pour iOS 26  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     October 23, 2025  
Update:   
Keywords: dev, iOS  
Summary:  Ça faisait longtemps que je n’avais pas donné de nouvelles de PlayGuide. La mise à jour pour iOS 26 m’en donne l’occasion.  
Image:    https://www.vtourraine.net/blog/img/2025/playguide-ios-26/playguide-ios-26-button.jpg  
Language: fr  


Ça faisait longtemps que je n’avais pas donné de nouvelles de [PlayGuide](https://playguide.eu). La mise à jour pour iOS 26 m’en donne l’occasion, a fortiori avec la publication récente du projet sur Codeberg. Oui, [l’application iOS est maintenant open source !](https://codeberg.org/PlayGuide/ios)

On y trouve notamment la paire verticale de boutons « Me positionner – Rechercher », qui reprend l’interface d’Apple Maps. Ça ne semble pas être un composant standard, il faut donc se remonter les manches. Voici mon approche avec UIKit, inspirée de la session WWDC 25 [« Build a UIKit app with the new design »](https://developer.apple.com/videos/play/wwdc2025/284).

![Paire verticale de boutons avec iOS 26](/blog/img/2025/playguide-ios-26/playguide-ios-26-button.jpg)

1. Je commence par créer une `UIVisualEffectView`. Je la dimensionne avec des contraintes Auto Layout et lui donne un `layer.cornerRadius` suffisant.
2. Ensuite, je crée les deux boutons avec  `UIButton(configuration: .plain())`, je les configure avec une image SF Symbols. Il faut alors les ajouter à la `contentView` de la `UIVisualEffectView`, pour ensuite les positionner, toujours avec Auto Layout.
3. Dernière étape : créer un `UIGlassEffect`, activer sa propriété `isInteractive`, et l’assigner à `effect` sur la `UIVisualEffectView`.

[Voici le code en intégralité.](https://codeberg.org/PlayGuide/ios/src/commit/e014c0019899e6da45c68e93f93819b08f84c872/PlayGuide/Sources/MapViewController.swift#L83) Rien de bien compliqué, mais ça ne me paraît pas évident pour autant.

(Est-ce qu’une version SwiftUI serait plus succincte ? Très probablement. Mais c’est justement mon problème avec SwiftUI : la plupart des choses sont plus aisées, mais certaines se révèlent étonnamment complexes à mettre en œuvre. Mais je m’éloigne du sujet…)

Visuellement, le résultat est très plaisant, surtout avec l’interaction entre le bouton et les couleurs de la carte au-dessous.

![PlayGuide sur iOS 26](/blog/img/2025/playguide-ios-26/playguide-ios-26.jpg)

Au final, le passage de PlayGuide à iOS 26 (tout en gardant la compatibilité avec les versions précédentes) demande une poignée de `if #available(iOS 26.0, *) { ... } else { ... }`, permettant d’adapter l’interface aux conventions propres à chaque version. Une dette technique légère, mais non nulle, multipliée par le nombre d’applications que je maintiens. Résultat : je n’ai pas eu le temps pour développer de nouvelles fonctionnalités. Cette année, toute est une question d’apparence.
