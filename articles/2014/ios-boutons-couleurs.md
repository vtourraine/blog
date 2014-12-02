Title:    iOS : des boutons et des couleurs  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     November 23, 2014  
Update:   
Keywords: iOS, UI, UIKit, WatchKit  
Summary:  Une bonne année est passée depuis le grand chamboulement nommé iOS 7. Il m’aura bien fallu plusieurs mois avant d’appréhender confortablement ce nouveau langage visuel, et adapter mes applications. Cette année avec iOS&nbsp;8 c’est le retour au calme, avec une mise-à-jour en douceur de l’interface. Seulement voilà, l’Apple Watch pointe à l’horizon, et les grands débats reprennent. Un point me chagrine en particulier : les boutons et leurs couleurs.  
Image:    http://www.vtourraine.net/blog/img/ios-boutons-couleurs/watchkit-buttons.png  
Language: fr  
Project:    

Une bonne année est passée depuis le grand chamboulement nommé iOS 7. Il m’aura bien fallu plusieurs mois avant d’appréhender confortablement ce nouveau langage visuel, et adapter mes applications. Cette année avec iOS&nbsp;8 c’est le retour au calme, avec une mise-à-jour en douceur de l’interface. Seulement voilà, l’Apple Watch pointe à l’horizon, et les grands débats reprennent. Un point me chagrine en particulier : les boutons et leurs couleurs.


## Des boutons sans cadre (mais en couleurs)

Pour la conception d’interfaces, lorsqu’on imagine un bouton, on pense généralement à un texte et/ou un symbole encadré. Les variations sont infinies, mais la base reste la même. 

Avec iOS&nbsp;7, les boutons ont perdu leur cadre. `UIButton`, `UIBarButtonItem` (les boutons des toolbars et navigation bars), même résultat. Sur [l’échelle de Mrgan][Mrgan], c’est un 2 sur 12. Autant dire que ce choix n’a pas fait l’unanimité. 

![iOS Calendar, Apple iOS HIG][iOS Calendar] 

![iOS Maps, Apple iOS HIG][iOS Maps]

Bien sûr, rien n’interdit de reconstruire des boutons avec des bords, et Apple ne s’en prive pas. Néanmoins, il s’agit clairement du style par défaut, la référence, alors que les `UIButton` et les `UIBarButtonItem` venaient avec un bord jusqu’à iOS 6.

Pour résumer, le bouton n’a plus besoin de cadre, sa couleur doit suffire à l’identifier, et inviter l’utilisateur à interagir avec. Il s’agit d’éloigner la représentation numérique de son équivalent physique. 


## Arrivée de WatchKit

Cette semaine, Apple a publié la première version de WatchKit, le SDK pour l’Apple Watch à venir. On y trouve cette directive :

> **Avoid using color to show interactivity.** Apply color as appropriate for your branding but do not use color solely to indicate interactivity for buttons and other controls. — [Apple Watch Human Interface Guidelines][WatchHIG]

On remarque aussi que les boutons viennent par défaut avec un fond plein et des coins arrondis. Apple a même pris la peine de trouver un nom pour ce trait d’interface : le « plate » (l’assiette) du bouton.

![Apple, Apple Watch Human Interface Guidelines][WatchKit]

On se trouve donc en opposition directe avec le langage visuel d’iOS&nbsp;7/8, sur un point par ailleurs crucial. D’où ma question : pourquoi&nbsp;?


## La multiplicité des OS

Il ne faut pas croire que les différents OS d’Apple doivent forcément partager les mêmes interfaces. Il y a peu de choses en commun entre les interactions clavier/souris d’un iMac&nbsp;27” et l’écran tactile d’une Apple&nbsp;Watch. Les réactions à Windows&nbsp;8 montrent bien comment une interface qui se veut trop universelle finit par ne satisfaire personne. 

Il ne s’agit pas non plus de critiquer les choix d’iOS 7, il s’agit de les mettre en perspective avec ceux de l’Apple Watch pour essayer d’en comprendre les divergences. Ce qui m’interpelle avec ces directives concernant les boutons, c’est qu’elles me semblent à rebours des principes invoqués par Apple pour chaque plateforme. 

La montre doit _« faire tomber les barrières entre le matériel et le logiciel »_ (_« Apple Watch was designed to blur the boundaries between physical object and software. »_), pourquoi alors conserver les cadres comme artefacts d’une telle représentation ? Alors que l’écran d’une montre est particulièrement contraint en taille, les iPhones deviennent de plus en plus grands, et n’ont pas le même soucis d’économie des tracés.


## Toujours en mouvement est l’avenir (des interfaces)

Tout ça est un peu perturbant. Les directives et les styles par défaut proposés par Apple existent pour définir un socle commun sur lequel les développeurs peuvent s’appuyer pour s’assurer que les utilisateurs sauront s’approprier facilement n’importe quel logiciel. On retrouve les mêmes allers-retours pour la conception des sites web, avec les nombreuses évolutions du classique lien bleu souligné.

J’attends maintenant avec impatience la prochaine WWDC, pour voir comment le couple OS&nbsp;X/iOS s’accommodera du nouveau membre de la famille.



[iOS Calendar]: http://www.vtourraine.net/blog/img/ios-boutons-couleurs/ios-calendar.png  
[iOS Maps]: http://www.vtourraine.net/blog/img/ios-boutons-couleurs/ios-maps.png  
[WatchKit]: http://www.vtourraine.net/blog/img/ios-boutons-couleurs/watchkit-buttons.png  

[Mrgan]: http://mrgan.tumblr.com/post/50108095253/let-a-button-be-a-button  
[WatchHIG]: https://developer.apple.com/library/prerelease/ios/documentation/UserExperience/Conceptual/WatchHumanInterfaceGuidelines/ColorandTypography.html#//apple_ref/doc/uid/TP40014992-CH9-SW1