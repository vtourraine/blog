Title:     Nuages animés avec UIKit  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      August 30, 2018  
Update:     
Keywords:  iOS, app, dev  
Summary:   UIKit permet d’animer facilement n’importe quel élément affiché à l’écran. Il convient évidemment de faire preuve de retenue pour ne pas détruire son interface avec une avalanche d’animations, mais il faut aussi savoir s’amuser, et une petite dose d’animation suffit parfois à rendre une application unique et plus agréable à utiliser.  
Image:     https://www.vtourraine.net/blog/img/2018/air-grenoble-2-clouds-view/four-clouds.png  
Language:  fr  


UIKit permet d’animer facilement n’importe quel élément affiché à l’écran. Il convient évidemment de faire preuve de retenue pour ne pas détruire son interface avec une avalanche d’animations, mais il faut aussi savoir s’amuser, et une petite dose d’animation suffit parfois à rendre une application unique et plus agréable à utiliser.

La version initiale d’Air Grenoble présentait un fond bleu uni. Je voulais égayer un peu ça, notamment en rendant l’écran principal moins statique. J’ai donc ajouté des nuages qui flottent tranquillement en haut de l’écran. Ce n’est pas vraiment original pour ce genre d’application (l’application « Météo » d’Apple pousse le concept très loin, avec des animations adaptées à tous les climats possibles), mais on se lasse difficilement de regarder les nuages passer.

<p>
<video autoplay loop muted playsinline>
<source src="/blog/img/2018/air-grenoble-2-clouds-view/clouds-animation.mp4" type="video/mp4">
Vidéo non supportée
</video>
</p>

Voici donc ma solution pour animer des nuages en Swift avec UIKit. J’utilise uniquement des API de base. Ce n’est pas spécialement optimisé, mais ça devrait vous donner un exemple concret, à adapter selon vos besoins.

## Un nuage

On commence avec une nouvelle sous-classe de `UIView`. Son fond reste transparent par défaut, cette vue s’occupe uniquement de gérer le flot de nuages.

``` swift
import UIKit

class CloudsView: UIView {
}
```

On y insère des `UIImageView`, une par nuage. Ces images sont toutes identiques, pour plus de simplicité, mais on pourrait évidemment générer des formes aléatoires pour plus de variété. Plus précisément, j’utilise une forme vectorielle à partir d’un fichier PDF, importé avec un Asset Catalog classique. Ça m’évite de gérer différentes versions `@1x`/`@2x`/`@3x`, et je peux en modifier les dimensions à n’importe quel moment. Des PNG classiques peuvent bien sûr faire l’affaire si vous préférez.

On implémente donc une nouvelle méthode sur la vue pour ajouter un nuage à une position donnée. Je vais utiliser le terme _spawn_, tel qu’employé dans un jeu video, pour désigner l’apparition d’un nouveau nuage.

``` swift
static let CloudSize: CGSize = CGSize(width: 84, height: 54)

func spawnCloud(origin: CGPoint) {
  let imageView = UIImageView(image: UIImage(named: "Cloud"))
  imageView.tintColor = .white
  imageView.alpha = 0.7
  imageView.frame = CGRect(origin: .zero, size: CloudsView.CloudSize)
  imageView.center = origin
  addSubview(imageView)

  // animation…
}
```

Je lui donne une couleur blanche (l’image est en mode _Template Image_, donc sans couleur prédéfinie), et un peu de transparence. De cette façon, on obtiendra un rendu assez plaisant quand deux nuages se superposeront partiellement à l’écran.

![CloudsView, un nuage](/blog/img/2018/air-grenoble-2-clouds-view/one-cloud.png)

Passons tout de suite à l’animation qui nous intéresse : le déplacement latéral du nuage vers la droite. On définit une constante pour la durée. Elle permettra d’ajuster la rapidité du mouvement pour obtenir un résultat plaisant, mais elle sera aussi utile pour débugger plus efficacement, en fixant au besoin une valeur plus petite (donc une animation plus rapide).

