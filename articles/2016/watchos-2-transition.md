# Transition vers watchOS 2

## Vive WatchKit

On dit souvent qu’UIKit est une version améliorée d’AppKit. De la même façon, on peut voir WatchKit comme une version améliorée d’UIKit. On simplifie certaines API (une seule classe de View Controller), on établit de nouveaux concepts (la disposition des vues par « groupes »), et on ajoute quelques objets sympathiques (`WKInterfaceTimer`, toujours synchronisé). 

Cette simplification s’explique évidemment en grande partie par les contraintes matérielles propres à la Watch. Mais peu importe. Les API sont familières pour un développeur iOS, mais adaptées pour l’OS en question. Les concepteurs de WatchKit ont fait un travail remarquable.