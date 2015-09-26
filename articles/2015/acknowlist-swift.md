# AcknowList

// tags: swift, cocoapods

Cette semaine, j’ai publié une première version de [_AcknowList_][AcknowList], une bibliothèque en Swift pour afficher les licences d’une application avec CocoaPods. Si ça vous rappelle quelque chose, c’est parce que j’avais initialement créé [ce projet en Objective-C][VTAck], il y a presque deux ans. Les temps changent, il faut s’adapter.


## Redécoupage

CocoaPods est un outil intéressant pour aborder la transition vers Swift. 

En modularisant clairement le code d’un projet, il permet de suivre  

Plutôt que de convertir un projet dans sa totalité, je trouve plus faire évoluer 

Dans mon cas, j’ai voulu mettre en pratique cette 

Swift a l’avantage de pouvoir se mélanger plutôt facilement avec Objective-C. Pour des projets existants en particulier, l’approche la plus raisonnable consiste donc à remplacer le code existant et à ajouter les nouvelles classes en Swift, progressivement. 


## Le nom, c’est important

Comme n’importe quel autre projet, une bibliothèque a besoin d’un nom. Pour la version Objective-C, c’était donc _VTAcknowledgementsViewController_. Les licenses CocoaPods sont listées sous le terme « acknowledgements », et la classe principale est le view controller. C’est peut-être logique, mais c’est terrible à écrire, au point qu’il m’arrive régulièrement d’inverser certaines lettres.

Leçon retenue, pour la version Swift ce sera _AcknowList_.

Je suppose qu’on peut voir ça comme l’opposition entre la verbosité d’Objective-C et la brièveté de Swift. Indépendamment du langage, le choix du nom mérite un minimum de réflexion.


## Le retour de struct

Pour Objective-C, `struct` est avant-tout un héritage du C, peu utilisé. Avec Swift, le `struct` est de retour, à tel point qu’il devient parfois difficile de choisir entre ça et une classe. Dans le cas d’_AcknowList_, j’ai simplement transformé l’unique classe du modèle en structure. Avec deux propriétés et un constructeur, le choix était vite fait. 
Je n’ai pas assez de recul avec Swift pour en tirer de grandes conclusions. C’est un cas intéressant de conversion à partir d’Objective-C. Transformer une `class` en `class` est un choix valide, sûrement préférable en général, mais d’autres options sont possibles.


## XML parsing

Les données affichées par _AcknowList_ sont extraites automatiquement du fichier `Pods-acknowledgements.plist` généré par CocoaPods. Un .plist, c’est-à-dire un fichier XML à parser.

Pour la mise en mémoire, il suffit de laisser `NSDictionary` faire le travail (oui, avec Swift). On peut caster le résultat en `[String: AnyObject]`, pour retrouver des types propres au langage.

À partir de là, il faut explorer la structure de l’objet dynamiquement pour en extraire des informations ciblées. Je n’ai pas trouvé de solution élégante, et il semblerait que ce genre d’opération est toujours aussi fastidieuse, sinon davantage. Je n’ai pas étudié le problème en détail, mais il semblerait que Swift est bien parti pour avoir autant de bibliothèques de parsing XML/JSON qu’Objective-C.


## Tests

Le repo contient un projet Xcode qui permet d’avoir un exemple d’utilisation de la bibliothèque, et par la même occasion une _target_ de tests pour contrôler son fonctionnement. 

Le code pour iOS est parfois difficile à tester, mais _AcknowList_ s’y prête bien. Le parser reçoit des fichiers .plist en entrée pour sortir des `String` correspondantes. Pour les deux _view controllers_, je contrôle la valeur des éléments principaux après initialisation : texte pour le `UITextView`, nombre de cellules du _data source_ pour le `UITableView`.

Ces tests sont exécutés automatiquement avec [Travis CI][Travis CI]. Un simple [fichier de configuration][.travis.yml] de quelques lignes suffit pour mettre en place cette intégration, parfaitement coordonnée avec GitHub. Travis s’assure du bon fonctionnement des branches principales, ainsi que des pull-requests. Si vous avez un projet open-source, n’hésitez pas à le configurer pour Travis.


##

La transition des projets Objective-C existants vers Swift devrait nous occuper encore pour quelques années.

[AcknowList]:  https://github.com/vtourraine/AcknowList
[VTAck]:       https://github.com/vtourraine/VTAcknowledgementsViewController
[Travis CI]:   https://travis-ci.org/vtourraine/AcknowList
[.travis.yml]: https://github.com/vtourraine/AcknowList/blob/master/.travis.yml
