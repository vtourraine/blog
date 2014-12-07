Title:    « T’as le look, Cocoa »  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     March 08, 2013  
Update:   
Keywords: iOS, UIKit, Cocoa, style  
Summary:  UIKit est votre ami. Si vous connaissez le développement iOS, vous maîtrisez déjà la plupart des éléments graphiques proposés par UIKit. Cette palette vous permet de construire rapidement une interface, à l’aide d’éléments standards, prêts à l’emploi. Comment faire alors pour personnaliser cette interface, pour rendre votre application unique et reconnaissable ?  
Image:    http://www.vtourraine.net/blog/img/ios-cocoa-custom-style/drawrect.png  
Language: fr  
Project:  

UIKit est votre ami. Si vous connaissez le développement iOS, vous maîtrisez déjà la plupart des éléments graphiques proposés par UIKit. Cette palette vous permet de construire rapidement une interface, à l’aide d’éléments standards, prêts à l’emploi. Comment faire alors pour personnaliser cette interface, pour rendre votre application unique et reconnaissable ?


## UIKit

La première solution consiste tout simplement à utiliser les propriétés mises à disposition par UIKit. `tintColor`, `backgroundImage`, `font`, autant d’occasions de modifier l'apparence des vues concernées. Il vous suffit de regarder la documentation de l’élément concerné pour connaître les propriétés à votre disposition. En utilisant Interface Builder, vous trouverez tout ça dans l’inspecteur.

Si ces modifications doivent s’appliquer de façon identique à toutes les instances d'un élément d'interface (exemple classique : modifier la `tintColor` de toutes les `UINavigationBar` de votre application), vous avez tout intérêt à utiliser le protocole `UIAppearance` disponible depuis iOS 5. En une seule ligne de code, vous appliquez ainsi une valeur à toutes les instances d’une classe, présentes et à venir.

Pour reprendre l’exemple de la barre de navigation :

``` objc
[[UINavigationBar appearance] setTintColor:[UIColor greenColor]];
```

Besoin de contextualiser une valeur ? Vous pouvez alors préciser un « contenant ». On peut par exemple utiliser une couleur différente selon qu’un `UIBarButtonItem` se trouve dans une `UINavigationBar` ou une `UIToolbar`.

``` objc
[[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:[UIColor blackColor]];
[[UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil] setTintColor:[UIColor redColor]];
```

![UIBarButtonItem styles, Vincent Tourraine][UIBarButtonItems]

Et pour encore plus de précision, ces définitions ne vous empêchent pas de modifier ponctuellement les propriétés concernées pour une instance donnée, de façon classique.

