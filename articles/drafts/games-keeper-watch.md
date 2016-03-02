# Games Keeper sur Apple Watch

Après avoir parlé de [WatchKit](http://www.vtourraine.net/blog/2016/watchos-2-transition), puis de la publication de [Games Keeper 2.0](http://www.vtourraine.net/blog/2016/games-keeper-2-0), il ne me restait plus qu’à développer Games Keeper pour Apple Watch.


## Taille des boutons


## Menu item


## Property Observers

Avec Objective-C, on peut très bien re-définir le setter d’une property, mais il faut bien dire que la syntaxe offerte par Swift est bien plus élégante.

Je note au passage que placer des opérations dans `willSet`/`didSet` est parfois une fausse bonne idée, qui peut rendre un code plus difficile à comprendre, ou poser des problèmes de performances. Dans le cas présent, le code est suffisamment simple et son exécution prévisible pour se satisfaire de `didSet`.
