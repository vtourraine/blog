Title:    Nouveautés de l’application Bibliothèque de Grenoble  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     May 7, 2025  
Update:   
Keywords: dev, iOS, macOS  
Summary:  Je viens de publier une petite mise à jour de mon application (non officielle) pour la bibliothèque de Grenoble. J’aimerais mentionner deux changements en particulier.  
Image:    https://www.vtourraine.net/blog/img/2025/bm-grenoble-nouveautes/bm-iphone-nouveautes.jpg  
Language: fr  


Je viens de publier une petite mise à jour de [mon application (non officielle) pour la bibliothèque de Grenoble](https://apps.apple.com/app/grenoble-municipal-library/id1483022528?l=en). J’aimerais mentionner deux changements en particulier.

## Bibliothèques en travaux

Sur les 13 bibliothèques du réseau, deux sont actuellement fermées pour travaux. J’ouvre souvent l’application pour consulter les horaires d’ouverture, mais jusqu’à présent, rien n’assurait que la bibliothèque en question était vraiment ouverte.

[J’utilise un fichier `.plist` pour gérer ces informations](https://github.com/vtourraine/bm-grenoble-ios/blob/main/bm/Libraries/Base.lproj/Libraries.plist), j’ai donc ajouté un booléen pour indiquer lesquelles sont fermées. Il ne restait plus qu’à ajuster l’interface, et voilà, le tour est joué. [J’ai hâte d’amender ce fichier le 4 juin à la réouverture de la bibliothèque Gisèle Halimi (Saint-Bruno).](https://bm-grenoble.fr/~~/default/reouverture-de-la-bibliotheque-saint-bruno.aspx)

![Liste et carte des bibliothèques sur iPad](/blog/img/2025/bm-grenoble-nouveautes/bm-ipad-bib-fermees.jpg)

Oui, le fichier pourrait être stocké hors du bundle de l’application, pour pouvoir être actualisé sans passer par une mise à jour sur l’App Store. Mais j’aime aussi les applications qui ne dépendent pas d’un serveur web.

## Nouveautés

C’est toujours un grand plaisir d’entrer dans une bibliothèque pour jeter un œil aux nouveautés mises en avant par les bibliothécaires. Hors, j’ai récemment remarqué que le site web officiel inclut [une liste des nouveautés pour chaque bibliothèque](https://bm-grenoble.fr/bibliotheque-jardin-de-ville.aspx), et surtout, un lien RSS pour s’y abonner. [À défaut d’une API ouverte](https://www.vtourraine.net/blog/2024/app-bibliotheque-v2), quoi de mieux qu’un bon vieux standard web, facile à intégrer. On lui pardonne même le format XML en 2025.

Là encore, quelques heures passées sur Xcode pour ajouter le décodage (via [FeedKit](https://github.com/nmdias/FeedKit)), ajustement de l’interface, et les nouveautés apparaissent maintenant sur l’écran de détail de chaque bibliothèque. Formidable.

![Nouveautés sur iPhone](/blog/img/2025/bm-grenoble-nouveautes/bm-iphone-nouveautes.jpg)
