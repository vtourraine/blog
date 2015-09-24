# AcknowList

// tags: swift, cocoapods

Cette semaine, j’ai publié une première version de [_AcknowList_][AcknowList], une bibliothèque Swift pour afficher les licenses d’une application avec CocoaPods. Si ça vous rappelle quelque chose, c’est parce que j’avais initialement créé [ce projet en Objective-C][VTAck], il y a presque deux ans. Les temps changent, il faut donc s’adapter (ou périr ?).


CocoaPods est un outil intéressant pour aborder cette ré-écriture. En modularisant clairement le code d’un projet, il permet de suivre  

Plutôt que de convertir un projet dans sa totalité, je trouve plus faire évoluer 

Dans mon cas, j’ai voulu mettre en pratique cette 

Swift a l’avantage de pouvoir se mélanger plutôt facilement avec Objective-C. Pour des projets existants en particulier, l’approche la plus raisonnable consiste donc à remplacer le code existant et à ajouter les nouvelles classes en Swift, progressivement. 


## Le nom, c’est important

Comme n’importe quel autre projet, une bibliothèque a besoin d’un nom. Pour la version Objective-C, c’était donc _VTAcknowledgementsViewController_. Les licenses CocoaPods sont listées sous le terme « acknowledgements », et la classe principale est le view controller. C’est peut-être logique, mais c’est terrible à écrire, au point qu’il m’arrive régulièrement d’inverser certaines lettres.

Leçon retenue, pour la version Swift ce sera _AcknowList_.

Je suppose qu’on peut voir ça comme l’opposition entre la verbosité d’Objective-C et la brièveté de Swift. Indépendamment du langage, le choix du nom mérite un minimum de réflexion.


## XML parsing

Les données affichées par _AcknowList_ sont extraites automatiquement du fichier `Pods-acknowledgements.plist` généré par CocoaPods. Un .plist, c’est-à-dire un fichier XML à parser.

Pour la mise en mémoire, il suffit de laisser `NSDictionary` faire le travail (oui, avec Swift). On peut caster le résultat en `[String: AnyObject]`, pour retrouver des types propres au langage.

À partir de là, il faut explorer la structure de l’objet dynamiquement pour en extraire des informations ciblées. Je n’ai pas trouvé de solution élégante, et il semblerait que ce genre d’opération est toujours aussi fastidieuse, sinon davantage. Je n’ai pas étudié le problème en détail, mais il semblerait que Swift est bien parti pour avoir autant de bibliothèques de parsing XML/JSON qu’Objective-C.


##

La transition des projets Objective-C existants vers Swift devrait nous occuper encore pour quelques années.

[AcknowList]: https://github.com/vtourraine/AcknowList
[VTAck]:      https://github.com/vtourraine/VTAcknowledgementsViewController