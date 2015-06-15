# Impressions WWDC 2015

On peut dire que la WWDC est vraiment devenue « worldwide » depuis qu’Apple diffuse les vidéos des sessions pendant le courant de la semaine, allant cette année jusqu’à proposer plusieurs retransmissions en direct. Bref, San Francisco ou pas, tout le monde peut bénéficier de cette avalanche d’information. Nouvelles versions des OS, nouvelles API, il y a forcément beaucoup de choses à dire, je ne vais donc pas me priver d’y ajouter mon commentaire.


## « Multitasking » iPad

C’est le grand saut pour iOS : il sera possible d’utiliser deux apps en même temps. Cette nouveauté met fin au principe fondateur des applications toujours en plein écran. 

Je me réjouis de voir l’OS évoluer, mais j’ai des réserves sur le succès d’une telle transformation. D’un côté, parce qu’il faudra un iPad Air 2 pour en bénéficier, de l’autre parce que les développeurs devront faire des efforts supplémentaires pour supporter ces fonctionnalités. Dans un contexte où les ventes d’iPad ont une tendance à la baisse, et où beaucoup de développeurs peinent déjà à rentabiliser des applications iPhone, le défi est de taille. Et je ne pense pas que l’arrivée d’un iPad « Pro » puisse changer la donne. 

Quand je vois quelqu’un utiliser un iPad, c’est soit pour regarder une vidéo (plus fort que l’Apple TV), soit pour un jeu, et parfois pour internet/mail. Le potentiel de l’iPad est énorme, et j’ai hâte de voir ce que le multitâche peut apporter à une utilisation quotidienne, mais j’ai l’impression que son impact est surestimé. Il faut bien sûr améliorer le produit pour espérer en vendre plus, mais comme pour l’œuf et la poule, ça peut aussi finir en omelette (?!).


## Search API

C’est la nouveauté qui m’intéresse le plus. Enfin une API Spotlight sur iOS, pour rendre globalement accessible le contenu d’une app. 

Apple n’a pas fait les choses à moitié : on peut indexer à la fois du contenu et des « activités » (par exemple, une app de photos peut indexer les filtres qu’elle propose). En bonus, cette API s’appuie sur les mécanismes Handoff (`NSUserActivity`, la continuité des activités entre appareils, nouveauté iOS 8). Deux fonctionnalités avec le même code, c’est appréciable.

La recherche va plus loin. On peut déclarer un contenu globalement accessible, dans quel cas Apple pourra l’étendre aux personnes n’ayant pas installé l’application. On peut donc imaginer contourner l’App Store, encore une petite révolution. 

Apple chasse une fois encore sur les terres de Google. La promesse est ambitieuse, j’espère bien sûr que le résultat sera à la hauteur, à la fois en tant que développeur, et comme utilisateur. 


## NS/UIStackView

Une addition inattendue mais bienvenue : une nouvelle classe pour construire des interfaces. Il suffit de choisir entre horizontale et verticale, et d’empiler les vues, avec la possibilité de composer des stack views dans d’autres stack views. C’est d’ailleurs l’unique mode de disposition proposé par WatchKit, avec les `WKInterfaceGroup`. 

Je trouve que c’est un compromis vraiment intéressant entre flexibilité et simplicité, qui convient pour beaucoup d’interfaces. Auto Layout est un outil formidable, mais son API paraît trop souvent inutilement complexe. Ça nous a donné de nombreuses bibliothèques open source offrant différents niveaux d’abstraction. L’arrivée de `NS/UIStackView` devrait apporter un peu de cohérence à tout ça.


## Sélection et partage de texte

La modale de partage, a.k.a. `UIActivityViewController`, est devenue progressivement un élément d’interface incontournable. C’est l’écran qui apparaît quand vous appuyez sur un bouton de partage, par exemple dans Safari ou Photos.

