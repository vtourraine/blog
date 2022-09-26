Title:    AcknowList pour Swift Package Manager  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     September 26, 2022  
Update:   
Keywords: dev, iOS, SwiftUI  
Summary:  AcknowList existe parce que CocoaPods propose une liste des licences pour un projet : le fichier « acknowledgments.plist ». Que faire pour Swift Package Manager ? On peut toujours intégrer des licences manuellement, mais sans fichier de référence, l’intégration n’est pas vraiment satisfaisante. Quand soudain je découvre le fichier « Package.resolved ».  
Image:    
Language: fr  


[AcknowList](https://github.com/vtourraine/AcknowList) existe parce que CocoaPods propose une liste des licences pour un projet : le fichier `*acknowledgments.plist`. Que faire pour Swift Package Manager ? On peut toujours intégrer des licences manuellement, mais sans fichier de référence, l’intégration n’est pas vraiment satisfaisante.

Quand soudain je découvre le fichier `Package.resolved`. Bien caché à l’intérieur d’un projet Xcode utilisant SPM, mais [officiellement documenté](https://developer.apple.com/documentation/swift_packages/building_swift_packages_or_apps_that_use_them_in_continuous_integration_workflows). Ce qui nous amène à [AcknowList 3.0](https://github.com/vtourraine/AcknowList/releases/tag/3.0.0), qui ajoute la gestion des fichiers SPM.

La principale limitation concerne l’absence des licences elles-mêmes (les fichiers MIT, GPL, etc). SPM liste les dépendances avec les URLs des repositories, mais ignore les licences. AcknowList doit se contenter d’afficher la page web du repository (GitHub et les autres). Le résultat est moins accessible pour un utilisateur, mais a le mérite de mettre en avant le projet open source directement. Fondamentalement, AcknowList remplit sa mission d’afficher les dépendances d’un projet.

En creusant davantage, il serait possible de contourner ce problème. À partir de l’URL du repo, AcknowList pourrait tester l’existence d’un fichier `licence.txt`, avec quelques variations de majuscules et d’extensions. Si le fichier existe, on peut télécharger son contenu et l’afficher comme une licence classique. Mais à quel moment ? Quand l’utilisateur sélectionne une licence, cela impliquerait une pause de la navigation, le temps de déterminer si le fichier existe et de l’obtenir. Pas très fluide. On pourrait imaginer un script à la compilation, qui irait chercher les licences et les intégrerait directement au bundle de l’application. Si le défi technique vous tente, les pull requests sont toujours les bienvenues.

Un dernier point à propos de cette mise à jour : le passage à une version « 3.0 » ne concerne pas le support de SPM en soi, mais parce que j’ai modifié plusieurs éléments de son interface de programmation. La structure des `Acknow` évolue. Le chargement des licences gagne un niveau d’abstraction pour supporter plusieurs types de fichiers à la fois. Plus anecdotique, les références vers les fichiers utilisent maintenant des `URL`, au lieu des paths en `String`. Avec à chaque fois la même question : est-ce que ça en vaut la peine ? Une amélioration mineure, imperceptible, qui impose un effort de migration à tous les développeurs utilisant la bibliothèque, est-ce souhaitable ? La question peut difficilement être tranchée, mais une fois que j’avais choisi le passage à « 3.0 », la porte était ouverte. Je dois dire que ces changements m’ont apporté un certain stress au moment de publier cette nouvelle version.

AcknowList 3.0 est maintenant disponible depuis quelques semaines, et, pour l’instant, personne ne semble s’en plaindre. Ouf.
