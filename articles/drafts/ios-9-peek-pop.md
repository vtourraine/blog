# Comment implémenter Peek et Pop pour 3D Touch

Tous les ans c’est la même chose, Apple garde quelques API en surprise pour la mise à jour d’iOS du mois de septembre.

Avec iOS 9 et les écrans “3D Touch” des nouveaux iPhones, voici donc Peek et Pop, qui remportent le prix du nom le plus ridicule à prononcer. Techniquement parlant, il s’agit de “view controller previewing” et de “commit”.

Concrètement, il s’agit d’un moyen alternatif pour présenter un view controller, en appuyant légèrement sur un élément pour prévisualiser l’action (“peek”), et en appuyant plus fort pour confirmer (“pop”). Ça n’a rien d’essentiel, mais cette nouvelle interaction possède à mes yeux un avantage de taille : pouvoir visualiser puis faire disparaître un view controller avec un unique appui sur l’écran. Plutôt que d’appuyer une fois pour présenter et une seconde fois pour revenir, tout se fait à partir de la pression appliquée à un seul _tap_. Inutile d’aller chercher le bouton “Retour” tout en haut à gauche d’écran, inutile de tenter un glisssement depuis la gauche, il suffit de relever le doigt.

