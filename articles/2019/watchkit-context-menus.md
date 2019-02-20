Title:     WatchKit : menus contextuels introuvables  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      February 20, 2019  
Update:    
Keywords:  dev, watchOS  
Summary:   Pour proposer davantage de fonctionnalités sur un écran si petit, WatchKit permet d’afficher des menus contextuels (« context menus » en VO). À n’importe quel moment, l’utilisateur peut appuyer fort sur l’Apple Watch pour faire apparaître des actions associées à l’écran actif.  
Image:     https://www.vtourraine.net/blog/img/2019/watchkit-context-menus/games-keeper-watch-solid.png  
Language:  fr  


Pour proposer davantage de fonctionnalités sur un écran si petit, WatchKit permet d’afficher des menus contextuels (« [context menus](https://developer.apple.com/library/archive/documentation/General/Conceptual/WatchKitProgrammingGuide/Menus.html) » en VO). À n’importe quel moment, l’utilisateur peut appuyer fort sur l’Apple Watch pour faire apparaître des actions associées à l’écran actif.

![watchOS : menu contextuel](/blog/img/2019/watchkit-context-menus/watchkit-context-menu.png)

Cette interaction existe depuis watchOS 1, et depuis le début, beaucoup ont critiqué son invisibilité. Rien à l’écran n’indique sa présence, par conséquence le menu est très largement inutilisé. La plupart des utilisateurs d’Apple Watch ignorent tout simplement son existence. Le plus embêtant, c’est que les fonctionnalités concernées sont parfois uniquement proposées dans ces menus. Il ne s’agit pas de raccourcis. Le menu est caché, donc la fonctionnalité est cachée, quasiment inexistante.

Je suis tombé dans ce piège récemment, avec la dernière version de [Games Keeper](http://www.studioamanga.com/gameskeeper/) pour Apple Watch. Auparavant, l’application ne pouvait gérer qu’un seul score (un seul joueur, donc). C’était évidemment très limitant, et certains utilisateurs m’ont réclamé de pouvoir suivre des parties à plusieurs joueurs sur l’Apple Watch. Bien bien. J’y travaille, et avec la nouvelle version, l’écran comporte maintenant plusieurs pages qui permettent de passer d’un joueur à l’autre (à gauche sur l’image ci-dessous, remarquez les points blancs en bas de l’écran). Sur une montre, ça ne laisse pas beaucoup de place pour d’autres boutons, c’est donc le menu contextuel qui permet de commencer une nouvelle partie.

![Games Keeper pour Apple Watch](/blog/img/2019/watchkit-context-menus/games-keeper-watch.png)

Je suis satisfait du résultat, je publie la mise à jour sur l’App Store. Quelques jours plus tard, je remarque le premier avis ajouté par un utilisateur concernant la nouvelle version :

> ★☆☆☆☆
> Apple Watch - Fix glitch as app is not working on Apple Watch as advertised. I purchased the $2.99 in app offer as well

Catastrophe ! Et l’achat in-app n’a rien à voir avec l’application Apple Watch. Je soupçonne que le problème vient du menu contextuel caché, je réponds donc à cet utilisateur pour le lui suggérer (merci Apple d’avoir ajouté cette possibilité en 2017). Un peu plus tard, l’utilisateur met à jour son avis :

> ★★★★★
> Works as advertised! To show options, press the Apple Watch screen down with enough pressure for options to pop up

Ouf... Le problème est réglé pour cet utilisateur, mais il me faudra vraisemblablement revoir l’interface pour rendre cette fonctionnalité plus accessible.

Quelle solution choisir ? On peut s’inspirer des applications développées par Apple. Dans l’application Exercice, on trouve un menu très similaire, notamment pour mettre en pause l’activité en cours, ou commencer un nouvel exercice. Ça ressemble comme deux gouttes d’eau à un menu contextuel, mais c’est en réalité un `WKInterfaceController` classique, inclus sous la forme d’une  page, accessible en glissant l’écran vers la gauche.

![Exercice pour Apple Watch](/blog/img/2019/watchkit-context-menus/watchos-workout-end-workout.jpg)

“Exercice” est probablement une des applications les plus utilisées sur Apple Watch, et Apple a eu plusieurs années pour valider cette interface. On peut donc raisonnablement retenir cette solution pour des situations similaires. 

Cette critique des menus contextuels n’est pas nouvelle. Beaucoup de choses ont changé depuis watchOS 1.0, mais bizarrement, les menus eux n’ont pas bougé. Je ne pense pas qu’il faille les retirer complètement. Mais peut-être que cette API devraient systématiquement faire apparaître les menus dans une page à gauche. Pour Games Keeper, ce sera vraisemblablement une meilleure approche.
