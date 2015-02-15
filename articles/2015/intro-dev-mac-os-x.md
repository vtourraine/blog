Title:    Introduction au développement OS X (pour développeurs iOS, et pour les autres)  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     February 15, 2015  
Update:   
Keywords: dev, Cocoa, OS X  
Summary:  Coincé entre la déferlante iOS et la montée en puissance des web  apps, le développement OS X n’est pas franchement au centre des attentions. Il s’agit pourtant d’une plateforme toujours intéressante, pour plusieurs raisons.  
Image:    http://www.vtourraine.net/blog/img/2015/intro-dev-mac-os-x/start-dev-mac-apps.png  
Language: fr  

Coincé entre la déferlante iOS et la montée en puissance des web  apps, le développement OS X n’est pas franchement au centre des attentions. Il s’agit pourtant d’une plateforme toujours intéressante, pour plusieurs raisons.

Le Mac n’a jamais été aussi populaire. Dans certains contextes, il est même devenu omniprésent (ce qui se constate facilement à la plupart des conférences tech, par exemple). Par ailleurs, les studios éditant des applications à la fois pour OS X et pour iOS constatent que si les volumes sont évidemment plus faibles sur desktop, les revenus, eux, sont parfois comparables, sinon supérieurs. Les technologies autour d’HTML 5 ont certainement fait progresser les possibilités offertes par des web apps de façon significative, mais le natif garde globalement une longueur d’avance.

![« Start Developing Mac Apps Today », illustration Apple][Start dev Mac apps]

## Back to the Mac

Le Mac a aussi l’avantage de partager ses langages de programmation et une partie de son SDK avec iOS. Compte-tenu du dynamisme de la communauté des développeurs iPhone et iPad, c’est un atout de poids. 

