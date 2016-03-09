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


Après avoir parlé de [WatchKit](http://www.vtourraine.net/blog/2016/watchos-2-transition), puis de la publication de [Games Keeper 2.0](http://www.vtourraine.net/blog/2016/games-keeper-2-0), il ne me restait qu’une chose à faire : développer Games Keeper pour Apple Watch.

![Games Keeper pour Apple Watch](http://www.vtourraine.net/blog/img/2016/games-keeper-watch/games-keeper-watch-photo.jpg)

J’aime bien construire une app en commençant par le plus simple, pour ensuite envisager d’éventuelles évolutions. J’ai donc fait très simple. Tellement basique que ça ressemble plus à un code d’exemple qu’à un projet abouti. Une excellente occasion pour partager le projet dans son intégralité, et commenter le développement avec Swift/WatchKit.


## Storyboard

// Screenshot Storyboard

Rien d’extraordinaire pour le Storyboard : un seul controller, avec un label et deux boutons. Seule subtilité (visible sur le navigateur à gauche), le menu que j’évoquerai plus bas.


### Taille des boutons

Les boutons sont positionnés et dimensionnés pour faciliter l’utilisation et minimiser les erreurs de manipulation. Ce principe est valable pour toutes les interfaces sur toutes les plateformes, mais la taille physique des Apple Watch le rend particulièrement important.

Concrètement, plutôt que de configurer deux boutons avec les mêmes dimensions, je choisis d’agrandir celui qui sera le plus utilisé (le « + »). Dans ce cas précis, les dimensions sont données en pourcentage de la taille du conteneur, et donc de l’écran. On pourrait aussi les spécifier en fonction de la taille de la Watch (38 mm ou 42 mm), mais cette approche semble peu recommandable compte-tenu de l’histoire d’UIKit et de la taille des iPhones.


### Menu

Le controller dispose d’un menu, avec un unique item permettant de remettre le score à zéro.

Ces menus sont problématiques, car rien n’indique leur présence lorsqu’ils sont disponibles. On conseille donc généralement aux utilisateurs d’apps Apple Watch de _force-toucher_ (quel horrible terme) à l’aveugle tous les écrans, pour découvrir les menus proposés. C’est particulièrement gênant pour les fonctions accessibles uniquement par un menu, ce qui n’est pas vraiment le cas ici puisqu’un joueur peut toujours réinitialiser son score avec les boutons « +/− » (on peut donc le considérer comme un raccourci).

Ce n’est sans doute pas idéal, mais ces menus font partie des conventions d’interface pour watchOS, et la taille de l’écran pousse encore une fois à optimiser l’espace disponible.


## Code source

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


### Property Observers

Avec Objective-C, on peut très bien re-définir le setter d’une property, mais il faut bien dire que la syntaxe offerte par Swift est bien plus élégante.

Je note au passage que placer des opérations dans `willSet`/`didSet` est parfois une fausse bonne idée, qui peut rendre un code plus difficile à comprendre, ou poser des problèmes de performances. Dans le cas présent, le code est suffisamment simple et son exécution prévisible pour se satisfaire de `didSet`.


### IBOutlet!

``` swift
@IBOutlet var scoreLabel: WKInterfaceLabel!
```


GitHub Gist: [Interface.storyboard + InterfaceController.swift](https://gist.github.com/vtourraine/86f8871fdbbb696064b2).
