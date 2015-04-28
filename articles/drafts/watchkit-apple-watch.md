# Comment créer une application WatchKit pour Apple Watch

## Comment ça marche

Aujourd’hui, il est impossible de développer une application pour l’Apple Watch indépendante. La solution actuelle consiste à utiliser une Extension (une des grandes nouveautés iOS 8) spéciale, qui va projeter son interface sur la montre. Voilà pourquoi une application tierce cesse complètement de fonctionner dès que l’iPhone est hors de portée la montre.


## Nouvelle(s) target(s)

Cette action va créer deux targets : 

- Watch Extension : là où le code est exécuté, donc sur l’iPhone. Concrètement, c’est un ensemble de classes WatchKit.
- Watch Application : là où le résultat est projeté, donc sur l’Apple Watch. Aucun code, juste un Storyboard et des resources.

## Le classique : la table view