J’ai commencé à développer [des](https://itunes.apple.com/app/papership/id686459498?mt=12) [applications](https://itunes.apple.com/app/hivebench-lab-notebook/id959923353?mt=12) OS X pour Shazino il y a environ deux ans. La transition depuis iOS n’est pas complètement évidente, notamment à cause du manque relatif de documentation (ou de documentation *actualisée*) sur le sujet, mais je trouve une certaine satisfaction à jongler entre mes habitudes de développement et les divergences de cette plateforme alternative.


## Même Foundation, différent Cocoa

Il n’y avait aucune raison de ré-inventer quelque chose qui fonctionnait bien, iOS a donc conservé intact le framework `Foundation`, qui rassemble les éléments de base des deux plateformes. On retrouve donc les `NSString` et les `NSArray`, mais aussi les `NSError`, les `NSFormatter`, les `NSPredicate`, et bien d’autres. En se basant sur ces classes, vous pouvez donc très simplement partager du code entre iOS et OS X.

Les choses sont différentes quand on s’approche des vues. À la place de Cocoa Touch, nous avons Cocoa premier du nom, qui partage globalement la même philosophie, mais qui comporte un certain nombre de divergences, parfois importantes.

Les `NSView`, par exemple, ne fonctionnent pas indépendamment comme leurs cousines `UIView`. Sur le Mac, elles ont besoin d’une `NSCell`, qui prend en charge une partie du travail pour le contexte graphique. Cette différenciation paraît bien superflue lorsqu’on est habitué au développement iOS, mais elle s’explique notamment par un soucis de réutilisation des objets à manipuler, établie à une époque où on ne disposait pas de Giga-octets de mémoire.

> « The `NSCell` class provides a mechanism for displaying text or images in an `NSView` object without the overhead of a full `NSView` subclass. It’s used heavily by most of the `NSControl` classes to implement their internal workings. »  
> — Apple, [_NSCell Class Reference_](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSCell_Class/)

On retrouve un peu partout cette fausse familiarité. Il convient donc de porter une attention particulière aux documentations pour se ré-approprier des concepts parfois élémentaires. Pas de `NSLabel`, par exemple, il faudra utiliser un `NSTextField` non-éditable à la place.


## MainMenu.xib

Pour une application iOS, il existe raisonnablement trois façons d’initier un projet : soit avec un Storyboard, soit avec des view controllers adossés à des `XIB`, soit uniquement en code source.

Pour OS X, `MainMenu.xib` est pratiquement incontournable. Ce n’est [peut-être pas une approche idéale](https://www.mikeash.com/pyblog/friday-qa-2013-04-05-windows-and-window-controllers.html), mais c’est sans doute la plus pragmatique pour commencer.

Il s’agit d’un fichier créé automatiquement par Xcode pour un nouveau projet. Il contient notamment la fenêtre principale de votre application, mais aussi le menu (« File », « Edit », …), et des références vers des objets de haut niveau comme l’app delegate ou le user defaults standard.

C’est donc un fichier absolument central, un peu effrayant — spécialement si vous n’êtes pas amateur d’Interface Builder — mais très pratique.


## NSWindowController vs. NSViewController

Pour iOS, on part globalement du principe qu’un écran correspond à un `UIViewController`. Pour le Mac, c’est plus compliqué, car il existe à la fois des `NSViewController` et des `NSWindowController`. Le choix n’est pas toujours évident. 

> « An NSWindowController object manages a window, usually a window stored in a nib file. »  
> — Apple, [_NSWindowController Class Reference_](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSWindowController_Class/)  
>  
> « A view controller manages a view, typically loaded from a nib file. »  
> — Apple, [_NSViewController Class Reference_](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/NSViewController_Class/)

Pour les fenêtres, c’est encore assez simple, chacune peut avoir son `NSWindowController`, à l’exception notable de la fenêtre principale, souvent gérée directement au niveau de l’app delegate. 

Pour les `NSViewController`, c’est plus difficile à généraliser.  Ce qui est intéressant, c’est que la classe comporte une propriété `representedObject` (de type `id`/`AnyObject`), sans équivalent pour iOS. Il convient alors d’identifier l’objet qui est représenté par la hiérarchie de vues associées. Cette approche peut aider à concevoir les différents blocs constituant une fenêtre, en fonction des objets concernés.


## Cocoa Bindings

À mes yeux, il existe une API qui caractérise vraiment le développement Mac : les mystérieux « Cocoa Bindings ». 

Concrètement, il peut s’agir par exemple de brancher un text field à une propriété `NSString` d’un view controller, pour laisser le système gérer automatiquement la mise à jour des valeurs, dans les deux sens. Tout aussi simplement, on peut demander à une table view de se remplir à partir d’un `NSArray`, en connectant la ligne sélectionnée avec une représentation détaillée sur une vue secondaire.

C’est un peu vague, expliqué comme ça, mais il s’agit bien de relier le modèle aux vues, en passant par les contrôleurs, sans avoir besoin de saisir une ligne de code, y compris pour des applications complexes.

> « Cocoa bindings is ideal for developers writing new applications who have some familiarity with Cocoa, and for developers of existing applications who want to simply clean up or eliminate their existing glue code. In most cases, Cocoa bindings can be used to replace traditional Cocoa mechanisms such as target-action, delegation, and some data source protocols. »  
> — Apple, [_Cocoa Bindings Programming Topics_](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CocoaBindings/CocoaBindings.html)

Comment ça marche ? Les Bindings reposent sur le « Key-Value Coding », c’est-à-dire la capacité d’Objective-C à observer un objet pour informer l’application de toute modification de sa valeur. Les Cocoa Bindings sont formidables parce qu’ils prennent en charge tous les détails d’implémentation du KVC, pour en proposer une interface de programmation simple et pratique. 

Cela veut aussi dire que cette technologie pourrait très bien exister sur iOS, puisque le KVC y est disponible. Difficile d’expliquer de façon catégorique les raisons de cette absence. Pour les premiers iPhones, les performances étaient une préoccupation majeure, et peuvent poser problème avec des Cocoa Bindings appliqués à une grande quantité d’objets. C’est peut-être également un choix de la part d’Apple pour limiter les approches pour la conception d’applications, dans un soucis de simplification et d’efficacité.

Ça n’empêche pas la communauté des développeurs Objective-C de proposer leur propre solution. [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) est un projet Open Source qui propose une solution comparable, là aussi à base de KVC.


## Conclusion

Tout ceci ne représente bien-sûr qu’une brève introduction. Je vous laisse imaginer les possibilités infinies offertes par la gestion du drag-and-drop, le multi-fenêtrage, et bien d’autres fonctionnalités exclusives au développement pour ces bons vieux ordinateurs. Ce ne sera peut-être pas toujours le cas. Apple se dit pour l’instant déterminé à garder ses deux OS distincts, en travaillant plutôt sur leur interopérabilité (_a.k.a._ « Continuity »). Pour l’instant, donc, le développement Mac garde tout son intérêt, et présente même des défis techniques intéressants. 

Si vous êtes intéressés par une présentation plus approfondie de la plateforme, n’hésitez-pas à me faire signe, il reste encore bien des billets de blog à écrire sur le sujet.


[Start dev Mac apps]: http://www.vtourraine.net/blog/img/2015/intro-dev-mac-os-x/start-dev-mac-apps.png  
