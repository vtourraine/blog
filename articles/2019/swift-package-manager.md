Title:     Swift Package Manager  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      October 11, 2019  
Update:    
Keywords:  dev, Swift  
Summary:   Le formidable succès de CocoaPods ne pouvait aboutir qu’à une seule chose : la création par Apple d’un outil similaire, plus limité, mais mieux intégré au reste de l’écosystème. C’est donc Swift Package Manager (SPM). Le projet existe depuis 2015, mais la communauté des développeurs iOS semble y porter un plus grand intérêt cette année avec son intégration à Xcode 11.  
Image:     
Language:  fr  


Le formidable succès de [CocoaPods](https://cocoapods.org/) ne pouvait aboutir qu’à une seule chose : la création par Apple d’un outil similaire, plus limité, mais mieux intégré au reste de l’écosystème. C’est donc [Swift Package Manager](https://swift.org/package-manager/) (SPM). Le projet existe depuis 2015, mais la communauté des développeurs iOS semble y porter un plus grand intérêt cette année avec son intégration à Xcode 11.

J’utilise CocoaPods pour presque tous mes projets. J’en suis pleinement satisfait, je n’ai donc pas de raisons de passer à SPM. Je développe aussi quelques bibliothèques open source disponibles avec CocoaPods et Carthage (même si je n’ai jamais utilisé ce dernier). Il y a quelques mois, un utilisateur [a posté sur GitHub un ticket](https://github.com/vtourraine/AcknowList/issues/53) demandant si ma bibliothèque allait bientôt supporter SPM. Je n’avais pas d’avis sur la question, j’ai donc laissé le ticket ouvert, sans réponse particulière. Le ticket a amassé plusieurs « 👍 ». Puis, un autre utilisateur [a envoyé une pull request](https://github.com/vtourraine/AcknowList/pull/58), permettant le support de SPM en ajoutant un unique fichier. Cet intérêt m’a enfin poussé à regarder la chose de plus près.

En quelques jours, j’ai actualisé deux de [mes](https://github.com/vtourraine/AcknowList) [bibliothèques](https://github.com/vtourraine/ThirdPartyMailer) pour supporter SPM, et modifié deux de mes applications pour passer les dépendances de CocoaPods à SPM. L’intégration à Xcode est vraiment appréciable. Le fichier `Manifest.swift` donne l’impression d’être l’évolution naturelle du `podspec` pour CocoaPods. Pour des bibliothèques simples, SPM fonctionne à merveille. Mais les choses se compliquent vite. En particulier, SPM ne gère pas officiellement les fichiers de resources (images, localisation, etc). On peut les charger dans certains contextes, mais leur inclusion n’est pas formalisée.

À l’image de Swift, Apple prend son temps pour construire des fondations solides, et donner au projet les meilleures chances de réussite pour l’avenir. CocoaPods reste incontournable aujourd’hui. Swift Package Manager fait figure de débutant, qui ne demande qu’à s’améliorer.
