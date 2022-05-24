Title:    Passer de CocoaPods à Swift Package Manager  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     May 24, 2022  
Update:   
Keywords: dev, iOS  
Summary:  J’utilise CocoaPods depuis des années pour mes projets personnels et professionnels. Au fil des années, j’ai mis à jour mes bibliothèques open source pour les rendre compatible avec SPM. Et maintenant, je réalise que certaines de mes applications n’ont plus besoin de CocoaPods.  
Image:    
Language: fr  


J’utilise [CocoaPods](https://cocoapods.org) depuis des années pour mes projets personnels et professionnels. Son impact est énorme, facilitant la gestion des dépendances et encourageant le partage de code. C’est d’autant plus remarquable pour un outil créé et entretenu par une communauté de développeurs, indépendamment d’Apple.

[Swift Package Manager](https://www.swift.org/package-manager/) (SPM) évolue lentement. Très limité à son lancement, il aura fallu attendre plusieurs années pour le voir intégré à l’interface d’Xcode. Une évolution prudente, mais assurée.

Au fil des années, j’ai mis à jour mes bibliothèques open source pour les rendre compatibles avec SPM. Et maintenant, je réalise que certaines de mes applications n’ont plus besoin de CocoaPods. Pourquoi changer ? Il y a toujours un attrait à privilégier les solutions officielles, supportées par Apple. Mais la goutte d’eau aura été le passage à Apple Silicon. Cette transition a apporté son lot d’incompatibilités. Oui, il existe des solutions : Rosetta, mise à jour manuelle et ciblée de certaines dépendances… Et je suis sûr que la prise en charge d’Apple Silicon ira en s’améliorant. Mais voilà, si je peux faire autrement, je préfère m’en passer. Ironiquement, le point faible de CocoaPods est de reposer sur de (nombreuses) dépendances.

Certains projets auront toujours besoin de CocoaPods. J’étais un peu triste et un peu soulagé d’utiliser `pod deintegrate`. Ce n’est pas la fin de CocoaPods, mais une page se tourne.
