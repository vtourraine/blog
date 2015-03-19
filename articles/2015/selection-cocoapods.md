Title:    Ma sélection des pods les plus utilisés  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     March 19, 2015  
Update:   
Keywords: CocoaPods, dev
Summary:  La première fois qu’on me l’a présenté, CocoaPods m’avait laissé sceptique. Gérer ses dépendances et configurer un workspace Xcode était déjà assez compliqué comme ça, pas besoin de rajouter un outil tiers par dessus tout le reste. Bien sûr, c’est pourtant exactement pour cela que CocoaPods est si intéressant, parce qu’aucun développeur Objective-C ne devrait avoir à configurer un workspace pour une quelconque dépendance, ou mettre à jour un code tiers en téléchargeant une archive zip sur GitHub pour ensuite déplacer manuellement un ensemble de fichiers.   
Image:    http://www.vtourraine.net/blog/img/2015/recuperer-espace-time-machine/time-machine.jpg  
Language: fr  


La première fois qu’on me l’a présenté, CocoaPods m’avait laissé sceptique. Gérer ses dépendances et configurer un workspace Xcode était déjà assez compliqué comme ça, pas besoin de rajouter un outil tiers par dessus tout le reste. Bien sûr, c’est pourtant exactement pour cela que CocoaPods est si intéressant, parce qu’aucun développeur Objective-C ne devrait avoir à configurer un workspace pour une quelconque dépendance, ou mettre à jour un code tiers en téléchargeant une archive zip sur GitHub pour ensuite déplacer manuellement un ensemble de fichiers.

Je sais qu’il a encore de nombreux sceptiques. Il n’est pas question d’utiliser des pods partout, tout le temps. Mais la conviction qu’un développeur devrait éviter à tout prix d’intégrer un code tiers dans son application, et rester entièrement maître de son projet, est une illusion qui me semble un peu ridicule. À moins de vouloir tout reconstruire à base d’assembleur, n’importe quelle application s’appuie sur un code existant, quelle qu’en soit l’origine.

Ceci dit, le but de ce billet n’est pas de convaincre qui que ce soit, simplement de revenir un instant sur ces quelques projets open source — ces « pods » — que j’utilise régulièrement.


## Colours

<https://github.com/bennyguitar/Colours>

![Colours, capture d’écran du fichier readme][Colours]

`UIColor` n’est pas une classe comme les autres. Au milieu des chaînes de caractères et autres `CGRect`, elle apporte un peu de joie de vivre à une application. Donne-moi du bleu, du rouge, du jaune… en voici, en voilà. Malheureusement, son vocabulaire est très limité. 

Avec _Colours_, vous aurez l’embarras du choix. Il s’agit d’une catégorie sur `UI/NSColor`, vous pouvez donc l’utiliser sans changer vos habitudes, mais en disposant littéralement d’une centaine de variations entre `pastelBlueColor`, `watermelonColor`, et autres `mustardColor` (très utile pour les applications dédiées à la moutarde, par exemple). Je vous conseille de jeter un coup d’œil à la page d’accueil du projet sur GitHub, où vous trouverez la palette dans son intégralité.

_Colours_ ne s’arrête pas à des valeurs pré-remplies, il fournit aussi toutes les méthodes qui manquaient pour la création et la manipulation des couleurs. Enfin la possibilité d’utiliser directement le code hexadécimal avec `[UIColor colorFromHexString:@“#f587e4”];`, ou bien d’ajuster la luminosité d’une couleur existante avec `[[UIColor seafoamColor] darken:0.25f];`. Trop d’applications reposent sur le bleu iOS standard, c’est donc une raison supplémentaire pour personnaliser la vôtre avec des couleurs plus originales, et ce pod vous offre tous les moyens pour réussir.

