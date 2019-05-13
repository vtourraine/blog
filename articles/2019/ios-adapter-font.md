Title:     iOS : adapter une police de caractères  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      May 13, 2019  
Update:    
Keywords:  dev, iOS  
Summary:   Je vous propose un petit jeu. Pendant plusieures années, l’écran principal de mon application Games Keeper affichait un bug. Saurez-vous le trouver sur cette image ?  
Image:     https://www.vtourraine.net/blog/img/2019/ios-adapter-font/games-keeper-font-before.png  
Language:  fr  


Je vous propose un petit jeu. Pendant plusieures années, l’écran principal de mon application [Games Keeper](https://www.studioamanga.com/gameskeeper) affichait un bug. Saurez-vous le trouver sur cette image ?

![Écran principal Games Keeper, avant](/blog/img/2019/ios-adapter-font/games-keeper-font-before.png)

Premier indice : ça se voit comme le nez au milieu de la figure. Second indice : le titre de cet article de blog, forcément.

...

...

...

...

Réponse : le score principal au milieu de l’écran était affiché avec la police Helvetica Neue, alors que le reste de l’interface utilisait San Francisco.

Ce bug était donc visible depuis le passage à iOS 9 en 2015, avec le changement de police par défaut, mais le code en question était encore plus vieux. Car ce bug est bien plus évident dans le code, où la police était hardcodée directement. Pour un label aussi grand, je souhaitais utiliser la variante « light » de la police, le classique `systemFontOfSize:` n’était donc pas suffisant.

``` Objective-C
CGFloat size = 100;
self.scoreLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
```

Évidemment, il existe une meilleure façon pour arriver au résultat souhaité. UIKit propose plusieurs méthodes et classes autour d’`UIFont` pour adapter une police de caractères en fonction de certains critères. Dans le cas présent, il s’agit simplement de préciser la variante pour une taille donnée.

``` Objective-C
CGFloat size = 100;
self.scoreLabel.font = [UIFont systemFontOfSize:size weight:UIFontWeightLight];
```

En général, il est fort utile de prendre en compte le _Dynamic Type_ (c’est à dire la configuration de la taille du texte au niveau du système) lorsqu’on manipule une police sur iOS. Pour avoir une idée de son importance, [cet article](https://pspdfkit.com/blog/2018/improving-dynamic-type-support/) mentionne qu’un quart des utilisateurs choisissent de modifier le réglage par défaut. Mais dans ce cas précis, la taille du label est tellement grande que je choisis d’ignorer ce paramètre. La constante utilisée pour la taille du texte ici dépend uniquement de la _size class_ de la vue principale (pour faire simple : une constante sur iPhone, une autre constante sur iPad).

Et revoici l’écran de _Games Keeper_, avec le label du score correctement configuré.

![Écran principal Games Keeper, après](/blog/img/2019/ios-adapter-font/games-keeper-font-after.png)
