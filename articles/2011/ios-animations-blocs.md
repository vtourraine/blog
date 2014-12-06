Title:    iOS : les animations  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     December 06, 2011  
Update:   
Keywords: iOS, OS X, UI, animation, blocs
Summary:  Comment créer une application attractive ? Vaste question, mais il me semble qu’il existe un critère, complètement objectif, vous permettant d’atteindre un certain niveau de finition : tous les éléments de l’interface doivent être animés. La bonne nouvelle, c’est qu’iOS le gère très facilement, comme nous allons le voir.
Image:    http://www.vtourraine.net/blog/img/ios-animations-blocs/core-animation.png
Language: fr

Comment créer une application attractive ? Vaste question, mais il me semble qu’il existe un critère, complètement objectif, vous permettant d’atteindre un certain niveau de finition : tous les éléments de l’interface doivent être animés. La bonne nouvelle, c’est qu’iOS le gère très facilement, comme nous allons le voir.

## Toujours, toujours animer

Sans aller jusqu'à ajouter des textures photo-réalistes partout, il faut que votre interface soit "physiquement" cohérente, presque tangible. 

Typiquement, un élément ne peut pas apparaître brutalement sur l'écran, comme par magie. Les controlleurs de navigation sur iOS (<em>cf</em> <a href="http://developer.apple.com/library/ios/#documentation/uikit/reference/UINavigationController_Class/Reference/Reference.html">UINavigationController</a>) se comportent de façon "naturelle" parce qu'ils animent automatiquement la venue d'un nouvel écran en chassant le précédent de la droite vers la gauche, et inversement lorsqu'on dépile la navigation. C'est le genre de détail qui change complètement l'expérience utilisateur. Il faut toujours veiller à présenter une nouvelle vue lorsqu'elle apparaît sur l'écran, si possible de manière cohérente avec le comportement associé (navigation dans le sens de lecture, panneau de réglage caché derrière la vue principale, etc).

<div class="slideshow">
	<img src="http://www.vtourraine.net/blog/img/ios-animations-blocs/navigation-interface.png" class="nostyle" alt="Navigation interface" />
</div>

De la même manière, lorsque vous modifiez un élément déjà visible à l'écran, vous devez assurer la transition visuelle entre les deux états. Si vous déplacez un bouton d'un point A vers un point B, vous devez absolument animer ce mouvement. Idem pour un redimensionnement, ou tout autre changement d'état. 

J'imagine que tout le monde est d'accord avec ces principes, alors pourquoi sont-ils si rarement respectés ?

## Juste un "bloc"

Pour un développeur iOS/Mac OS X, le déplacement d'une vue se traduira naturellement par :

``` objc
[maVue setCenter:CGPointMake(160, 160)];
```

C'est évidemment trivial. Il existe plusieurs moyens pour animer ce déplacement, mais vous pouvez retenir une solution toute aussi triviale : utiliser les "blocs". Si vous ne connaissez pas bien cette technologie, ne vous inquiétez pas, et regardez plutôt le résultat :

``` objc
[UIView animateWithDuration:0.3 animations:^{
  [maVue setCenter:CGPointMake(160, 160)];
}];
```

Et voilà, le tour est joué. Vous choisissez simplement la durée de votre animation, et vous ajustez votre interface à l'intérieur du bloc. Une simple ligne de code supplémentaire.

Dans certains cas, vous souhaiterez peut-être exécuter certaines actions une fois l'animation terminée. Prenons l'exemple d'un fade-out (une vue qui disparaît progressivement). Vous allez animer la valeur 'alpha' de "1", la valeur par défaut, jusqu'à "0", pour enfin retirer complètement la vue. 

``` objc
[UIView animateWithDuration:0.3 animations:^{
  [maVue setAlpha:0];
} completion:^(BOOL finished){
  [maVue removeFromSuperview];
}];
```

Et voilà le travail. Vous n'aurez aucun mal à intégrer cette technique à l'intérieur d'applications existantes, ou bien sûr pour vos futurs projets.

Vos utilisateurs appréciront sans doute la valeur ajoutée par ces animations. Il ne vous reste plus qu'à réfléchir aux transitions les plus appropriées pour chaque événement. Merci *Core Animation*.

<div class="slideshow">
	<img src="http://www.vtourraine.net/blog/img/ios-animations-blocs/core-animation.png" class="nostyle" alt="Core Animation logo" />
</div>

### Références

- [View Programming Guide for iOS: Animations](http://developer.apple.com/library/IOs/#documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/AnimatingViews/AnimatingViews.html)
- [Introduction to Core Animation Programming Guide](http://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/CoreAnimation_guide/Introduction/Introduction.html)