Enfin, si vous trouvez que _Colours_ en fait parfois un peu trop, il existe également le très pratique [iOS7Colors](https://github.com/claaslange/iOS7Colors), qui se concentre sur les couleurs vives mises en avant à l’occasion de la sortie d’iOS 7 et de l’iPhone 5c.


## PBWebViewController

<https://github.com/kmikael/PBWebViewController>

![PBWebViewController, image Mikael Konutgan][PBWebViewController]

Pour ouvrir une page web, vous avez deux possibilités : demander à Safari de s’en charger, ou afficher votre propre `UIWebView`/`WKWebView`. 

Tout dépend du contexte, mais la solution idéale se situe souvent quelque part entre les deux. Si vous ne voulez pas basculer sur une autre application, mais tout de même proposer des options intéressantes telles que des boutons « page précédente/suivante » ou le partage de l’URL avec `UIActivityViewController`, vous avez tout intérêt à utiliser un mini navigateur à base de web view, à l’image de _PBWebViewController_.

Rien de bien compliqué, juste quelques options sur la toolbar ou les activités de partage, et le tour est joué. Si cette implémentation ne vous convient pas, il existe de nombreuses alternatives. Quoi qu’il en soit, encore une classe que je suis ravi de ne pas avoir à reconstruire pour chacune de mes applications.


## iRate

<https://github.com/nicklockwood/iRate>

![iRate, image Nick Lockwood][iRate]

Ce sera peut-être le choix le plus controversé de cette liste. Pas pour le pod en lui-même, mais plutôt pour la pratique qui l’accompagne : afficher une alerte pour demander aux utilisateurs d’aller noter l’application sur l’App Store. 

Je ne sais pas exactement où et quand est apparue cette approche, mais elle s’est beaucoup répandue, à mesure que s’intensifiait la lutte pour la visibilité sur l’App Store. Bien sûr, personne ne souhaite déranger inutilement l’utilisateur, mais la course aux étoiles a toujours été très importante pour se faire une place. Rappelons également qu’avec les premières versions d’iOS, le système lui-même proposait d’évaluer une application… au moment de sa suppression. Pas forcément les meilleurs circonstances pour obtenir un 5-étoiles.

Pour en revenir au pod lui-même, sa mise en œuvre est vraiment remarquable. Il peut en effet fonctionner en autonomie totale, sans la moindre configuration ni le moindre appel de méthode. Il utilise pour cela une méthode méconnue de `NSObject` : `load`, invoquée au démarrage d’une application quand la classe est mise en mémoire (je dis bien la classe, et non pas ses instances). _iRate_ se charge également de récupérer l’identifiant App Store de l’application en interrogeant directement l’API d’iTunes (oui, ça existe) sur la base de son `Bundle ID`. On notera aussi qu’il est localisé en plus d’une trentaine de langues.

Beaucoup de bonnes idées, donc, en essayant bien sûr de ne pas en abuser.


## SVProgressHUD

<https://github.com/TransitApp/SVProgressHUD>

![SVProgressHUD, image Sam Vermette][SVProgressHUD]

Les applications iOS se font un honneur à minimiser autant que possible les temps de chargement. Mais il y a bien quelques situations où un moment d’attente s’impose, pour une opération particulièrement lourde, ou lorsqu’on dépend de la réponse d’un serveur. Pour ces situations, il y a _SVProgressHUD_.

Le plus grand compliment qu’on puisse faire à ce pod, c’est qu’il semble simplement faire partie d’_UIKit_. Il y a toujours quelque chose de frustrant à découvrir un élément d’interface dans une application développée par Apple, mais qui ne fait pas partie du SDK. Ça a longtemps été le cas avec Cover Flow, par exemple, même si les dernières versions d’iOS justifient pleinement cette retenue. Mais la chose est différente pour un écran de progression. Peu importe la version du système d’exploitation ou la vitesse toujours grandissante des réseaux sans fil, une application a parfois besoin d’attendre. _SVProgressHUD_ s’adapte donc à la version courante du système pour accorder son apparence visuelle, ton sur ton.

À noter que [_MBProgressHUD_](https://github.com/jdg/MBProgressHUD) propose essentiellement la même chose, en étant légèrement plus complet (affichage d’un taux de progression sous différentes formes, notamment), mais moins élégant à mon goût. À vrai dire, il m’est arrivé d’intégrer les 2 pods dans une même application pour répondre à différentes situations. Je ne vous conseille absolument pas ce genre de situation, mais c’est sans doute révélateur de l’importance que peuvent avoir ces fichus écrans de chargement, et de la facilité d’utilisation des pods.


## AFNetworking

<https://github.com/AFNetworking/AFNetworking>

![AFNetworking, image Mattt Thompson][AFNetworking]

On pourrait aisément décerner un prix d’honneur à [Mattt](https://twitter.com/mattt) pour l’ensemble de son œuvre, mais _AFNetworking_ est probablement le pod le plus remarquable de tous.

Les possibilités offertes par la connexion internet de l’iPhone sont immenses, mais la mise en place technique n’a pas toujours été aussi évidente. Ça n’a certes pas la complexité de Core Audio, mais il fallait bien une grosse dizaine de lignes de code pour télécharger la moindre resource de façon asynchrone, à force de `NSURLRequest` et de `NSURLConnection`. _AFNetworking_ simplifie tout ça, en intégrant les blocks, la sérialisation des requêtes et la dé-sérialisation des réponses, et bien d’autres choses. C’est donc à la fois plus simple à utiliser, et en même temps plus complet.

Avec iOS 7 et OS X 10.9, Apple a ajouté un nouvel ensemble d’API autour de `NSURLSession`, qui répond à sa manière aux défis déjà relevés par _AFNetworking_. C’était donc l’occasion d’une refonte complète du pod sur ces nouvelles bases, ce qui a donné _AFNetworking 2.0_. Voici venir Swift, et le projet se transforme à nouveau et donne naissance à [_Alamofire_](https://github.com/Alamofire/Alamofire).

À cet égard, ce n’est pas seulement un pod, c’est un reflet de la communauté des développeurs iOS et OS X. Il suit et parfois devance les évolutions des plateformes et des outils fournis par Apple. Vivement le biopic.

[Colours]:             http://www.vtourraine.net/blog/img//2015/selection-cocoapods/colours.jpg
[PBWebViewController]: http://www.vtourraine.net/blog/img//2015/selection-cocoapods/pbwebviewcontroller.jpg
[iRate]:               http://www.vtourraine.net/blog/img//2015/selection-cocoapods/irate.jpg
[SVProgressHUD]:       http://www.vtourraine.net/blog/img//2015/selection-cocoapods/svprogresshud.gif
[AFNetworking]:        http://www.vtourraine.net/blog/img//2015/selection-cocoapods/afnetworking.jpg