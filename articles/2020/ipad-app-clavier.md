Title:     Explorer une application iPad au clavier  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      February 21, 2020  
Update:    
Keywords:  dev, iOS  
Summary:   Les nouveautés du SDK iOS 13.4 ont ravivé mon intérêt pour la prise en charge du clavier.  
Image:     https://www.vtourraine.net/blog/img/2020/ipad-app-clavier/nano-notes-keyboard.jpg  
Language:  fr  


Les [nouveautés du SDK iOS 13.4](https://developer.apple.com/documentation/ios_ipados_release_notes/ios_ipados_13_4_beta_release_notes/) ont ravivé mon intérêt pour la prise en charge du clavier. 

Apple propose depuis plusieurs années une solution pour ajouter des raccourcis clavier à une application iPad avec `UIKeyCommand`. Une API intéressante, certes, mais hélas trop limitée. Pour ne prendre qu’un exemple, il est impossible de naviguer dans une `UITableView` au clavier. Il existe bien des [solutions alternatives](https://github.com/douglashill/KeyboardKit), et iOS lui-même a fait quelques progrès en la matière (on peut notamment utiliser la recherche Spotlight avec le clavier), mais il faudra davantage d’améliorations pour prétendre à une réelle prise en charge de cet accessoire pourtant fondamental.

J’ai donc ouvert mes applications avec un iPad équipé d’un clavier, pour voir ce qu’il était possible de faire sans toucher l’écran. Il y a bien quelques raccourcis, mais les applications sont globalement inutilisables sans le toucher.

Ce constat m’a inspiré un défi : **est-il possible d’exposer l’intégralité des fonctionnalités d’une application iPad au clavier ?**

(Cette question peut faire sourire si vous travaillez sur votre ordinateur uniquement avec la ligne de commande/Emacs/Vim/etc, mais le problème n’en est pas moins important.)

Je me suis d’abord concentré sur mon application la plus simple : [Nano Notes](https://www.studioamanga.com/nanonotes/). Une split view, avec une liste sur la gauche, et un champs de texte sur la droite.

![Nano Notes sur iPad avec clavier](/blog/img/2020/ipad-app-clavier/nano-notes-keyboard.jpg)

Rien de vraiment compliqué, mais la quantité de code à ajouter peut vite accroître avec le nombre de fonctionnalités couvertes,  surtout quand il faut adapter les raccourcis au contexte d’exécution, selon l’état de l’application.

Le résultat, [aujourd’hui disponible sur l’App Store](https://itunes.apple.com/app/id1445942906?mt=8), est assez satisfaisant. Il manque encore la prise en charge du mode édition de la table view afin de pouvoir supprimer une note, et l’utilisation du menu d’export (deux fonctionnalités pourtant directement fournies par UIKit). Mais les fonctionnalités principales sont maintenant entièrement accessibles au clavier : consultation, création et édition des notes. Je considère ça comme une réussite.

![Raccourcis clavier pour Nano Notes](/blog/img/2020/ipad-app-clavier/nano-notes-keyboard-shortcuts.png)

À l’heure actuelle, on peut donc choisir de se retrousser les manches pour ajouter le support du clavier à une application iPad, ou attendre et espérer qu’iOS 14 apporte enfin une prise en charge automatique complète.
