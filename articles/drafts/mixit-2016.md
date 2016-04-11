# Mix-IT 2016

La nouvelle édition de Mix-IT se déroulera la semaine prochaine, c’était donc le bon moment pour mettre à jour mon app iOS permettant d’en consulter le programme. 


## Mise à niveau



## Plans

La première version proposait une carte (`MKMapView`) indiquant CPE (l’école qui accueille Mix-IT) afin d’aider à localiser la conférence. Cette année, j’ai ajouté les plans de l’intérieur du bâtiment permettent de retrouver les différentes salles. Pas d’API magique, pas de géolocalisation, juste quelques images issues du site web de Mix-IT. On peut les consulter depuis l’écran d’infos générales, ou en tapant sur le nom d’une salle sur l’écran de détails d’une session. 

Idéalement, il faudrait pouvoir mettre en valeur la salle en question sur le plan, mais cela demanderait davantage d’images, ou une API dédiée. Pour l’instant, ces quelques images feront l’affaire.


## Since 2012

Quand une API propose une fonctionnalité, ça devient tentant de la mettre en pratique. La ressource pour obtenir la liste des sessions accepte un unique paramètre, par ailleurs facultatif : l’année concernée. Par défaut, on obtient l’édition courante, mais on peut ainsi obtenir les sessions de toutes les éditions depuis 2012.

Ça ne sert pas à grand chose pour une app comme la mienne, mais la simplicité à intégrer ces données supplémentaires était trop tentante.
