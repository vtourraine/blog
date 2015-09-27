Title:    AcknowList  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     September 26, 2015  
Update:   
Keywords: Swift, CocoaPods, dev  
Summary:    
Image:    http://www.vtourraine.net/blog/img/2015/dotswift-swift/banner-dotswift.jpg   
Language: fr  


Cette semaine, j’ai publié une première version de [_AcknowList_][AcknowList], une bibliothèque en Swift pour afficher les licences CocoaPods à l’intérieur d’une application. Si ça vous rappelle quelque chose, c’est parce que j’avais initialement créé [ce projet en Objective-C][VTAck], il y a presque deux ans.

Les temps changent, il faut s’adapter. Toutes les occasions de mettre Swift en pratique sont bonnes à prendre, et on peut bien sûr en tirer quelques leçons.


## Re-découpage

CocoaPods est un outil intéressant pour aborder la transition vers Swift.

Plutôt que de convertir un projet dans sa totalité, on peut ainsi limiter la quantité du code concerné en formant des blocs, par ailleurs réutilisables. Il est toujours possible de transformer un projet classe par classe, mais sans direction particulière je trouve cette approche un peu laborieuse et confuse.

CocoaPods n’est clairement pas indispensable, mais il permet de définir une certaine architecture du code. Le développement logiciel gravite toujours autour des problématiques de découpage et de conceptualisation, la transition vers Swift ne fait pas exception.


## Le nom, c’est important

Comme n’importe quel autre projet, un pod a besoin d’un nom. Pour la version Objective-C, c’était donc _VTAcknowledgementsViewController_. Les licenses CocoaPods sont listées sous le terme « acknowledgements », et la classe principale est le view controller. C’est peut-être logique, mais c’est terrible à écrire, au point qu’il m’arrive régulièrement d’inverser certaines lettres.

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
