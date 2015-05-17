Title:     Rappels pour Apple Watch  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      May 17, 2015  
Update:   
Keywords:  Apple Watch, WatchKit, dev
Summary:   Parmi les premières apps Apple Watch disponibles, on trouve de nombreux gestionnaires de rappels. Clear, Wunderlist, Things, tous ont répondu à l’appel de WatchKit. Tous ? Non ! Une application fait clairement défaut : Reminders, a.k.a. Rappels, l’application d’Apple. Vous pouvez demander à Siri de créer un nouveau rappel depuis votre montre, mais vous ne pouvez pas les consulter.  
Image:     http://www.vtourraine.net/blog/img/2015/1list-rappels-apple-watch/1list-apple-watch.png  
Language:  fr  

Parmi les premières apps Apple Watch disponibles, on trouve de nombreux gestionnaires de rappels. Clear, Wunderlist, Things, tous ont répondu à l’appel de WatchKit. 

Tous ? Non ! Une application fait clairement défaut : Reminders, _a.k.a._ Rappels, l’application d’Apple. Vous pouvez demander à Siri de créer un nouveau rappel depuis votre montre, mais vous ne pouvez pas les consulter.


## Encore une application de rappels

Il se trouve que je développe depuis 2012 [une application iPhone/iPad](http://www.studioamanga.com/onelist/) qui permet justement de gérer ses rappels iOS (je sais, ce n’est pas très original). Le SDK iOS propose en effet une API complète pour y accéder, modifier les données existantes, et même créer de nouvelles entrées (cf. `EKReminder`, [documentation](https://developer.apple.com/library/prerelease/ios/documentation/EventKit/Reference/EKReminderClassRef/index.html)). 

« 1List », comme son nom l’indique, se concentre sur une liste à la fois. On peut en sélectionner une autre quand on le souhaite, mais cette application est vraiment conçue pour utiliser principalement une seule liste. Typiquement, il s’agit de la liste des courses. Je n’ai aucun chiffre, mais je suppose que c’est une situation assez courante. L’autre avantage de 1List est de proposer des suggestions basées sur l’historique des rappels déjà saisis, qui s’auto-complètent comme pour une recherche Google. Puisque j’achète souvent les mêmes choses, je trouve cette fonctionnalité formidable.


## Opportunité (manquée)

Pas d’application officielle Rappels sur Apple Watch, c’était donc l’opportunité rêvée pour 1List. 

![Image promotionnelle 1List pour Apple Watch][1List Apple Watch]

Petit problème : j’ai complètement ignoré cette magnifique occasion pendant les six derniers mois où WatchKit était disponible en beta, pour me réveiller lorsque la montre est enfin arrivée, il y a seulement quinze jours. C’est un peu embarrassant.

Ce n’est pas faute de ne pas y avoir pensé, mais parce qu’il me semblait évident qu’Apple allait proposer Rappels, comme sur iPhone, iPad et Mac. Cette hypothétique application n’a jamais été évoquée au cours des deux keynotes Apple Watch, et l’absence d’icône sur les aperçus de l’interface auraient dû suffire à me convaincre de sa non-existence. 

Le manque est évidement beaucoup plus remarquable lorsqu’on utilise enfin la montre. Plusieurs articles l’ont rapidement remarqué. Pour moi, à chaque fois la même frustration : pourquoi n’ai-je pas préparé 1List en avance, pour pouvoir profiter du lancement ?

C’est d’autant plus regrettable que le développement de l’application pour WatchKit dans ce cas précis est trivial, avec une liste, et la réponse à un évènement pour marquer un rappel comme `completed`. Ce n’est pas pour rien que les applications to-do sont souvent utilisées comme des exemples ou tutoriels pour présenter un nouveau framework. Bien sûr, l’interaction avec l’API `EKReminder` était déjà prise en charge par mon application iOS. Encore mieux, l’API WatchKit de saisie de texte avec Siri (l’équivalent d’un champ de texte classique sur une montre) propose directement l’affichage de suggestions, me permettant d’implémenter très facilement la fonctionnalité déjà présente sur iPhone/iPad.

1List pour Apple Watch est donc maintenant disponible [sur l’App Store](https://itunes.apple.com/app/1list-fast-simple-reminders/id579440241?mt=8).

Le problème d’une application développée ainsi sur le tard, c’est qu’elle pourrait facilement être améliorée avec un peu de recul. Lisibilité du texte, gestion du changement de liste, ce sera donc l’occasion d’une mise à jour qui devrait arriver bientôt. Entre la maladresse des applications développées sans avoir accès au produit final, et la précipitation de vouloir proposer quelque chose dans les premiers jours de disponibilité de la montre, on ne peut pas dire que les conditions du lancement de WatchKit étaient idéales.

La morale de l’histoire, c’est que je devrais moins hésiter à sauter sur ce genre d’opportunité lorsqu’elles se présentent. Avoir 1List pour Apple Watch disponible dès le premier jour n’aurait peut-être rien changé, mais c’est bien tout le problème de cette situation : la frustration de ne pas savoir. Si Apple annonce un SDK pour Apple TV le mois prochain à la WWDC, il sera toujours temps d’adapter 1List pour la télévision.


## Résultats

Avec « App Analytics » tout juste disponible, Apple nous permet enfin d’avoir des statistiques sur la page App Store d’une application. C’est une nouveauté importante, qui lève le voile sur des données jusqu’alors inaccessibles.

Voilà ce que ça donne avec 1List, pour la semaine qui vient de s’écouler :

![Aperçu App Analytics pour 1List, 11 — 17 mai 2015][1List Analytics]

Je dois dire que le lancement s’est passé mieux que prévu. Avec l’ajout de l’application Apple Watch, j’ai décidé de passer le prix à $1.99 (l’app iOS était gratuite depuis plusieurs mois, après une période initiale payante, avec un tarif similaire). Je précise tout de suite que les revenus de cette semaine sont littéralement exceptionnels, en ce qui me concerne.

On voit que les courbes chutent rapidement, après une grosse première journée. Il s’agissait de la sortie de la mise à jour, mais surtout de la publication d’un [article sur iGen.fr](http://www.igen.fr/app-store/2015/05/1list-affiche-les-rappels-dios-sur-lapple-watch-91189), relayant cette nouveauté. C’est particulièrement remarquable au niveau des _App Store Views by Territory_, avec une surreprésentation de la France. L’application est disponible en anglais, français et chinois, ce qui explique assez logiquement le reste. 

Les chiffres de fréquentation de la page App Store sont vraiment intéressants, puisque totalement indisponibles jusqu’à présent. Dans mon cas, une brève sur iGen.fr aura donc apporté environ un millier d’utilisateurs potentiels sur l’App Store, pour une cinquantaine d’achats. Si quelqu’un chez iGen veut bien me donner un aperçu des statistiques pour l’article en question, je serais ravi de les publier ici. 

C’est un peu ça, la vie de développeur indépendant. Pas mal d’incertitudes, des lancements plus ou moins improvisés, des chiffres parfois encourageants (mais globalement insignifiants), et surtout l’écriture d’un billet de blog pour boucler le tout.
 

[1List Apple Watch]: http://www.vtourraine.net/blog/img/2015/1list-rappels-apple-watch/1list-apple-watch.png
[1List Analytics]:   http://www.vtourraine.net/blog/img/2015/1list-rappels-apple-watch/1list-analytics.png