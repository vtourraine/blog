Title:    Intégration continue OS X et iOS avec Travis CI  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     May 06, 2013  
Update:   
Keywords: OS X, iOS, Objective-C, TDD, Travis  
Summary:  Il faut savoir regarder la vérité en face : les projets OS X et surtout iOS incluant des tests unitaires sont plutôt rares. Les contraintes techniques entourant les plateformes d’Apple compliquent leur intégration, et donc leur mise en œuvre. Mais rassurez-vous, les choses s’améliorent.  
Image:    https://www.vtourraine.net/blog/img/osx-ios-tests-unitaires-travis/travis.png  
Language: fr  
Project:  

Il faut savoir regarder la vérité en face : les projets OS X et surtout iOS incluant des tests unitaires sont plutôt rares. Les contraintes techniques entourant les plateformes d’Apple compliquent leur intégration, et donc leur mise en œuvre. Mais rassurez-vous, les choses s’améliorent.

Travis CI est une plateforme d’intégration continue hébergée, Open Source, et gratuite. [Depuis un mois](http://about.travis-ci.org/blog/introducing-mac-ios-rubymotion-testing/), elle propose aussi la prise en charge des projets OS X et iOS (ainsi que RubyMotion). Il vous suffit d’une simple ligne de configuration dans votre projet pour en bénéficier. C’est assez génial.

![Logo Travis CI][TravisCI]


## Marche à suivre

Prenons donc un projet bénéficiant de tests unitaires. Petit rappel : Xcode vous propose d’ajouter une target de tests à la création d’un projet, mais vous pouvez bien sûr aussi en ajouter a posteriori.

Tout ceci est intéressant, mais je vous ai promis une configuration en une seule ligne de code. Chose promise, chose due. À la racine de votre projet, créez simplement un fichier nommé `.travis.yml`, avec pour contenu `language: objective-c`. Et voilà !

Une fois votre projet hébergé publiquement sur GitHub, vous pourrez vous identifier sur [travis-ci.org](http://travis-ci.org) (avec votre compte GitHub justement), et y spécifier le repository en question (a.k.a. _« turn on the Travis service hook »_). Le tour est joué, les tests seront maintenant exécutés automatiquement pour chaque nouvelle version du code.


## Configurons un peu

Par défaut, sans aucune information supplémentaire, Travis se charge de lancer les tests automatiquement à l’aide d’un [script](https://github.com/jspahrsummers/objc-build-scripts) générique. Il est bien sûr possible, et souvent nécessaire, de personnaliser un peu cette configuration de base.

Nous allons utiliser une ligne de commande pour exécuter ces tests, à l’aide d’un outil fourni avec Xcode qui s’appelle « [xcodebuild](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/xcodebuild.1.html) ». Si vous utilisez un projet (`.xcodeproj`), vous pouvez alors lui adresser directement la target concernée.

Si vous utilisez un workspace (`.xcworkspace`), en revanche, il vous faudra donner le nom du scheme, et non pas celui de la target. Cette différence est compréhensible, puisque la particularité d’un workspace consiste justement à configurer une ou plusieurs targets de test. Pour les détails, je vous renvoie vers la [documentation d’Xcode](http://developer.apple.com/library/mac/#documentation/developertools/Conceptual/UnitTesting/04-Configuring_a_Scheme_to_Run_Unit_Tests/scheme.html). Attention au passage : les schemes ne sont pas partagés par défaut, et donc exclus de votre gestionnaire de versions. Pensez à cocher la case “Shared” dans la vue de configuration.

Vous avez au moins une bonne raison d’utiliser un workspace : [CocoaPods](http://cocoapods.org). Encore un sujet qui mériterait un billet dédié, mais pour expliquer brièvement, il s’agit d’un outil de gestion de dépendances pour vos projets OS X et iOS. Un outil tellement génial qu’il se retrouve installé par défaut sur les machines virtuelles Travis. Mieux : le fameux `pod install` nécessaire à résolution des dépendances est lancé automatiquement lorsqu’un projet utilise CocoaPods.

À partir de là, tout est possible pour personnaliser l’exécution de vos tests. Le fichier `.travis.yml` déjà créé peut contenir des instructions qui seront exécutées afin de lancer les tests. Vous pouvez également invoquer un fichier script dédié, comme le [Makefile](https://github.com/dulaccc/DPMeterView/blob/master/Makefile) donné en exemple par Travis.


## À propos d’iOS

Tout ceci fonctionne à merveille pour des applications OS X. En ce qui concerne iOS, la situation est un peu plus compliquée.

Les outils mis à disposition par Apple nécessitent l’utilisation du Simulateur pour exécuter une série de tests. Ce n’est pas un problème lorsque vous utilisez votre poste de travail classique, mais c’en est un lorsqu’il s’agit de machines virtuelles souhaitant opérer en mode headless.

Il existe plusieurs moyens pour contourner ce problème. On trouve notamment des projets comme [ios-sim](https://github.com/phonegap/ios-sim), qui permettent justement de lancer un simulateur depuis une ligne de commande, avec certains paramètres qui ne sont pas proposés avec les outils officiels. Vous pouvez prendre exemple sur le projet [LetterpressPlayer](https://travis-ci.org/jpsim/LetterpressPlayer), configuré pour Travis et qui utilise justement ios-sim pour ses tests.

Ce genre de mécanisme n’étant pas supporté par Apple, il demande un certain effort de maintenance, puisque chaque mise à jour d’Xcode peut entraîner une incompatibilité des programmes concernés.

Dans la mesure du possible, je préfère donc restreindre les tests unitaires pour un projet iOS au modèle et à une partie des contrôleurs (cf. MVC) pouvant être inclus et exécutés depuis une application OS X. Concrètement, ne pas tester l’interface, et se concentrer sur la fameuse “logique métier”. Il est difficile de tester efficacement les vues d’une application, et encore plus un contexte d’exécution et d’enchainement de ces vues. Il me semble donc plus judicieux et plus efficace dans la plupart des cas d’utiliser un second projet de type OS X, testant le code utilisé pour l’application iOS. Dans ces conditions, les outils standards d’Apple fonctionnent parfaitement. À vous de choisir entre une (supposée) couverture à 100%, et la stabilité d’exécution des tests. Non, les tests ne sont pas une finalité, mais oui, ils peuvent vous faire gagner du temps.


[TravisCI]: /blog/img/osx-ios-tests-unitaires-travis/travis.png