Je demande au nuage de se déplacer vers la droite, sur une distance correspondant à la largeur de la vue, avec un peu de marge supplémentaire (cette marge sera utile plus tard pour prendre en compte la composante aléatoire du placement initial). De cette manière, quel que soit le point de départ à l’intérieur de la vue, le nuage devrait arriver hors-champs, à droite de la vue. On garde la même vitesse pour tous les nuages, sans calcul particulier. Pour les plus attentifs, on peut tout de suite prévoir un bug : si la taille de la vue change pendant l’animation (un iPad qui passe en mode paysage, par exemple), le nuage s’arrêtera dans une position visible à l’écran. On pourra toujours corriger ça par la suite. 

``` swift
// static let HorizontalRandomMaxOverflow: CGFloat = 200
// static let AnimationDuration: TimeInterval = 50

let boundsWidth = self.bounds.size.width
UIView.animate(withDuration: CloudsView.AnimationDuration, delay: 0, options: .curveLinear, animations: {
  imageView.center = CGPoint(x: origin.x + boundsWidth + CloudsView.CloudSize.width + CloudsView.HorizontalRandomMaxOverflow, y: origin.y)
}) { (completed) in
  if completed {
    imageView.removeFromSuperview()
  }
}
```

## Plusieurs nuages

Pour simuler un joli coin de ciel, on a besoin d’un ensemble de nuages initialement disposés aléatoirement dans la vue. Pour ne pas trop charger l’écran, je pars sur 2 ou 3 nuages. Swift 4.2 introduit justement une API pour [générer des nombres aléatoires](https://github.com/apple/swift-evolution/blob/master/proposals/0202-random-unification.md) qui nous sera très utile. 

``` swift
func spawnBunchOfCloudsInTheSky() {
  let NumberOfClouds = Int.random(in: 2...3)

  for _ in 0..<NumberOfClouds {
    spawnCloudInTheSky()
  }
}

func spawnCloudInTheSky() {
  let x = CGFloat.random(in: 0..<self.bounds.size.width)
  let y = CGFloat.random(in: (CloudsView.CloudSize.height / 2)..<(self.bounds.size.height - CloudsView.CloudSize.height / 2))
  // Je prend en compte la hauteur du nuage pour éviter qu’il dépasse en haut ou en bas de la vue.

  spawnCloud(origin: CGPoint(x: x, y: y))
}
```

En plus de cela, il me faudra continuellement générer de nouveaux nuages sur le côté gauche, pour fournir un flot ininterrompu. J’introduis un peu d’aléatoire sur la coordonnée `x` pour éviter des nuages espacés de façon trop régulière, et ainsi obtenir un rendu un peu plus naturel.

``` swift
func spawnCloudFromTheSide() {
  let x = CGFloat.random(in: -CloudsView.HorizontalRandomMaxOverflow..<0)
  let y = CGFloat.random(in: (CloudsView.CloudSize.height / 2)..<(self.bounds.size.height - CloudsView.CloudSize.height / 2))

  spawnCloud(origin: CGPoint(x: x, y: y))
}
```

![CloudsView, plusieurs nuages](/blog/img/2018/air-grenoble-2-clouds-view/four-clouds.png)

Pour finir, il suffit d’une méthode pour lancer l’animation. On saupoudre la vue de quelques nuages initiaux, et on démarre un timer à répétition pour en ajouter continuellement.

``` swift
static let SpawnTimeInterval: TimeInterval = 10

func startAnimation() {
  spawnBunchOfCloudsInTheSky()
  spawnCloudFromTheSide()

  Timer.scheduledTimer(withTimeInterval: CloudsView.SpawnTimeInterval, repeats: true) { (timer) in
    self.spawnCloudFromTheSide()
  }
}
```

Et le tour est joué, on obtient des nuages qui flottent tranquillement à l’écran.

<p>
<video autoplay loop muted playsinline>
<source src="/blog/img/2018/air-grenoble-2-clouds-view/clouds-animation.mp4" type="video/mp4">
Vidéo non supportée
</video>
</p>

Pour être complet, il convient de désactiver le timer quand la vue disparaît, et de refactorer quelques méthodes pour un code plus lisible. Si ça vous intéresse, vous trouverez le code complet dans ce [gist](https://gist.github.com/vtourraine/b306fe962cb359f7b5b55db80372d54c).
