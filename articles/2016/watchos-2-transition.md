# Transition vers watchOS 2

J’ai récemment eu l’occasion de mettre à jour une application pour watchOS 2. Ce passage n’est pas anodin, car le mode de fonctionnement des apps est littéralement renversé.

Avec watchOS 1, les apps tierces sur Apple Watch étaient en réalité pilotées depuis une _App Extension_ sur l’iPhone. Pour watchOS 2, cette Extension est déplacée sur la montre, ce qui donne des apps « natives ». Il s’agit d’une amélioration sensible, qui permet aux apps de s’executer beaucoup plus rapidement, et surtout d’être utilisables même lorsque l’iPhone n’est pas à portée. 

Mais cette transition peut se révéler très complexe, selon le mode de fonctionnement de l’application, en particulier vis-à-vis de l’app iPhone associée.


## Vive WatchKit

On dit souvent qu’UIKit est une version améliorée d’AppKit. De la même façon, on peut voir WatchKit comme une version améliorée d’UIKit. On simplifie certaines API (une seule classe de View Controller), on établit de nouveaux concepts (la disposition des vues par « groupes »), et on ajoute quelques objets sympathiques (`WKInterfaceTimer`, toujours synchronisé). 

Cette simplification s’explique évidemment en grande partie par les contraintes matérielles propres à la Watch. Mais peu importe. Les API sont familières pour un développeur iOS, mais adaptées pour l’OS en question. Les concepteurs de WatchKit ont fait un travail remarquable.

Bien sûr, ces qualités étaient présentes dès watchOS 1, mais le déplacement de l’Extension exécutant le code vers la Watch elle-même conforte cette API.