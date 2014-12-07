Title:    iOS : en quête de fluidité  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     June 15, 2012  
Update:   
Keywords: iOS, making-of, animation, optimisation, scrolling, UIKit, UITableView  
Summary:  Beaucoup d’applications iOS reposent sur une simple liste verticale d’éléments (la UITableView pour les intimes). C’est un élément central, incontournable. Comme toutes les autres vues, les cellules qui constituent ces listes peuvent être customisées librement avec des images, des labels, des boutons, etc.  
Image:    
Language: fr  
Project:  Contacts  

Beaucoup d’applications iOS reposent sur une simple liste verticale d’éléments (la UITableView pour les intimes). C’est un élément central, incontournable. Comme toutes les autres vues, les cellules qui constituent ces listes peuvent être customisées librement avec des images, des labels, des boutons, etc.

Tout va bien jusqu’au moment où vos cellules commencent à mettre trop de temps pour se charger, alourdies par le poids de ses ressources graphiques, et brisent alors la fluidité de défilement de votre vue. Notez qu’il suffit parfois de quelques sous-vues mal optimisées pour sentir la différence. Et là, c’est le drame.


## À la Tweetie

C’est justement ce qui est arrivé avec mon application « [Contact[s]](http://www.studioamanga.com/contacts/) ». Depuis sa première version sur l’App Store, elle peine à gérer correctement sa vue principale. Chaque cellule est constituée d’une image et d’un groupe de boutons. Rien d’excessif, à part peut-être la hauteur de ces éléments qui accentue les problèmes de performances.

Bien décidé à corriger cela, j’ai donc commencé par adapter la méthode popularisée par [Loren Brichter](http://www.twitter.com/lorenb) avec Tweetie, qui consiste à faire appel directement à Core Graphics pour dessiner le contenu des cellules. Il suffit de surcharger la méthode `drawRect:` d’une UITableViewCell pour éviter l’architecture en vues et sous-vues, et ainsi garder la main sur l’accès aux ressources graphiques.

![Tweetie][Tweetie]

Le résultat est incontestablement meilleur, mais pas encore satisfaisant.


## Transparence

La lenteur de défilement s’explique souvent par la présence de vues transparentes qui viennent alourdir le rendu graphique. Ce n’est pas pour rien que UIView possède une propriété nommée [isOpaque](http://developer.apple.com/library/ios/documentation/uikit/reference/uiview_class/uiview/uiview.html#//apple_ref/occ/instp/UIView/opaque). Il convient évidemment de limiter au maximum l’utilisation de la transparence.

Il existe d’ailleurs un moyen très simple permettant de visualiser ce paramètre dans une app. Lancez Instruments (“cmd+I”), choisissez une analyse “Core Animation” et cochez le bouton “Color Blended Layers” dans “Debug Options”. Vous pourrez alors admirer la répartition de l’opacité pour votre application, et pour iOS en général. Comme vous l’aurez compris, les parties en rouge risquent de causer davantage de problèmes que celles en vert.

![Blended Layers][Blended layers]

![Blended Layers : Contacts][Blended Contacts]

![Blended Layers : Settings][Blended Settings]

Le debug à base de zones rouges et vertes, c’est bon pour la santé, alors n’hésitez pas à essayer avec votre application.


## Taille des images

J’ai donc mis en place chacune de ces techniques, en espérant pouvoir obtenir des animations fluides. À mon grand désespoir, ce n’était toujours pas le cas.

Plus précisément, j’ai remarqué que certains thèmes (Contact[s] propose différentes textures afin de customiser l’interface) provoquaient toujours des lenteurs importantes, alors que d’autres redonnaient à l’application toute sa fluidité. Une même façon de gérer les ressources graphiques, mais des résultats bien différents.

Ce n’était pas un problème de poids des images, mais un problème de taille. Il s’avère que pour obtenir les meilleurs résultats, les textures doivent avoir des dimensions en multiple de 2. 32x32, 64x64, 128x128, etc. Lorsque les images respectent cette contraintes, les performances sont optimales.

Ce constat est peu surprenant lorsqu’on sait que l’interface d’iOS est entièrement gérée avec OpenGL, et que cette technologie ne supporte à la base que les textures ainsi dimensionnées. UIKit donne pourtant l’impression de pouvoir s’affranchir de ce type de contraintes, et c’est bien la première fois que je constate un impact de ce type. Si certaines de mes textures ne s’étaient pas trouvées avec ces dimensions particulières, je serais probablement toujours en train de chercher la clé de ce mystère.


## Conclusion

Chaque application est différente, et les techniques évoquées au cours de ce billet sont probablement les plus utiles pour régler ce type de problème. Vous trouverez par ailleurs sur le blog technique de Twitter un [excellent résumé](http://engineering.twitter.com/2012/02/simple-strategies-for-smooth-animation.html) des optimisations possibles dans ce genre de situations.

La dernière version de Contact[s], publiée cette semaine sur l’[App Store](http://itunes.apple.com/app/contact-s/id477281440?mt=8), propose donc enfin une interface vraiment fluide, pour la plus grande joie du développeur, et des utilisateurs. Tout est bien, qui finit bien.


[Tweetie]:            http://www.vtourraine.net/blog/img/ios-fluidite-animation-uitableview/tweetie.jpg
[Blended layers]:     http://www.vtourraine.net/blog/img/ios-fluidite-animation-uitableview/blended-layers.jpg
[Blended Contacts]:   http://www.vtourraine.net/blog/img/ios-fluidite-animation-uitableview/blended-contacts.jpg
[Blended Settings]:   http://www.vtourraine.net/blog/img/ios-fluidite-animation-uitableview/blended-settings.jpg
