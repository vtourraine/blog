Title:     Games Keeper sur Apple Watch  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      March 6, 2016  
Update:   
Keywords:  WatchKit, app, making-of  
Summary:     
Image:     http://www.vtourraine.net/blog/img/2016/games-keeper-watch/games-keeper-watch-photo.jpg  
Thumbnail: http://www.vtourraine.net/blog/img/2016/games-keeper-watch/thumbnail-games-keeper-watch.jpg  
Language:  fr  


Après avoir parlé de [WatchKit](http://www.vtourraine.net/blog/2016/watchos-2-transition), puis de la publication de [Games Keeper 2.0](http://www.vtourraine.net/blog/2016/games-keeper-2-0), il ne me restait plus qu’à développer Games Keeper pour Apple Watch.

![Games Keeper pour Apple Watch](http://www.vtourraine.net/blog/img/2016/games-keeper-watch/games-keeper-watch-photo.jpg)

J’aime bien commencer par construire une app simple, pour ensuite envisager d’éventuelles évolutions. J’ai donc fait très simple. Tellement basique que ça ressemble plus à un code d’exemple qu’à un projet abouti. Une excellente occasion pour partager le code source dans son intégralité, et commenter le développement avec WatchKit.


``` swift
// InterfaceController.swift

import WatchKit

class InterfaceController: WKInterfaceController {

  @IBOutlet var scoreLabel: WKInterfaceLabel!

  var score: Int = 0 {
    didSet {
      scoreLabel .setText(String(score))
    }
  }

  // MARK: - Actions

  @IBAction func decrementScore() {
    score = score - 1
  }

  @IBAction func incrementScore() {
    score = score + 1
  }

  @IBAction func resetScore() {
    score = 0
  }
}
```


## Taille des boutons

Les boutons sont positionnés et dimensionnés pour faciliter l’utilisation et minimiser les erreurs de manipulation. Ce principe est valable pour n’importe quelle plateforme, mais la taille physique des Apple Watch le rend particulièrement important.

Concrètement, plutôt que de configurer deux boutons avec les mêmes dimensions, je choisis d’agrandir celui qui sera le plus utilisé (le « + »). Dans ce cas précis, les dimensions sont données en pourcentage de la taille du conteneur, et donc de l’écran. Les boutons disposent aussi d’une taille intrinsèque, généralement suffisante, mais qui peut se révéler problématique quand deux boutons sont collés l’un à l’autre. 


## Menu item


## Property Observers

Avec Objective-C, on peut très bien re-définir le setter d’une property, mais il faut bien dire que la syntaxe offerte par Swift est bien plus élégante.

Je note au passage que placer des opérations dans `willSet`/`didSet` est parfois une fausse bonne idée, qui peut rendre un code plus difficile à comprendre, ou poser des problèmes de performances. Dans le cas présent, le code est suffisamment simple et son exécution prévisible pour se satisfaire de `didSet`.
