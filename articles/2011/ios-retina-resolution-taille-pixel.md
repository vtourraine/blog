Title:    iOS, Retina, et le pixel parfait
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     October 07, 2011  
Update:   
Keywords: iOS, Retina, résolution, taille, iPhone, iPad
Summary:  Les qualités esthétiques et ergonomiques des applications iOS dépendent très largement d’un simple et unique facteur : la taille invariable de l’écran. C’est peut-être la caractéristique qui différencie le plus iOS de ses concurrents, mais aussi du web en général. Voyons comment gérer efficacement les pixels à votre disposition.
Image:    
Language: fr

Les qualités esthétiques et ergonomiques des applications iOS dépendent très largement d’un simple et unique facteur : la taille invariable de l’écran. C’est peut-être la caractéristique qui différencie le plus iOS de ses concurrents, mais aussi du web en général. Voyons comment gérer efficacement les pixels à votre disposition.

## Tout commence avec le 320x480

L'iPhone possède à l'origine un écran de 320 par 480 pixels. Vous pouvez aussi retenir la hauteur pour la barre de statut : 20 pixels, la barre de navigation : 44 pixels, ou encore la TabBar de 50 pixels.

La plupart des applications iOS adossées à l'API standard (CocoaTouch) sont donc conçues à l'intérieur de ce canevas, pourtant très restrictif. Cette limitation constitue un atout formidable, facilitant chaque étape de la création d'une application : le designer pense pour une seule taille d'écran, le graphiste fixe les dimensions des fichiers PSD, et le développeur positionne tous ces éléments avec la précision voulue, et l'assurance que tous les utilisateurs bénéficieront du même résultat.

_Au pixel près_.

C'est d'ailleurs un facteur clé dans la comparaison entre applications natives et applications web, y compris en dehors du mobile. Un fantasme qu'il faut dépasser à l'intérieur d'un navigateur ou pour un mobile générique, mais qui trouve tout son sens sur un écran d'iPhone. Avec la réussite qu'on lui connaît.

## L’iPhone 4 et le 640x960, a.k.a. « Retina Display »

Lors de la présentation de l'iPhone 4, Apple a largement commenté son nouvel écran, baptisé "Retina Display". Tenu à une certaine distance, les pixels deviennent imperceptibles à l'oeil nu, et c'est ce seuil physiologique qu'Apple prétend avoir dépassé, mettant par conséquent un terme à la course aux pixels des autres constructeurs.

Cette vision contient sa part de réalité, mais l'argument décisif est ailleurs. Comment conserver la force du 320x480 des premiers iPhone, tout en améliorant l'écran ? Simple : doubler le nombre de pixels. On obtient donc un 640 par 960 pixels, qui intègre trivialement les ressources taillées pour la taille précédente.

Alors comment faire ?

Il existe une méthode permettant de récupérer à tout moment la taille de l'écran :

``` objc
CGSize screenSize = [[UIScreen mainScreen] bounds].size;
```

Seulement voilà, le résultat sera le *même* sur tous les modèles d'iPhone, Retina ou non : `{320, 480}`.

C'est un peu déroutant, mais cela permet de faire correspondre exactement le code pour les 2 versions de l'écran. Pour différencier un écran Retina, il faudra faire appel à une autre méthode :

``` objc
CGFloat scale = [[UIScreen mainScreen] scale];
```


Cette valeur est égale à "1" pour un écran normal, à "2" pour un écran Retina. Mais il est peu probable que cette méthode vous soit utile directement. En effet, *il est important de ne pas concevoir une application pour iPhone 4(S) spécifiquement*. Celle-ci doit fonctionner de la même manière sur tous les modèles d'iPhone, affichage compris.

Lorsque vous souhaitez tirer parti de l'écran Retina (parce que c'est quand même très joli), il suffit de fournir un double pour chacune des images utilisées par votre application, avec une seconde version faisant le double de la taille de la première, et en ajoutant le suffixe "@2x" au nom du fichier. *C'est tout.* Par exemple :

```
./img/logo.png
./img/logo@2x.png
```

Je veux insister encore une fois sur la simplicité de cette démarche : concevez l'application sans vous soucier du Retina, et ajoutez simplement le double de chaque image aux ressources du projet. Tout le reste est très bien géré par iOS, profitons-en.


## Et enfin l’iPad.

Les choses se compliquent sensiblement avec l'iPad (arrivé quelques mois avant l'iPhone 4, mais peu importe).

L'iPad possède un écran de 1024 par 768 pixels. On notera tout de suite que le ratio est différent de celui de l'iPhone, ce qui interdit une transposition directe. Les applications conçues pour l'iPhone sont donc exécutées en 320x480, avec possibilité d'appliquer un zoom x2 pour se rapprocher de la taille de l'écran.

Il y a là une grande fourberie de la part d'Apple. En mode "2x", les applications se trouvent donc à être affichées en 640x960, ce qui nous ramène très précisément au Retina précédemment évoqué. Problème résolu ? Absolument pas. *iOS ignore délibérément les ressources Retina à sa disposition*, condamnant l'utilisateur à un rendu aux pixels bien en évidence.

Je ne vois qu'une explication à ce choix. Une application conçue pour un écran d'iPhone n'exploitera jamais de manière satisfaisante l'espace offert par un écran d'iPad. Et pour inciter les développeurs à revoir la conception de leurs applications, mieux vaut ne pas trop embellir le portage à minima tel qu'il est proposé actuellement.

On l'aura donc compris : une application pour iPad nécessite un travail bien plus conséquent que pour une adaptation au Retina. Pour déterminer le type d'appareil au moment de l'exécution, la solution la plus robuste consiste à utiliser la macro proposée par le SDK :

``` objc
if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
  // Pour iPad
}
else {
  // Pour iPhone et iPod touch
}
```


Il existe toutefois une approche permettant de valoriser les ressources pour Retina sur un iPad. Vous pouvez en effet faire appel directement aux ressources suffixées par "@2x", et utiliser un positionnement relatif des éléments à l'écran en fonction de ses dimensions, permettant ainsi d'étirer l'application sur l'iPad, avec une résolution d'image normale, et sans avoir à ajouter de nouvelles ressources. Cette approche ne saurait se substituer à la conception d'une version spécifique à la tablette, mais elle peut s'avérer satisfaisante pour certains types de projets.


## Conclusion

Ce n'est certainement pas un hasard si le nombre de pixel de l'écran Retina correspond rigoureusement au double de celui de la génération précédente. C'est pour cette même raison qu'Apple ne souhaite pas agrandir l'écran pour un iPhone 5, pour cela que l'écran de l'iPad 2 est identique à celui du premier. La seule amélioration concevable serait celle d'un écran de 2048 par 1536 pixels, ni plus, ni moins. Pour l'année prochaine ?
