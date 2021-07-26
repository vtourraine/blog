Title:     Quels changements pour iOS 15 ?  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      July 26, 2021  
Update:    
Keywords:  dev, iOS  
Summary:   Chaque version d’iOS apporte son lot de nouveautés. Mais avant toute chose, il convient de tester l’impact du nouveau SDK sur les fonctionnalités existantes. En d’autres termes, comment éviter les régressions avec les mises à jour d’Xcode ?  
Image:     https://www.vtourraine.net/blog/img/2021/ios-15-changements/wwdc-21-bars.jpg  
Language:  fr  


Chaque version d’iOS apporte son lot de nouveautés. Mais avant toute chose, il convient de tester l’impact du nouveau SDK sur les fonctionnalités existantes. Il faut le savoir : le même code ne produit pas la même application pour une version d’iOS donnée selon le SDK utilisé pour la compilation. En d’autres termes, comment éviter les régressions avec les mises à jour d’Xcode ?

Cette année, attention aux `UIToolbar` et aux `UITabBar`. Leur apparence évolue avec un fond dynamique qui devient transparent en fonction du contenu qui se trouve au dessus et de la position du défilement. Si ce nouveau rendu pose problème, `scrollEdgeAppearance` devrait permettre de l’ajuster.

![Nouvelles barres `UIToolbar` et `UITabBar` avec iOS 15](/blog/img/2021/ios-15-changements/wwdc-21-bars.jpg)

Autre changement subtil mais potentiellement perturbateur : la nouvelle apparence des en-têtes de sections pour `UITableView` avec le style par défaut. Avec iOS 15, le fond est d’abord transparent, et devient gris lorsqu’il est attaché en haut avec le défilement de la liste. Ces en-têtes gagnent également en hauteur, avec un espace supplémentaire au-dessus du titre. Si vous aviez personnalisé leur mode d’affichage, votre code aura peut-être besoin d’une mise à jour.

![Nouveaux en-têtes des `UITableView` avec iOS 15](/blog/img/2021/ios-15-changements/wwdc-21-table-headers.jpg)

![Avec, en bonus, deux nouveaux styles de `UITableView` avec iOS 15](/blog/img/2021/ios-15-changements/wwdc-21-table-styles.jpg)

Voilà pour les changements les plus notables, votre application devrait maintenant tourner sans problème. À partir de là, il serait tentant d’intégrer de nouvelles fonctionnalités exclusives à iOS 15. Mais comment faire sans pour autant abandonner les utilisateurs des versions précédentes ? Comment profiter des nouveautés d’iOS 15 sans rupture d’implémentation ? Voici quelques pistes :

[Les modales peuvent maintenant prendre l’apparence de « feuilles » (« sheets »)](https://www.vtourraine.net/blog/2021/wwdc-2021-uikit-sheets) en utilisant `UISheetPresentationController`. Cette nouvelle présentation est configurable : obscurcir ou non la vue qui présente, s’étendre ou non en plein écran avec le défilement, etc.

![Nouvelle présentation en « feuille » avec iOS 15](/blog/img/2021/ios-15-changements/wwdc-21-sheet.jpg)

[Les SF Symbols supportent maintenant différents modes de rendu des couleurs avec UIKit](https://www.vtourraine.net/blog/2021/wwdc-2021-sf-symbols-uikit-appkit). J’aime beaucoup l’option `hierarchical`  pour ajouter une certaine profondeur aux images.

![Nouvelles options de rendu des SF Symbols avec iOS 15](/blog/img/2021/ios-15-changements/wwdc-21-sf-symbols.jpg)

[Les table views et collection views sur iPad peuvent bénéficier de la navigation au clavier](https://www.vtourraine.net/blog/2021/wwdc-2021-ipad-keyboard-navigation) simplement en activant la propriété `allowsFocus`.

[Les champs de texte (`UITextField` et `UITextView`) peuvent importer le contenu d’une image](https://www.vtourraine.net/blog/2021/wwdc-2021-camera-keyboard-input) avec un moteur de reconnaissance  optique des caractères (OCR). Or, cette analyse s’adapte au type  de texte attendu (`UITextContentType`). C’est donc une raison supplémentaire pour renseigner cette valeur sur tous vos champs de texte.

En ce qui me concerne, cette liste devrait me tenir occupé jusqu’à la sortie publique d’iOS 15. `async` patientra encore un peu (normal, c’est une fonctionnalité conçue pour « attendre »).
