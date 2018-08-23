Title:     Nouvelle icône pour Air Grenoble 2  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      August 23, 2018  
Update:     
Keywords:  iOS, app, dev  
Summary:   L’icône a un rôle essentiel de représentation. Difficile de la changer trop souvent sans déstabiliser inutilement ceux qui ont l’habitude de la voir sur leur écran d’accueil. Mais une « v2 » est toujours une bonne opportunité pour rafraîchir et améliorer l’icône.  
Image:     https://www.vtourraine.net/blog/img/2018/air-grenoble-2-icone/icon-v2.png  
Language:  fr  


L’icône a un rôle essentiel de représentation. Difficile de la changer trop souvent sans déstabiliser inutilement ceux qui ont l’habitude de la voir sur leur écran d’accueil. Mais une « v2 » est toujours une bonne opportunité pour rafraîchir et améliorer l’icône.

## Icône v1

![Icône Air Grenoble, version 1](/blog/img/2018/air-grenoble-2-icone/icon-v1.png)

Pour Air Grenoble, il faut dire que l’icône d’origine était assez... minimaliste, pour ne pas dire médiocre.

Comment représenter le concept de « qualité de l’air » ? 

Je n’étais pas vraiment inspiré : j’avais réalisé un dégradé bleu pour illustrer le ciel, avec du vert en bas pour le sol, et une légère courbure pour évoquer la forme de la Terre et le concept d’atmosphère. Le résultat n’avait rien de remarquable, ce qui me paraissait être un moindre défaut. Plutôt que de rajouter des éléments inutiles, on avait donc cette icône très neutre, un peu vide.

## Made in Pixelmator

Je précise tout de suite que ces icônes sont entièrement créées avec [Pixelmator](https://itunes.apple.com/app/pixelmator/id407963104?mt=12) sur Mac. J’utilise exclusivement cette application pour tous les travaux graphiques de mes projets iOS : icônes, ressources graphiques, et screenshots pour l’App Store. En ce qui me concerne, Pixelmator offre tous les outils nécessaires, sans la complexité (ni le prix) d’un Photoshop.

## Nouveau ciel bleu

Pour cette nouvelle icône, je voulais commencer par améliorer le dégradé bleu. J’ai essayé différentes teintes, plus ou moins prononcées, sans aboutir à un résultat vraiment convainquant.

Lorsqu’on crée une icône, il me semble impératif de la tester dans son environnement naturel, c’est-à-dire comme une vraie application sur son écran d’accueil. Le rendu dans l’éditeur graphique peut être trompeur, et amener à une image visuellement plaisante, mais qui ne remplit pas son rôle d’icône.

Je place toujours Air Grenoble à côté de l’application système « Météo », ce qui me paraît un cas raisonnablement commun. Son icône représente un soleil avec un nuage sur un fond bleu, et je suis arrivé à la conclusion que le meilleur rendu pour Air Grenoble est de reprendre fidèlement ce dégradé, et ainsi donner une cohérence visuelle entre ces deux applications qui remplissent des fonctions très complémentaires. J’ai donc manipulé l’icône de « Météo », effacé le soleil et le nuage, et étendu le fond pour remplir le cadre de 1024 pixels.

J’ai aussi repris la partie verte en bas de l’icône originale, mais pour la rendre plus spécifique, je lui ai donné une allure de chaîne de montagne. Le paysage de Grenoble est en effet connu pour les montagnes qui l’entourent. Concrètement, il s’agit de formes vectorielles (Pixelmator permet de mélanger bitmap et vectoriel facilement) : d’abord trois triangles, dont j’ai arrondis les coins avec l’outil Smooth Path.

![Icônes Météo, Air Grenoble (background)](/blog/img/2018/air-grenoble-2-icone/icon-weather-background.png)

## Glyphe

Pour le meilleur et pour le pire, les icônes se résument bien souvent à un glyphe symbolisant l’application. Dans sa version d’origine, Air Grenoble n’en avait justement pas. Je voulais profiter de cette mise à jour majeure pour trouver un glyphe satisfaisant. 

J’ai cherché le terme « air » sur [The Noun Project](https://thenounproject.com/), une collection d’icônes participative, très complète et bien organisée. On y trouve globalement [deux suggestions](https://thenounproject.com/search/?q=air) : trois lignes formant des vagues, ou trois lignes recourbées d’un côté. La seconde option me paraît plus distinctive.

J’ai donc commencé par ajouter trois grosses lignes dans mon fichier Pixelmator, puis trois ronds pour les courbures. J’avais prévu de vider partiellement ces ronds pour recréer l’effet d’enroulement d’une ligne, mais je me suis rendu compte que les ronds pleins suffisaient à communiquer le concept, avec une simplicité graphique assez plaisante. Mieux, ces ronds évoquent également la forme des cabines du [téléphérique de Grenoble Bastille](https://fr.wikipedia.org/wiki/T%C3%A9l%C3%A9ph%C3%A9rique_de_Grenoble_Bastille), l’équivalent local de la silhouette de la Tour Eiffel pour Paris. Je suis probablement le seul à faire le rapprochement, mais ce détail m’amuse beaucoup.

Et voilà le résultat !

![Icône Air Grenoble, version 2](/blog/img/2018/air-grenoble-2-icone/icon-v2.png)

## Application Apple Watch

Pour l’application Apple Watch, j’ai préféré retirer la partie verte et les montagnes, et ainsi simplifier l’icône pour un rendu sur petit écran. 

![Icône Air Grenoble, version 2 pour Apple Watch](/blog/img/2018/air-grenoble-2-icone/icon-v2-watchos.png)

Je ne sais pas si c’est vraiment la bonne approche, car cette légère différence suffit à distinguer visuellement la version watchOS de la version iOS. C’est plus adapté, mais cela introduit aussi une légère dissonance qui me gêne un peu. Si ce doute persiste, je pourrais toujours rétablir l’icône complète sur Apple Watch.

## Icônes alternatives

Je n’aurais probablement pas le temps de préparer ça pour la mise à jour de septembre, mais j’aimerais beaucoup profiter de l’API introduite avec iOS 10.3 permettant de laisser l’utilisateur configurer l’icône de l’application avec plusieurs alternatives. La mise en place est un peu laborieuse, et il y a évidemment un travail graphique conséquent, mais j’aimerais proposer une version nuit, notamment, et peut-être essayer d’autres approches. Pour une mise à jour ultérieure, sans doute.
