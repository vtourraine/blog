Title:    Interface SwiftUI pour AcknowList  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     February 3, 2022  
Update:   
Keywords: dev, iOS, SwiftUI  
Summary:  La dernière mise à jour d’AcknowList ajoute une interface SwiftUI. Le principe reste le même : la bibliothèque est configurée avec une liste de licenses, et affiche le résultat. En plus des UIViewController (UIKit), il y a donc maintenant des View (SwiftUI).  
Image:    
Language: fr  


La dernière mise à jour d’[AcknowList](https://github.com/vtourraine/AcknowList/releases/tag/2.1.0) ajoute une interface SwiftUI. Le principe reste le même : la bibliothèque est configurée avec une liste de licenses, et affiche le résultat. En plus des `UIViewController` (UIKit), il y a donc maintenant des `View` (SwiftUI). Le modèle reste le même. J’ai beaucoup hésité pour inclure cette nouveauté, et encore maintenant, je ne suis pas sûr d’avoir pris la bonne décision.

Pourquoi ajouter une interface SwiftUI à un projet qui offre une interface UIKit satisfaisante ? D’abord, pour expérimenter. Aucune de mes applications n’utilise SwiftUI. J’ai envie d’apprendre, et l’interface d’AcknowList se prête facilement à l’exercice, avec une liste, et une vue à base de texte. Il manque bien quelques fonctionnalités, par exemple la détection automatique des liens dans le contenu principal. Mais l’essentiel est là.

SwiftUI peut couvrir toutes les plateformes d’Apple, de la montre à la télé. Une aubaine pour AcknowList, qui était jusqu’alors limité à iOS et tvOS.

En revanche, la bibliothèque requiert maintenant iOS 13, le minimum pour un code SwiftUI. Pourtant, en théorie, AcknowList reste compatible jusqu’à iOS 9 avec son interface UIKit. Mais la distribution avec CocoaPods et Swift Package Manager nécessite une compilation valide de l’ensemble du code. Même avec des `@available(iOS 13.0, *)`, je n’ai pas réussi à créer une version valide couvrant les versions d’iOS précédentes. Idéalement, il faudrait proposer des packages distincts, ou plus exactement des sous-packages avec un cœur commun. Il faudrait alors diviser le projet en plusieurs repositories, une solution qui apporterait trop de complexité à mes yeux.

Mais surtout, Apple présente SwiftUI comme l’avenir du développement pour ses plateformes. Mes bibliothèques Swift sont plus utilisées que celles en Objective-C. SwiftUI remplacera-t-il vraiment UIKit ? La question est impossible à trancher aujourd’hui. Au-delà de ses limitations actuelles, facilement excusables pour une technologie aussi récente, la nature déclarative de SwiftUI est sa plus grande force et sa plus grande faiblesse. Oui, on peut facilement créer une interface extensible, adaptable, avec un minimum de code. Mais on voit mal comment personnaliser son fonctionnement, dans certains cas, sans revenir à une syntaxe équivalente à celle d’UIKit. De nombreuses applications AppKit ou UIKit semblent structurellement impossibles à implémenter avec SwiftUI. Une chose est sûre : pour l’instant, SwiftUI est une option intéressante, mais UIKit reste indispensable.

Ce qui nous ramène à ma décision d’ajouter l’interface SwiftUI, sans pour autant supprimer les classes UIKit. Un compromis, donc.
