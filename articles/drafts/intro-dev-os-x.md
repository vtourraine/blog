# Introduction au développement OS X (pour développeurs iOS, et les autres)

Coincé entre la déferlante iOS et la montée en puissance des web  apps, le développement OS X n’est pas franchement au centre des attentions. Il s’agit pourtant d’une plateforme toujours intéressante, pour plusieurs raisons.

Le Mac n’a jamais été aussi populaire. Dans certains contextes, il est même devenu majoritaire (ce qui se constate facilement à la plupart des conférences tech, par exemple). Les studios éditant des applications pour OS X et iOS constatent que si les volumes sont généralement plus faibles sur desktop, les revenus, eux, sont comparables, sinon supérieur. Les technologies autour d’HTML 5 ont certainement fait progresser les web apps significativement, mais le natif garde globalement une longueur d’avance.


## Back to the Mac

Le Mac a aussi l’avantage de partager ses langages de programmation et une partie de son SDK avec iOS. Compte-tenu du dynamisme de la communauté des développeurs iPhone et iPad, c’est un atout de poids. 

J’ai commencé à développer des applications OS X pour Shazino il y a deux ans. La transition depuis iOS n’est pas complètement évidente, notamment à cause du manque relatif de documentation (ou de documentation *actualisée*) sur le sujet, mais je trouve une certaine satisfaction à jongler entre mes habitudes de développement et les divergences de cette plateforme alternative.


## Même Foundation, différent Cocoa

Il n’y avait aucune raison de ré-inventer quelque chose qui fonctionnait bien, iOS a donc conservé intact le framework `Foundation`, qui rassemble les éléments de base des deux plateformes. On retrouve donc les `NSString`, les `NSArray`, les `NSDictionary`, mais aussi les `NSError`, les `NSFormatter`, les `NSPredicate`, et bien d’autres. En se basant sur ces classes, vous pouvez donc sans problème partager du code entre iOS et OS X.

Les choses sont différentes quand on s’approche des vues. À la place de Cocoa Touch, on a donc Cocoa premier du nom, qui partage globalement la même philosophie, mais qui comporte un certain nombre de divergences, parfois importantes.

Les `NSView`, par exemple, ne fonctionnent pas indépendamment comme leurs cousines `UIView`. Sur le Mac, elles ont besoin d’une `NSCell`, qui prend en charge une partie du travail avec le contexte graphique. Cette différenciation paraît bien superflue lorsqu’on est habitué au développement iOS, mais elle s’explique notamment par un soucis de réutilisabilité des objets en mémoire, établie à une époque où on ne disposait pas de Giga-octets de mémoire.

> « The `NSCell` class provides a mechanism for displaying text or images in an `NSView` object without the overhead of a full `NSView` subclass. It’s used heavily by most of the `NSControl` classes to implement their internal workings. »  
> — Apple, [NSCell Class Reference](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSCell_Class/)

On retrouve un peu partout cette fausse familiarité. Il convient donc de porter une attention particulière aux documentations pour se ré-approprier des concepts parfois élémentaires. Pas de `NSLabel`, par exemple, il faudra donc utiliser un `NSTextField` non éditable à la place.


## MainMenu.xib

Pour une application iOS, il existe raisonnablement trois façons d’initier un projet : soit avec un Storyboard, soit avec des view controllers adossés à des `XIB`, soit uniquement en code source.

Pour OS X, `MainMenu.xib` est roi.

C’est un fichier créé automatiquement par Xcode pour un nouveau projet. Il contient notamment la fenêtre principale de votre application, mais aussi le menu (« File », « Edit », …), et des références vers des objets de haut niveau comme l’app delegate ou les user defaults standard.

Il s’agit donc d’un fichier absolument central, un peu effrayant — spécialement si vous n’êtes pas amateur d’Interface Builder — mais très pratique.


## NSWindowController vs. NSViewController
