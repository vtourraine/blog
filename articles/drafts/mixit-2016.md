# Mix-IT 2016

La nouvelle édition de Mix-IT se déroulera la semaine prochaine, c’était donc le bon moment pour mettre à jour [mon app iOS](https://itunes.apple.com/app/mix-it/id982003173?mt=8) permettant d’en consulter le programme, initialement publiée [l’année dernière](http://www.vtourraine.net/blog/2015/app-mixit). Le projet est toujours [disponible sur GitHub](https://github.com/vtourraine/mixit), pour les plus curieux.


## Mise à niveau

Premier objectif, mettre à jour le connecteur pour l’API de Mix-IT, puisque celle-ci a évolué depuis la dernière édition. Pas de grands changements, il suffit globalement d’actualiser les URLs et de modifier certaines clés dans les réponses du serveur.

L’autre mise à jour concerne les dates de la conférence, telles qu’affichées dans l’écran d’information. Impossible de récupérer cette information automatiquement, ce sera donc stocké directement dans le code. Ma feature request pour l’année prochaine, donc : ajouter une ressource à API permettant de connaître les dates des différentes éditions (et la liste des éditions disponibles).


## Plans

La première version proposait une carte (`MKMapView`) indiquant CPE (l’école qui accueille Mix-IT) afin d’aider à localiser la conférence. La combinaison cartes + GPS reste une valeur sûre du développement mobile, on aurait tort de s’en priver.

Cette année, j’ai ajouté les plans de l’intérieur du bâtiment permettant de retrouver les différentes salles. Pas d’API magique, pas de géolocalisation, juste quelques images issues du site web de Mix-IT. On peut les consulter depuis l’écran d’infos générales, ou en tapant sur le nom d’une salle sur l’écran de détails d’une session. 

Idéalement, il faudrait pouvoir mettre en valeur la salle en question sur le plan, mais cela demanderait davantage d’images, ou une API dédiée. Pour l’instant, ces quelques images feront l’affaire.


## Since 2012

Quand une API propose une fonctionnalité, ça devient tentant de la mettre en pratique côté client. La ressource pour obtenir la liste des sessions accepte un unique paramètre (facultatif) : l’année concernée. Par défaut, on obtient l’édition courante, mais on peut ainsi obtenir les sessions de toutes les éditions depuis 2012.

Ça ne sert pas à grand chose pour une app comme la mienne, mais la simplicité à intégrer ces données supplémentaires était trop tentante. Un paramètre à synchroniser en plus pour les sessions, un paramètre à gérer en plus pour le view controller, et le tour est joué. Première session listée pour 2012 : _Create mobile application with PhoneGap_. Je trouve ça amusant.


## 21 & 22 mai

Voilà pour les changements cette année. J’apprécie ce genre de projet, avec son périmètre de fonctionnalités très restreint. C’est une occasion supplémentaire de construire une app en s’appliquant à garder un code simple et clair. Même pour un cas aussi simple (liste d’éléments, affichage des détails), je pourrais recommencer le projet chaque année de zéro et aboutir à un résultat différent. Des nouveautés UIKit apportent de nouvelles solutions, et bien sûr les habitudes de développement évoluent au fil des projets. 

Ceci étant dit, j’espère que l’app pourra être utile pour les heureux détenteurs d’un billet Mix-IT. Rendez-vous le 21 et 22 mai à Villeurbanne.