# À propos de watchOS 2

J’ai récemment eu l’occasion de mettre à jour une application pour watchOS 2. Un peu en retard, l’OS était disponible depuis septembre dernier. Mais ce passage n’est pas anodin, car le mode de fonctionnement des apps s’en trouve littéralement renversé.

Avec watchOS 1, les apps tierces sur Apple Watch étaient pilotées à distance, depuis une _App Extension_ sur l’iPhone associé. Avec watchOS 2, cette Extension se trouve sur la montre, ce qui donne des apps « natives ». Il s’agit d’une amélioration sensible, qui permet aux apps de s’exécuter beaucoup plus rapidement, et surtout d’être utilisables même lorsque l’iPhone n’est pas à portée. 

Mais cette transition peut se révéler complexe, selon le mode de fonctionnement de l’app prévu pour watchOS 1, en particulier vis-à-vis de l’app iPhone qui l’héberge.


## Vive WatchKit

On dit souvent qu’UIKit est une version améliorée d’AppKit. De la même façon, on peut voir WatchKit comme une version améliorée d’UIKit. On simplifie certaines API (une seule classe de View Controller), on établit de nouveaux concepts (la disposition des vues par « groupes »), et on ajoute quelques objets sympathiques (`WKInterfaceTimer`, toujours synchronisé). 

Cette simplification s’explique évidemment en grande partie par les contraintes matérielles propres à la Watch. Mais peu importe. Les API sont familières pour un développeur iOS, tout en s’adaptant à l’OS en question. Les concepteurs de WatchKit ont fait un travail remarquable.

Bien sûr, ces qualités étaient présentes dès watchOS 1, mais le déplacement de l’Extension vers la Watch elle-même conforte cette API. Elle peut enfin s’exprimer indépendamment. Les performances matérielles actuelles ne sont pas tout à fait à la hauteur, mais c’est le genre de problème qui se règle rapidement après quelques itérations.


## Des apps qui n’intéressent personne

De l’avis général, l’Apple Watch est un produit relativement intéressant. Un accessoire, qui ne change pas la vie de celui qui la porte, mais qui peut se révéler utile dans certains contextes. Le problème pour les développeurs tiers, c’est que les apps sur Apple Watch n’intéressent personne.

Apple a visiblement cherché à transposer le succès de l’App Store, en proposant un SDK (_WatchKit_) en amont du lancement du produit lui-même. Des intentions louables, mais un échec complet.

En présentant le SDK trop tôt, la première vague d’applications a été développé dans le vide, uniquement sur simulateur. Apple a bien organisé quelques « labs », invitant les développeurs à venir tester sur le matériel réel, mais cet effort est resté anecdotique. Les interactions de ces premières apps étaient généralement inadaptées et maladroites. Les limitations techniques de watchOS 1 n’ont pas amélioré les choses. Ce fonctionnement à distance, avec une exécution ayant la fiabilité d’une connection Bluetooth, aura laissé une impression d’instabilité tenace. Il fallait généralement quelques secondes pour le lancement d’une app, c’est-à-dire qu’il était littéralement plus rapide de sortir son iPhone de sa poche à la place. Enfin, les apps pour Apple Watch peuvent uniquement être proposées par l’intermédiaire d’une app iPhone. Un accessoire impossible à monétiser, donc.


## Mise-à-jour watchOS 2

Six mois plus tard, le pompier se transforme en croque-mort. watchOS 2 répond bien aux attentes initiales des développeurs, mais arrive au mauvais moment. La transition requiert un effort technique conséquent. À titre d’exemple, la première version de WatchKit proposait une méthode `openParentApplication:reply:`, permettant de communiquer directement avec l’app principale. Cette API a disparu avec watchOS 2. Une bonne chose, puisque la Watch se trouve découplée de l’iPhone, mais un changement radical pour les apps qui l’utilisait.

Or, l’enthousiasme du lancement est passé, et les développeurs ont pu constater le manque d’intérêt de la part des utilisateurs. La plateforme se trouve comme paralysée.

C’est évidemment regrettable pour un OS qui n’a pas encore soufflé sa première bougie. Ça ne veut pas dire que la Watch est un échec, ou même qu’il faut cesser le développement d’apps pour  la montre. Mais je pense qu’Apple a plutôt mal anticipé cette plateforme. Une situation ironique si on la compare à celle de l’Apple TV. Cette confusion initiale permettra sans doute des développements plus adaptés à l’avenir.