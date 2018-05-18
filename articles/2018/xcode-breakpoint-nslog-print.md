Title:     Remplacer NSLog()/print avec des breakpoints  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      May 18, 2018  
Update:    
Keywords:  dev, Xcode  
Summary:   C’est bien connu, on adore débugger un problème avec NSLog() ou print. On sait bien qu’il existe des outils plus adaptés pour suivre le déroulement d’un programme, mais on préfère souvent ce bon vieux loggeur, facile à mettre en place, facile à maîtriser.  
Image:     https://www.vtourraine.net/blog/img/2018/xcode-breakpoint-nslog-print/xcode-breakpoint-log.png  
Language:  fr  


C’est bien connu, on adore débugger un problème avec `NSLog()` ou `print`. On sait bien qu’il existe des outils plus adaptés pour suivre le déroulement d’un programme, mais on préfère souvent ce bon vieux loggeur, facile à mettre en place, facile à maîtriser.

J’utilise `NSLog()` quotidiennement, parfois à très hautes doses. Je dois donc régulièrement me rappeler qu’il existe une alternative accessible, parfaitement intégrée à Xcode, qui présente de nombreux avantages : les breakpoints.

On peut faire beaucoup de choses avec les breakpoints, je ne pense pas avoir à expliquer leur intérêt en général. Mais on peut aussi les utiliser pour afficher des informations dans la console, remplaçant donc `NSLog()`/`print`.

1. Cliquer dans la marge à gauche du code pour ajouter un breakpoint classique
2. Double-clic sur la flèche bleue pour éditer le breakpoint
3. Cliquer sur « Add Action »
4. Saisir la commande de log LLDB (par exemple : `po value`)
5. Activer « Automatically continue after evaluating actions »

![Breakpoint Xcode](/blog/img/2018/xcode-breakpoint-nslog-print/xcode-breakpoint-log.png)

De cette façon, le breakpoint pourra générer le log souhaité, sans interrompre le déroulement du programme. Exactement ce qu’on attend d’un loggeur. 

C’est vrai, tout ceci est légèrement plus compliqué à mettre en place qu’une simple ligne de code de log. Mais dans la majorité des cas, les avantages dépassent les inconvénients. Il s’agit surtout de passer la barrière mentale du breakpoint.

Quels avantages, donc ?

- Pas besoin de recompiler et de relancer l’application : ces breakpoints sont éditables en temps-réel (ajout, suppression, modification)
- Possibilité de les activer/désactiver très facilement en cliquant sur la flèche bleue
- Ajout de conditions (dans le popover d’édition)
- Partage au niveau du projet/workspace Xcode (dans l’onglet « Breakpoint navigator »)
- Pas de risque de `NSLog()`/`print` qui traîne en production

Dans la pratique, je commence souvent une session de debug par un ou deux `NSLog()`, et si la solution ne m’apparaît pas rapidement, je remplace tout ça par des breakpoints pour passer aux choses sérieuses. 
