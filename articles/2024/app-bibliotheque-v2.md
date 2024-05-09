Title:     Nouvelle approche pour l’application Bibliothèque de Grenoble  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      May 9, 2024  
Update:    
Keywords:  iOS, dev  
Summary:   J’adore développer cette application, pourtant elle ne me facilite pas les choses.  
Image:     
Language:  fr  


J’adore développer [cette application](https://apps.apple.com/app/grenoble-municipal-library/id1483022528?mt=8), pourtant elle ne me facilite pas les choses.

Petit retour en arrière. Je vais régulièrement à la bibliothèque. Elle ne proposait pas d’application mobile pour suivre ses emprunts, et le site web s’adaptait mal à un écran de téléphone. J’ai donc créé ma propre application iOS. Comme il n’y avait pas d’API, j’utilisais une web view cachée contrôlée à coups de Javascript, extrayant les informations des pages HTML. Puis, ils ont ouvert leur API. J’ai donc mis à jour mon application, et tout allait super bien. Plus rapide ! Plus sécurisée ! Plus de fonctionnalités !

Hélas, il y a quelques mois, la bibliothèque a changé de backend et supprimé son API publique. J’étais donc repassé à une web view cachée, malgré son instablilité. Dernier rebondissement : l’annonce d’une [application mobile officielle](https://apps.apple.com/fr/app/mobithèque/id1533403286). Bref, il est temps de s’adapter.

[Voici donc une version 2.0 de mon application pour la bibliothèque de Grenoble.](https://apps.apple.com/app/grenoble-municipal-library/id1483022528?mt=8) Au revoir les emprunts en cours. C’est vraiment dommage, c’était la fonctionnalité la plus utile à mes yeux. Mais tout le reste est là : agenda, horaires des bibliothèques, recherche rapide. Et on peut toujours sauvegarder son numéro d’abonné pour présenter le code barre comme une vraie carte d’abonné.

En théorie, tout ça est également disponible dans l’application officielle. Sauf qu’ils utilisent visiblement un framework cross-platform, sans aucun effort d’adaptation. Pire : la connexion au compte abonné est tragiquement instable. Un résultat bien consternant…

Donc je continue de proposer mon application. Tous ces aléas techniques ne m’encouragent pas vraiment à continuer ce développement, mais j’aime trop la bibliothèque pour laisser tomber. J’espère que l’application officielle va s’améliorer et j’espère un jour le retour d’une API ouverte. En attendant, je peux toujours lire des livres.
