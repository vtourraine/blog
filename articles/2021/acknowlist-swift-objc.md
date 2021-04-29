Title:    AcknowList et la compatibilité avec Objective-C  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     April 29, 2021  
Update:   
Keywords: dev, iOS  
Summary:  Depuis 5 ans, je m’inflige de maintenir VTAck et AcknowList, deux bibliothèques qui implémentent exactement la même chose, en Objective-C et en Swift. Quand un bug est corrigé d’un côté, je le reprends pour l’autre. Quand une fonctionnalité est ajoutée d’un côté, rebelote. Un exercice qui était assez instructif au début, qui devient de plus en plus une corvée.  
Image:    
Language: fr  


Depuis 5 ans, je m’inflige de maintenir [VTAck](https://github.com/vtourraine/VTAcknowledgementsViewController) et [AcknowList](https://github.com/vtourraine/AcknowList), deux bibliothèques qui implémentent exactement la même chose, en Objective-C et en Swift. Quand un bug est corrigé d’un côté, je le reprends pour l’autre. Quand une fonctionnalité est ajoutée d’un côté, rebelote. Un exercice qui était assez instructif au début, qui devient de plus en plus une corvée.

La solution me paraît évidente : arrêter le développement sur VTAck, et encourager les projets qui l’utilisent à passer à AcknowList (un projet Objective-C peut très bien importer une bibliothèque en Swift).

Hélas, la situation est légèrement plus compliquée. AcknowList est bien utilisable depuis un code Objective-C, mais certaines fonctionnalités ne sont pas accessibles directement. Le modèle utilise des `struct` Swift, qui ne sont pas manipulables avec Objective-C. Concrètement, on peut instancier le view controller avec sa configuration par défaut, mais impossible de lui passer un tableau d’« acknowledgments » construits programmatiquement. C’est un peu comme si Objective-C avait une version bridée de la bibliothèque.

Quelles solutions, donc ?

Le plus simple serait de transformer les `struct` en `@objc class`. Le code changerait peu, et l’impact sur son fonctionnement serait limité à des considérations de gestion de la mémoire facilement surmontables. Mais j’aimerais éviter cette solution, parce qu’elle revient à « dé-swiftiser » la bibliothèque. J’ai bien conscience que cet argument est faible, mais je tiens aussi à conserver les avantages de Swift, ne pas me restreindre au plus petit dénominateur commun. Le choix entre `struct` et `class` est complexe, à tel point qu’Apple dispose d’[une page de documentation entièrement dédiée](https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes).

> - Use structures by default.
> - Use classes when you need Objective-C interoperability.

*To need or not to need, that is the question.*

Une autre solution consisterait à ajouter une couche intermédiaire exposant les structs avec une interface accessible en Objective-C. Ce code pourrait exister dans la bibliothèque directement, ou dans une sous-bibliothèque facultative. AcknowList ne serait pas manipulable à 100% avec Objective-C, mais les besoins principaux pourraient être satisfaits. Ceci dit, l’idée d’ajouter différentes couches à une bibliothèque aussi simple ne m’enthousiasme pas davantage.

Quelle est la meilleure solution ? En existe-t-il une autre ? Ou devrais-je simplement ignorer la compatibilité Objective-C ?

Je ne sais pas, et cet article est surtout une excuse pour réfléchir à voix haute sur ce problème. Si vous avez des suggestions, n’hésitez pas à les partager sur [GitHub](https://github.com/vtourraine/AcknowList).
