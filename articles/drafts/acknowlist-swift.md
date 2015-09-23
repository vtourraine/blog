# AcknowList

// tags: swift, cocoapods

Cette semaine, j’ai publié une première version de [_AcknowList_][AcknowList], une bibliothèque Swift pour afficher les licenses d’une application avec CocoaPods. Si ça vous rappelle quelque chose, c’est parce que j’avais initialement créé [ce projet en Objective-C][VTAck], il y a presque deux ans. Les temps changent, il faut donc s’adapter (ou périr ?).


CocoaPods est un outil intéressant pour aborder cette ré-écriture. En modularisant clairement le code d’un projet, il permet de suivre  

Plutôt que de convertir un projet dans sa totalité, je trouve plus faire évoluer 

Dans mon cas, j’ai voulu mettre en pratique cette 

Swift a l’avantage de pouvoir se mélanger plutôt facilement avec Objective-C. Pour des projets existants en particulier, l’approche la plus raisonnable consiste donc à remplacer le code existant et à ajouter les nouvelles classes en Swift, progressivement. 


## Le nom, c’est important


## JSON/XML parsing


La transition des projets Objective-C existants vers Swift devrait nous occuper encore pour quelques années.

[AcknowList]: https://github.com/vtourraine/AcknowList
[VTAck]:      https://github.com/vtourraine/VTAcknowledgementsViewController