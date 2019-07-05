Title:     iOS 13 : conserver la couleur d’une barre de navigation avec un grand titre  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      July 5, 2019  
Update:    
Keywords:  dev, iOS  
Summary:   iOS 13 change beaucoup de petites choses pour les barres de navigation. Le plus frappant, peut-être, est qu’une barre avec un grand titre fusionne complètement avec le fond de la vue principale. La « barre » disparaît, pour ne laisser que le titre et les éventuels boutons de chaque côté.  
Image:     https://www.vtourraine.net/blog/img/2019/ios-13-navigation-bar-color/onelist-ios-12-ios-13.png  
Language:  fr  

iOS 13 change beaucoup de petites choses pour les barres de navigation. Le plus frappant, peut-être, est qu’une barre avec un grand titre fusionne complètement avec le fond de la vue principale. La « barre » disparaît, pour ne laisser que le titre et les éventuels boutons de chaque côté. Le changement visuel est d’autant plus remarquable que la barre de navigation reprend ses couleurs classiques après que l’utilisateur ait défilé le contenu, lorsque le titre reprend sa taille normale.

Si vous ne voyez pas de quoi je parle, voici un exemple en images. Le même code, exécuté sur iOS 12 et sur iOS 13 :

![1List sur iOS 12 et le même écran sur iOS 13](/blog/img/2019/ios-13-navigation-bar-color/onelist-ios-12-ios-13.png)

Il faut toujours un certain temps pour s’adapter à ces changements d’interface. Quand la barre de navigation utilise le style par défaut (fond très clair, avec un effet de transparence), je trouve que la nouvelle apparence fonctionne bien. Mais quand la barre utilise une couleur de fond différente, la distinction entre grand titre et titre normal me paraît trop marquée, et le fond blanc appliqué sur l’intégralité de l’écran me paraît bien fade.

Mon application [1List](https://www.studioamanga.com/onelist/) utilise une barre de navigation bleue. Je souhaite conserver la couleur de cette barre avec iOS 13, mais j’ai eu beaucoup de difficultés pour comprendre comment y arriver avec les changements apportés à UIKit. C’est finalement [ce fil Twitter](https://twitter.com/rincewindsama/status/1143917018397102080) qui m’a mis sur la bonne voie.

1. Créer un object `UINavigationBarAppearance`
2. Lui donner une apparance de base (`default`, `opaque`, `transparent`) avec la méthode correspondante, ici `configureWithOpaqueBackground`
3. Y appliquer les changements souhaités, en particulier `backgroundColor` pour la couleur de fond
4. Assigner cet objet à la propriété `scrollEdgeAppearance` de la barre de navigation

Cette notion de « scroll edge appearance » est donc associée à l’état non-défilé d’une barre de navigation avec un grand titre. La terminologie n’est pas franchement évidente. Et vous pouvez personnaliser de la même façon les `standardAppearance` et `compactAppearance` (pour un iPhone en orientation paysage).

Voilà, le tour est joué. 1List a retrouvé sa barre de navigation bleue.

``` objc
UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
[appearance configureWithOpaqueBackground];
appearance.largeTitleTextAttributes = @{NSForegroundColorAttributeName : UIColor.whiteColor, NSFontAttributeName: [UIFont boldSystemFontOfSize:34]};
appearance.backgroundColor = [UIColor blueColor];
self.navigationBar.tintColor = [UIColor whiteColor];
self.navigationBar.scrollEdgeAppearance = appearance;
```

![1List sur iOS 13, avec la barre de navigation corrigée](/blog/img/2019/ios-13-navigation-bar-color/onelist-ios-13-fixed.png)
