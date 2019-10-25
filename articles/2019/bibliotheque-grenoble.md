Title:     Nouvelle application : bibliothèque de Grenoble  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      October 25, 2019  
Update:    
Keywords:  iOS, app, dev  
Summary:   C’est plus fort que moi. Quand j’utilise fréquemment un service qui ne propose pas d’application mobile… je finis par créer moi-même l’application manquante. L’envie est encore plus forte quand le site web en question est mal adapté pour un écran mobile.  
Image:     https://www.vtourraine.net/blog/img/2019/bibliotheque-grenoble/bm-grenoble.png  
Language:  fr  


C’est plus fort que moi. Quand j’utilise fréquemment un service qui ne propose pas d’application mobile… je finis par créer moi-même l’application manquante. L’envie est encore plus forte quand le site web en question est mal adapté pour un écran mobile.

Cette fois-ci, il s’agit donc de la [bibliothèque municipale de Grenoble](https://www.bm-grenoble.fr/). Je consulte régulièrement mon compte en ligne pour connaître la prochaine échéance de retour des livres. À chaque fois, je dois ouvrir le navigateur web, saisir la bonne adresse, entrer mon identifiant et mot de passe (remplis automatiquement, mais quand même), et enfin naviguer sur la page « prêts en cours ». Tout ça avec une mise en page prévue pour un écran d’ordinateur, pas pour un téléphone. Expérience utilisateur : 👎 

![Site web pour la bibliothèque municipale de Grenoble](/blog/img/2019/bibliotheque-grenoble/bm-grenoble-web.png)

La bibliothèque ne propose malheureusement pas d’API publique. Pour contourner ce problème, mon application instancie une web view invisible, y charge l’application web, exécute toutes les interactions nécessaires à coups de [Java Script](https://developer.apple.com/documentation/webkit/wkwebview/1415017-evaluatejavascript), et enfin consulte le code HTML pour en extraire les informations souhaitées. Ce n’est pas joli-joli, mais après tout, un site web est essentiellement une API XML mal formatée.

Cette approche a d’ailleurs de sérieuses limitations. Certains types d’Extensions ne permettent pas l’utilisation d’une web view. Les performances sont assez médiocres. Et surtout, une petite modification côté web suffit pour casser la connexion avec l’application.

![Application bibliothèque de Grenoble](/blog/img/2019/bibliotheque-grenoble/bm-grenoble.png)

Malgré tout, je trouve cette solution extrêmement pratique. J’utilise l’application depuis quelques mois, et elle est maintenant [disponible sur l’App Store](https://apps.apple.com/app/grenoble-municipal-library/id1483022528). Le code source est [intégralement accessible sur GitHub](https://github.com/vtourraine/bm-grenoble-ios), et les contributions sont les bienvenues. J’ai aussi des dizaines d’idées pour améliorer cette application, en complétant le suivi des prêts (notifications de rappel, possibilité de prolonger un prêt, etc) et en ajoutant de nouvelles fonctionnalités (liste des bibliothèques avec horaires, recherche dans le catalogue, etc). Avec tout ça, je n’ai presque plus le temps de lire.