Incontournable car il permet de transmettre des données directement d’une application à une autre. Jusqu’à présent, cette vue était malheureusement absente de la sélection de texte dans les apps système. Ça signifie qu’une app tierce pouvait proposer une Extension de partage acceptant une chaîne de caractère (par exemple une app de prise de notes pourrait permettre la création d’une nouvelle entrée à partir d’un passage sélectionné avec Safari), mais les principales applications concernées ne proposaient jamais cette option (Safari permet de partager l’adresse de la page, mais pas la sélection). 

Tout ça pour dire que la bonne nouvelle avec iOS 9, c’est l’arrivée de ce bouton « Partage… » dans Safari (et Mail ? et Notes ?). Une nouveauté qui semble anecdotique, mais qui peut significativement améliorer la fameuse expérience utilisateur. Très utile. Un bouton si puissant que Twitter, Facebook et Instagram en ont visiblement peur, et refusent pour l’instant de l’inclure dans leurs applications. On espère que ça va changer.


## Nouvelles Extensions

En parlant d’Extensions, après leur arrivée fracassante l’année dernière (_Today_, _Share_, _Action_, _Photo Editing_, _Custom Keyboard_, _Finder Sync_ et _Document Provider_), leur passage remarqué sur la montre (_WatchKit_), Apple ajoute discrètement de nouveaux types plus techniques. 

Assez surprenant, des Extensions pour filtrer les requêtes au réseau (_Packet Tunnel Provider_, _App Proxy Provider_, _Filter Data Provider_ et _Filter Control Provider_), qui font du bruit car elles ouvrent la porte à des AdBlock mobiles. _Shared Links_, une fonctionnalité de Safari pourtant bien discrète. _Spotlight_, pour indexer le contenu sans avoir à ouvrir l’application. Enfin _Audio Unit_, pour proposer des modules de traitement audio, comme on peut les trouver sur OS X depuis plusieurs années.

Des nouveautés variées et intéressantes, qui confirment l’importance des Extensions pour l’avenir d’iOS (et OS X).


## watchOS 2

Les complications sont arrivées. [J’attends](http://www.vtourraine.net/blog/2015/watchkit-version-1) toujours les cadrans tiers. Ceci dit, pour une première année, je reconnais qu’on a déjà de quoi bien s’amuser.


## Swift 2

Comme prévu, le langage surprise de l’année dernière continue à évoluer. Nouveauté importante : la gestion des erreurs. Fini le passage en argument, voici le `try {} catch {}`. Ça ressemble à des exceptions, mais il s’agit bien d’erreurs. Il faudra voir ce que ça donne à l’usage, mais je trouve l’approche intéressante.

Apple a surtout annoncé son intention de publier le code source de Swift d’ici la fin de l’année. Après le succès du repo [ResearchKit](https://github.com/ResearchKit/ResearchKit) sur GitHub, on peut raisonnablement espérer que Swift aura droit au même traitement de faveur. Encore une excellente nouvelle.


## Compte développeur unifié

Encore une distinction iOS/OS X qui tombe : les programmes développeurs ne font plus qu’un. Avec mon compte iOS, je peux maintenant publier des applications sur le Mac App Store. Il en faudra plus pour revigorer le développement OS X, mais cette évolution est appréciable.


## Vidéos des sessions

Enfin, et ça pourrait passer pour un détail insignifiant, mais tous les développeurs semblent d’accord pour saluer cette nouveauté symbolique : [les vidéos des sessions WWDC](https://developer.apple.com/videos/wwdc/2015/) ne se limitent plus aux slides et à la voix, elles comprennent maintenant des plans filmés des ingénieurs Apple qui les présentent. Un changement qui humanise (oui, oui, sortons les grands mots) ces sessions, par ailleurs toujours aussi riches en information.


## Bilan

Encore une WWDC très positive, avec son lot d’évolutions et de nouveautés. Apple garde le rythme habituel qui lui réussit, et que rien ne semble pouvoir perturber. En route donc pour iOS 9, OS X 10.11 _El Capitan_, et watchOS 2.
