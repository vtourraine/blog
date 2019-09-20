Title:     Air Grenoble pour iOS 13  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      September 20, 2019  
Update:    
Keywords:  iOS, app, dev  
Summary:   Air Grenoble souffle sa deuxième bougie avec la sortie d’une version 2.3 accompagnant iOS 13. Voici le tour des nouveautés.  
Image:     https://www.vtourraine.net/blog/img/2019/air-grenoble-ios-13/air-grenoble-info.png  
Language:  fr  


[Air Grenoble](https://itunes.apple.com/app/air-grenoble/id1183533416?mt=8) souffle sa deuxième bougie avec la sortie d’une version 2.3 accompagnant iOS 13. Voici le tour des nouveautés.

## Mode sombre

Le mode sombre est annoncé comme *la* nouveauté incontournable d’iOS 13. Bonne nouvelle pour Air Grenoble : l’application dispose depuis quelques mois déjà d’un [mode nuit](https://www.vtourraine.net/blog/2019/air-grenoble-mode-nuit), qui affiche automatiquement une interface plus sombre en fonction de l’heure. Même si elle n’utilise pas les couleurs sémantiques officielles d’iOS 13 (`systemBackgroundColor`, etc), cette apparence alternative convient parfaitement.

Il me suffit donc d’adapter très légèrement la fonction qui détermine l’apparence courante, pour utiliser la version sombre si le mode sombre est activé (pour iOS 13), ou bien s’il s’agit d’une heure de la nuit (comme précédemment). Difficile de faire plus simple.

Pour différencier le mode nuit du mode sombre, il faut regarder l’écran Informations. Il s’agit d’un simple `UITableViewController`. En mode sombre, l’affichage s’adapte donc automatiquement avec un texte clair sur fond sombre. En bonus, j’ai également adapté l’icône de l’en-tête, en spécifiant une image alternative dans l’asset catalog.

![Air Grenoble, écran Informations](/blog/img/2019/air-grenoble-ios-13/air-grenoble-info.png)


## SF Symbols

J’utilise [Glyphish](http://www.glyphish.com) pour inclure des icônes dans mes applications depuis des années. Il existe plusieurs collections similaires, qui reprennent le style des icônes d’Apple, proposant ainsi des illustrations prêtes-à-l’emploi et visuellement cohérentes. Avec SF Symbols, Apple propose (enfin ?) une solution officielle. Ce n’est pas parfait, avec un catalogue forcément limité, et une approche vectorielle qui ajoute un aliasing là où les icônes précédentes étaient conçues en bitmap, au pixel près. Pour ce prix-là, on bénéficie d’icônes standardisées (avec le système et entre applications), adaptatives (en taille et en épaisseur de trait), qui évolueront avec les futurs versions d’iOS, et un bundle plus léger. Une vraie bonne nouvelle, je trouve.  

![SF Symbols](/blog/img/2019/air-grenoble-ios-13/air-grenoble-sf-symbols.png)


## Application Apple Watch indépendante

L’adoption d’une nouvelle fonctionnalité n’aura jamais été aussi rapide. watchOS 6 autorise la création d’applications indépendantes, installables directement depuis la montre avec un App Store dédié. Pas besoin de toucher au code. Il suffit simplement de cocher une case dans la configuration du projet. Voilà.

![Configuration Extension watchOS](/blog/img/2019/air-grenoble-ios-13/watchos-independent.png)

Évidemment, le fonctionnement de l’application doit permettre ce type d’utilisation. Si elle attend des données en provenance de l’iPhone, cette nouveauté n’aura pas beaucoup de sens (et sera potentiellement rejetée par l’équipe de validation de l’App Store). Heureusement, l’application Air Grenoble pour Apple Watch obtenait déjà ses données indépendamment de l’iPhone. J’ai donc coché la case en question et confirmé le résultat avec le Simulateur watchOS 6. Bingo. 

## Siri Shortcuts Output

Air Grenoble inclut également un Siri Shortcut, c’est-à-dire une Extension permettant de demander la qualité de l’air avec Siri, sans passer par l’application principale. Ces shortcuts peuvent être automatisés avec l’application du même nom, mais iOS 12 ne permettait pas de passer des informations de l’un à l’autre. Ou plutôt, la seule solution consistait à [utiliser le presse-papiers comme une variable globale](https://www.vtourraine.net/blog/2018/air-grenoble-2-shortcuts-pasteboard). Apple a pris conscience de cette limitation, et offre une vraie solution avec iOS 13 : les Siri Shortcuts Outputs.

En théorie, il suffit de configurer une des propriétés de la réponse déjà définies dans le fichier `.intentdefinition`. Dans la pratique, je n’ai jamais réussi à obtenir le résultat voulu avec les betas successives d’iOS 13, et je ne sais pas d’où vient le problème. Le débuggage des Extensions Siri est toujours compliqué, la documentation officielle est assez vague, et Stack Overflow ne semble pas s’émouvoir du sujet. Comme il ne s’agit pas d’une fonctionnalité centrale, je préfère laisser ça de côté pour l’instant, mais j’espère bien pouvoir résoudre ce problème prochainement.

![Intent definition pour Extension Siri](/blog/img/2019/air-grenoble-ios-13/intentdefinition-response-output.png)

Au final, une petite déception, mais surtout plusieurs améliorations appréciables, avec un minimum d’efforts de ma part. Une mise à jour comme je les aime.
