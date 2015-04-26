Title:     WatchKit, version 1  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      April 26, 2015  
Update:   
Keywords:  Apple Watch, WatchKit, dev
Summary:   Comment développer des applications sans jamais avoir utilisé l’OS concerné, ni même la classe de produit en question ? C’est le casse-tête posé par Apple aux développeurs tiers depuis quelques mois avec WatchKit, le SDK de l’Apple Watch. Le grand jour est arrivé, la montre est enfin disponible (pour les pré-commandes les plus rapides), et l’App Store Apple Watch contient environ 3000 apps. Ce nombre est comparable aux apps iPad pour le lancement de la tablette, alors que l’iPhone n’avait de 500 apps pour l’ouverture de l’App Store en 2008. Dernier chiffre pour mettre tout ça en perspective, on trouve environ 1,4 million d’apps iPhone aujourd’hui.  
Image:     http://www.vtourraine.net/blog/img/2015/watchkit-version-1/apple-watch-1.jpg  
Thumbnail: http://www.vtourraine.net/blog/img/2015/watchkit-version-1/thumbnail-apple-watch.jpg  
Language:  fr  


Comment développer des applications sans jamais avoir utilisé l’OS concerné, ni même la classe de produit en question ?

C’est le casse-tête posé par Apple aux développeurs tiers depuis quelques mois avec [WatchKit](http://developer.apple.com/watchkit/), le SDK de l’Apple Watch. Le grand jour est arrivé, la montre est enfin disponible (pour les pré-commandes les plus rapides), et l’App Store Apple Watch contient environ 3000 apps. Ce nombre est comparable aux apps iPad pour le lancement de la tablette, alors que l’iPhone n’avait de 500 apps pour l’ouverture de l’App Store en 2008. Dernier chiffre pour mettre tout ça en perspective, on trouve environ 1,4 million d’apps iPhone aujourd’hui.

![Apps WatchKit, image Apple][WatchKit apps]

Belle performance de WatchKit, donc. Le problème, c’est que tous les tests de l’Apple Watch s’accordent à dire que les apps tierces sont… nulles.

> « Third party apps on the Apple Watch. They suck. »  
> _John Gruber, [The Talk Show: Ep. 116](http://daringfireball.net/thetalkshow/2015/04/15/ep-116)_

Il se trouve que j’ai développé [une application](https://itunes.apple.com/app/laboratory-timer/id537195348?mt=8) WatchKit, et que je possède maintenant une Apple Watch. J’ai déjà plus d’une dizaine d’applications, parmi celles que j’utilise régulièrement sur mon téléphone, qui sont également disponibles sur la montre. Je trouve que le résultat est assez impressionnant. C’est relativement lent par moments, mais pas autant qu’on pouvait le redouter. Le plus gros problème est d’avoir les applications tierces qui cessent complètement de fonctionner dès que l’iPhone est hors de portée. Une grosse limitation (temporaire) mais des applications tout de même impressionnantes. Instagram au poignet, ça marche. Hélas, WatchKit manque de pertinence, comme hors-sujet.

Apple l’a répété jusqu’à plus soif : la montre est leur produit le plus personnel, _ever_. Sa première utilité : afficher l’heure. Ça fait sourire, mais je trouve ça la définition la plus pertinente qu’on puisse trouver. Tout le monde semble adorer la personnalisation des [cadrans](http://www.apple.com/fr/watch/timekeeping/). Il existe une poignée de configurations de base, avec la possibilité de modifier les complications (les petits bidules généralement situés dans les coins, affichant le prochain rendez-vous du calendrier, la température, etc.). C’est probablement l’aspect le plus intéressant de l’Apple Watch. Mais quel malheur d’avoir un choix aussi limité. J’aurais tellement préféré ne pas avoir d’apps tierces sur la montre, pour des cadrans tiers à la place. 

> «  ️Aucun cadran ne me convient parfaitement »  
> _Nicolas Furno, [iGen.fr](http://www.igen.fr/timeline/watch/nicolas/aucun-cadran-ne-me-convient-parfaitement)_

![Complications Apple Watch, image Wired/Apple][Watch Face 1]

Le sujet est largement abordé par John Gruber sur le dernier Talk Show. Il suppose qu’il s’agit probablement d’une volonté de Jony Ive de contrôler à 100% cette partie de l’interface qui constitue indéniablement le cœur de la montre. Le cadran doit rester magnifique. À partir de là, la concession la plus probable serait de laisser les développeurs tiers proposer des complications. Ça tombe bien, elles semblent déjà tourner comme des Extensions iOS 8.

> « Complications seem to be run as Extensions, remotely (out-of-process). Complications have crash recovery (which is hilarious) »  
> _Steve Troughton-Smith, [@stroughtonsmith](https://twitter.com/stroughtonsmith/status/591299567401984001)_

Il s’agit clairement d’une option envisageable pour une nouvelle version de WatchKit. Mais ce sera largement insuffisant pour combler cet énorme appétit pour des cadrans plus personnels. La batterie est un point sensible du développement matériel et logiciel de la montre. 

Les supposées appréhensions formelles de l’équipe de Jony Ive et les limitations de l’autonomie de cette première version de la montre devront toutes deux reculer pour laisser place à des cadrans personnalisés. À mon avis, c’est incontournable, et si Apple veut éviter les vieilles tendances aux jailbreak des utilisateurs d’iPhone, j’espère qu’ils avanceront rapidement. Les applications tierces peuvent attendre.

![Complications Apple Watch, image Wired/Apple][Watch Face 2]

_Images Wired/Apple : [iPhone Killer: The Secret History of the Apple Watch](http://www.wired.com/2015/04/the-apple-watch/)._

[WatchKit apps]: http://www.vtourraine.net/blog/img/2015/watchkit-version-1/watchkit-apps.jpg
[Watch Face 1]: http://www.vtourraine.net/blog/img/2015/watchkit-version-1/apple-watch-1.jpg
[Watch Face 2]: http://www.vtourraine.net/blog/img/2015/watchkit-version-1/apple-watch-2.jpg
[Watch Face 3]: http://www.vtourraine.net/blog/img/2015/watchkit-version-1/apple-watch-3.jpg

