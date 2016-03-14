Title:     Games Keeper sur Apple Watch  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      March 14, 2016  
Update:   
Keywords:  WatchKit, app, making-of  
Summary:   Après avoir parlé de WatchKit, puis de la publication de Games Keeper 2.0, il ne me restait qu’une chose à faire : développer Games Keeper pour Apple Watch. C’est maintenant chose faite.  
Image:     http://www.vtourraine.net/blog/img/2016/games-keeper-watch/games-keeper-watch-photo.jpg  
Thumbnail: http://www.vtourraine.net/blog/img/2016/games-keeper-watch/thumbnail-games-keeper-watch.jpg  
Language:  fr  


Après avoir parlé de [WatchKit](http://www.vtourraine.net/blog/2016/watchos-2-transition), puis de la publication de [Games Keeper 2.0](http://www.vtourraine.net/blog/2016/games-keeper-2-0), il ne me restait qu’une chose à faire : développer Games Keeper pour Apple Watch. C’est maintenant [chose faite](https://itunes.apple.com/app/games-keeper/id674138310?mt=8).

![Games Keeper pour Apple Watch](http://www.vtourraine.net/blog/img/2016/games-keeper-watch/games-keeper-watch-photo.jpg)

J’aime bien construire une app en commençant par le plus simple possible, pour ensuite envisager d’éventuelles évolutions. J’ai donc fait très simple. L’app propose un unique compteur de score, qu’on peut incrémenter, décrémenter, et remettre à zéro. Tellement basique que ça ressemble plus à un code d’exemple qu’à un projet abouti. Une excellente occasion pour partager le projet dans son intégralité, et commenter le développement avec Swift/WatchKit.


## Storyboard

![Storyboard Games Keeper pour Apple Watch](http://www.vtourraine.net/blog/img/2016/games-keeper-watch/games-keeper-watch-storyboard.png)

Rien d’extraordinaire pour le Storyboard : un seul controller, avec un label, deux boutons, et un menu.


### Taille des boutons

Les boutons sont positionnés et dimensionnés pour faciliter leur utilisation et minimiser les erreurs de manipulation. Ce principe est valable pour toutes les interfaces sur toutes les plateformes, mais la taille physique des Apple Watch le rend particulièrement important.

Concrètement, plutôt que de configurer deux boutons avec les mêmes dimensions, je choisis d’agrandir celui qui sera le plus utilisé (le « + »). Dans ce cas précis, les dimensions sont données en pourcentage de la taille du conteneur, et donc de l’écran. On pourrait aussi les spécifier en fonction de la taille de la Watch (38 mm ou 42 mm), mais cette approche semble peu recommandable compte-tenu de l’histoire d’UIKit et de la taille des iPhones.


### Menu

Le controller dispose d’un menu, avec un unique item permettant de remettre le score à zéro.

Ces menus sont problématiques, car rien n’indique leur présence lorsqu’ils sont disponibles. On conseille donc généralement aux utilisateurs d’apps Apple Watch de _force-toucher_ (quel nom horrible) à l’aveugle tous les écrans, pour découvrir les menus proposés. C’est particulièrement gênant pour les fonctions accessibles uniquement par un menu, ce qui n’est pas vraiment le cas ici puisqu’un joueur peut toujours réinitialiser son score avec les boutons « +/− » (on peut donc le considérer comme un raccourci).

Ce n’est sans doute pas idéal, mais ces menus font partie des conventions d’interface pour watchOS, et la taille de l’écran pousse encore une fois à optimiser l’espace disponible.


## Code source

``` swift
// InterfaceController.swift

import WatchKit

class InterfaceController: WKInterfaceController {

  @IBOutlet var scoreLabel: WKInterfaceLabel!

  var score: Int = 0 {
    didSet {
      scoreLabel.setText(String(score))
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

Voici donc l’intégralité du code source de l’application. À l’instar du Storyboard qui l’accompagne, difficile de faire plus simple.


### Property Observers

On peut re-définir le setter d’une property avec Objective-C, mais il faut bien dire que la syntaxe offerte par Swift est nettement plus élégante. J’utilise ici le `didSet` sur le score pour actualiser le label associé.

On notera au passage que placer des opérations dans `willSet`/`didSet` est parfois une fausse bonne idée, qui peut rendre un code plus difficile à comprendre, ou poser des problèmes de performances. Dans le cas présent, le code est suffisamment simple et son exécution prévisible pour s’en satisfaire.


### IBOutlet!

Lorsqu’on crée un `IBOutlet` avec l’assistant Interface Builder pour une classe Swift, Xcode définit une property « implicitly unwrapped », c’est-à-dire marquée par un `!`.

``` swift
@IBOutlet var scoreLabel: WKInterfaceLabel!
```

Xcode nous empêche d’ailleur de créer une property `IBOutlet` non-optionnelle, ce qui est plutôt logique.

![Xcode : IBOutlet avec Swift](http://www.vtourraine.net/blog/img/2016/games-keeper-watch/xcode-swift-iboutlet.png)

Mais la solution proposée par défaut me semble peu recommandable. Le « ! » en déclaration permet évidemment d’économiser du dépaquetage dans la suite du programme, mais masque complètement la nature instable de tous les appels à la property. Bien-sûr, dans le cas le plus simple (comme ici d’ailleurs), les IBOutlets resteront accessibles pour toute la durée de vie du controller, puisque retenus par l’arborescence des vues. Mais ces property peuvent très bien être mises à `nil`, ce qui ferait crasher l’app avec la déclaration par défaut.

Tout ça pour dire qu’Xcode devrait pluôt encourager, à mon avis, la déclaration de variables optionelles classiques pour les IBOutlet.


## // Comment

Pour finir, vous pouvez retrouver le code et le fichier Storyboard associé directement sur [GitHub](https://gist.github.com/vtourraine/86f8871fdbbb696064b2). 

La quantité de commentaire excédant maintenant largement la quantité de code source, il est temps de passer à des apps plus ambitieuses.