Documentation : [UIAppearance Protocol Reference](http://developer.apple.com/library/ios/#documentation/uikit/reference/UIAppearance_Protocol/Reference/Reference.html)

Ces solutions sont sûrement les plus simples, et souvent les meilleures. Mais ce n’est pas toujours suffisant. Il existe notamment des propriétés moins explicites, un peu cachées, qui sont pourtant très utiles pour personnaliser rapidement un élément UIKit.


## CALayer

Toutes les vues disposent d’une propriété `layer`, de type `CALayer`, qui entre en jeu lors du rendu à l’écran (vaste sujet). Ce layer est en lecture seule, mais vous pouvez le customiser très facilement. Besoin d’ajouter une ombre portée autour de votre vue ? Pas de problème. Une bordure pour marquer les contours ? Facile. Avec des coins arrondis ? Trivial. Importez simplement le framework QuartzCore, et à vous de jouer.

``` objc
#import <QuartzCore/QuartzCore.h>

(...)

UIView *view1 = (...);

view1.layer.borderWidth = 4;
view1.layer.borderColor = [UIColor blackColor].CGColor;
view1.layer.cornerRadius = 20;

UIView *view2 = (...);

view2.layer.shadowRadius = 10;
view2.layer.shadowColor = [UIColor blackColor].CGColor;
view2.layer.shadowOpacity = 0.8;
```

![CALayer, Vincent Tourraine][CALayer]

Petit bémol, vous ne pouvez pas utiliser l’ombre portée et les coins arrondis d’un `CALayer` en même temps. En effet, les coins ont besoin du clipping (`view.clipToBounds = YES`) pour masquer la partie extérieure du coin, alors que l’ombre a besoin au contraire de désactiver le clipping pour se dessiner autour de la vue elle-même. Vous pouvez vous en sortir en imbriquant deux layers, ou trouver une solution complémentaire. Ou encore limiter l’utilisation de ce genre de décorations (un peu ça va, beaucoup bonjour les dégâts).

Documentation : [CALayer Class Reference](http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Reference/CALayer_class/Introduction/Introduction.html#//apple_ref/doc/c_ref/CALayer)


## UIImage

Créer une `UIImage` à partir d’un fichier .jpg ou .png, rien de plus facile. Imaginons que vous souhaitiez utiliser une image de fond pour un bouton, dont vous ne connaissez pas a priori les dimensions. On peut alors utiliser une image étirable, qui s'adaptera automatiquement aux dimensions de la vue concernée. Il suffit de préciser la taille de la zone redimensionnable, et choisir entre étirer ou bien répéter le contenu de l’image.

``` objc
UIImage *image = ...;
UIEdgeInsets insets = UIEdgeInsetsMake(30, 30, 30, 30);

UIImageView *imageView1 = ...;
imageView1.image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];

UIImageView *imageView2 = ...;
imageView2.image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
```

![Image redimensionnable, Vincent Tourraine][Resizable]

Documentation : [UIImage Class Reference](http://developer.apple.com/library/ios/#documentation/uikit/reference/UIImage_Class/Reference/Reference.html)


## UIColor

Certains éléments d’UIKit ne permettent pas d’utiliser directement une image. Comment appliquer une texture de fond à une `UIView` qui ne propose que backgroundColor ? Il suffit de créer une couleur à partir d’une image. C’est un peu surprenant, mais très efficace, surtout pour des textures.

``` objc
UIImage *image = ...
UIView *view = ...

view.backgroundColor = [UIColor colorWithPatternImage:image];
```

![Pattern image, Vincent Tourraine][Pattern]

Documentation : [UIColor Class Reference](http://developer.apple.com/library/ios/#documentation/uikit/reference/UIColor_Class/Reference/Reference.html)


## Core Graphics à la rescousse

Lorsque les composants d’UIKit ne suffisent pas à obtenir l’effet recherché, il existe une solution imparable : tout faire soi-même, à grands coups de Core Graphics. 

Toutes les vues de votre application possèdent une méthode `drawRect:` qui sert à se dessiner au sein d’un “contexte graphique”. C’est ce qui permet à la vue d’exister visuellement. Il ne faut jamais appeler cette méthode directement, et vous avez rarement besoin de la définir vous-même.

À ce niveau, tout est permis. Tout est fastidieux, aussi, parce qu’il vous faudra prendre en charge chaque étape de la représentation de votre vue. Pour faciliter un peu les choses, et rendre le code plus lisible, vous pouvez compter sur `UIBezierPath`. Comme son nom l’indique, il s’agit de dessiner des courbes de [Pierre Bézier](http://fr.wikipedia.org/wiki/Pierre_Bézier). C’est aussi un ensemble de méthodes qui facilitent grandement la construction des formes élémentaires. Voyons un exemple d’utilisation :

``` objc
-  (void)drawRect:(CGRect)rect {
  [[UIColor blackColor] setStroke];
  [[UIColor orangeColor] setFill];

  UIBezierPath *backgroundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 10, 10) cornerRadius:20];
  [backgroundPath fill];
  [backgroundPath setLineWidth:10];
  float dashPattern[] = {100, 20};
  [backgroundPath setLineDash:dashPattern count:2 phase:0];
  [backgroundPath stroke];

  UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(rect, 50, 50)];
  [circlePath setLineWidth:5];
  [circlePath stroke];

  UIBezierPath *zPath = [UIBezierPath bezierPath];
  [zPath moveToPoint:CGPointMake(100, 80)];
  [zPath addLineToPoint:CGPointMake(130, 140)];
  [zPath addLineToPoint:CGPointMake(240, 100)];
  [zPath setLineWidth:15];
  [[UIColor purpleColor] setStroke];
  [zPath stroke];
}
```

![drawRect: personnalisé, Vincent Tourraine][DrawRect]

Beaucoup de code pour un résultat esthétiquement discutable, mais tout ça réalisé avec une seule vue, et de la façon la plus optimisée qui soit. Encore une fois, je ne vais pas détailler l’ensemble des méthodes proposées par `UIBezierPath`, je vous laisse explorer la documentation.

Documentation : [UIBezierPath Class Reference](http://developer.apple.com/library/ios/#documentation/uikit/reference/UIBezierPath_class/Reference/Reference.html)

Oh, et si ce genre de code vous paraît vraiment trop pénible à produire, sachez qu’il existe au moins une application pour créer des vues avec un éditeur de dessin vectoriel, qui s’occupe justement de générer le code Core Graphics correspondant. Ça s’appelle [PaintCode](http://www.paintcodeapp.com), et ça coûte un peu cher, mais vous pouvez par exemple l’offrir à votre collègue graphiste.


## Conclusion

J’espère que ces quelques pistes vous aideront à personnaliser vos apps de façon efficace.

On peut passer des heures à mettre péniblement en place une interface, ou connaître la méthode magique qui permet de faire la même chose en une simple ligne de code. Comme souvent, la documentation officielle est votre amie. Et n’oubliez pas que la seule chose pire qu’une interface non customisée, c’est une interface mal customisée.


[UIBarButtonItems]: http://www.vtourraine.net/blog/img/ios-cocoa-custom-style/appearance-barbuttonitem.png
[CALayer]:          http://www.vtourraine.net/blog/img/ios-cocoa-custom-style/calayer.png
[Resizable]:        http://www.vtourraine.net/blog/img/ios-cocoa-custom-style/resizable.png
[Pattern]:          http://www.vtourraine.net/blog/img/ios-cocoa-custom-style/pattern.png
[DrawRect]:         http://www.vtourraine.net/blog/img/ios-cocoa-custom-style/drawrect.png
