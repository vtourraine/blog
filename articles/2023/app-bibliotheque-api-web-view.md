Title:     Bibliothèque de Grenoble : au revoir l’API  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      January 15, 2023  
Update:    
Keywords:  iOS, dev  
Summary:   Développer une application basée sur une API qu’on ne contrôle pas est une source d’inquiétude permanente. C’est le cas avec mon application pour la Bibliothèque Municipale de Grenoble.  
Image:     
Language:  fr  


Développer une application basée sur une API qu’on ne contrôle pas est une source d’inquiétude permanente. C’est le cas avec [mon application pour la Bibliothèque Municipale de Grenoble](https://apps.apple.com/app/grenoble-municipal-library/id1483022528). Ou plutôt : *c’était* le cas. Depuis quelques semaines, l’application n’arrivait plus à se connecter à l’API. Bug ? Opération de maintenance ? Hélas, on m’a confirmé qu’il s’agissait d’un changement volontaire, la conséquence d’un renforcement des réglages de sécurité du serveur. Plus d’API publique, juste la web app officielle.

Pour mon application iOS/macOS, je me vois donc contraint de revenir à ma solution d’origine : utiliser une web view cachée, interagir avec du Javascript et analyser le code HTML obtenu pour en extraire les informations voulues. C’est lent, instable, fragile, limité, inutilisable dans une extension (donc plus de widget). Mais c’est la seule façon pour continuer d’afficher une liste de prêts en cours.

[J’étais ravi de prendre en charge l’API en 2021](https://www.vtourraine.net/blog/2021/bibliotheque-grenoble-api). Je suis bien triste de revenir en arrière avec cette première mise à jour de 2023. J’espère que l’API reviendra un jour. Pour l’instant, je vais me concentrer sur d’autres fonctionnalités et d’autres projets.
