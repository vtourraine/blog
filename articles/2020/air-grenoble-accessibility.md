Title:     Accessibilité pour Air Grenoble  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 15, 2020  
Update:    
Keywords:  dev, iOS  
Summary:   Je sais bien que l’accessibilité est un sujet important, mais pour être honnête, j’y pense plutôt a posteriori, quand je suis à court d’idées pour de nouvelles fonctionnalités. Heureusement qu’il existe des initiatives comme la Journée Mondiale de Sensibilisation à l’Accessibilité pour me secouer un peu.  
Image:     https://www.vtourraine.net/blog/img/2020/air-grenoble-accessibility/air-grenoble-accessibility-2.jpg  
Language:  fr  


Je sais bien que l’accessibilité est un sujet important, mais pour être honnête, j’y pense plutôt a posteriori, quand je suis à court d’idées pour de nouvelles fonctionnalités. Heureusement qu’il existe des initiatives comme la [Journée Mondiale de Sensibilisation à l’Accessibilité](https://en.wikipedia.org/wiki/Global_Accessibility_Awareness_Day) pour me secouer un peu. Et encore une fois, [Air Grenoble](https://itunes.apple.com/app/air-grenoble/id1183533416?mt=8&at=1000lMiD) est le projet parfait pour mettre en pratique ces bonnes pratiques.

Tout d’abord, évaluer le degré d’accessibilité de l’application. Voilà comment je m’y prends :

- Test des options du panneau Environment Overrides dans Xcode
- Exploration de l’application avec l’Accessibility Inspector et audit pour chaque écran 
- Activation de Voice Control pour explorer l’application uniquement avec la voix (la commande « show names » étant particulièrement utile)

*Note pour moi-même : il serait intéressant d’écrire un article pour détailler chacune de ces étapes. Peut-être une prochaine fois.*

Pour Air Grenoble, la navigation est tellement basique que VoiceOver et Voice Control sont déjà bien gérés. L’application supporte déjà Dynamic Type. Les problèmes restant concernent les autres options d’affichage. Augmentation du contraste, diminution des mouvements et de la transparence : rien de tout ça n’est pris en charge par l’écran principal, puisqu’il s’agit d’une vue non standard.

Il suffit pourtant de quelques modifications pour remédier à cette situation.

Pour le contraste, j’ai ajouté une variante « high contrast » à la couleur de fond dans l’asset catalog. UIKit se charge de l’appliquer automatiquement. Pour le mouvement, j’écoute la notification `reduceMotionStatusDidChange`, et je cache les nuages en conséquence. Pour la transparence, j’écoute la notification `reduceTransparencyStatusDidChange` et je modifie l’alpha des nuages. Je n’oublie pas de vérifier aussi la valeur de ces paramètres au lancement, pour éventuellement adapter l’interface si une option est déjà active.

Résultat : l’application est maintenant hautement personnalisable, sans avoir à ajouter le moindre réglage supplémentaire.

![Air Grenoble - affichage normal, texte plus grand, texte gras](/blog/img/2020/air-grenoble-accessibility/air-grenoble-accessibility-1.jpg)

![Air Grenoble - contraste augmenté, diminution de la transparence, diminution des mouvements](/blog/img/2020/air-grenoble-accessibility/air-grenoble-accessibility-2.jpg)
