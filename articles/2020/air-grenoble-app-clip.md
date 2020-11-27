Title:     App Clip pour Air Grenoble  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      November 27, 2020  
Update:    
Keywords:  dev, iOS  
Summary:   « App Clip » était annoncé comme l’une des grandes nouveautés d’iOS 14. Depuis la keynote aux multiples sessions WWDC, en passant par sa mise en avant dans App Store Connect, Apple a tout fait pour encourager son utilisation.  
Image:     https://www.vtourraine.net/blog/img/2020/air-grenoble-app-clip/airgrenoble-app-clip.jpg  
Language:  fr  


« App Clip » était annoncé comme l’une des grandes nouveautés d’iOS 14. Depuis la keynote aux multiples sessions WWDC, en passant par sa mise en avant dans App Store Connect, Apple a tout fait pour encourager son utilisation. Pour l’instant, on ne peut pas dire que ça rencontre un grand succès.

Un App Clip, c’est un nouveau type d’extension, distribué avec une application iOS. Ça ressemble dans les grandes lignes à une application normale, avec quelques API interdites, et d’autres ajoutées pour mieux cibler son utilisation (par URL ou par position géographique, par exemple). Et le résultat ne doit pas excéder 10 Mo. Mais le plus intéressant concerne sa distribution : on installe un App Clip sans passer par la confirmation avec Apple ID. Il suffit d’appuyer sur le bouton “Ouvrir”, et voilà, l’App Clip se télécharge, s’installe et s’ouvre. Avec une bonne connexion internet, le processus est presque instantané.

Cette différence de méthode de distribution peut paraître insignifiante. Il suffit de se pencher sur la question de l’acquisition des utilisateurs pour comprendre que c’est une opportunité remarquable.

Pour m’en faire une idée plus concrète, j’ai ajouté un App Clip à [Air Grenoble](https://apps.apple.com/app/air-grenoble/id1183533416).

Air Grenoble ne sauvegarde aucune donnée localement, la création de l’App Clip était donc triviale. Une fois l’extension correctement configurée, il m’a suffit d’y placer le code de l’application principale.

Pour tout dire, j’ai eu plus de mal à configurer la bannière pour la page web. L’extension et le domaine web doivent être correctement associés, la balise `<meta name="apple-itunes-app">` adaptée, et la page correspondante dans App Store Connect configurée. Avec, en bonus, des problèmes de cache du côté d’iOS et Safari. Mais je dois dire que le résultat est satisfaisant.

![Bannière App Clip pour Air Grenoble](/blog/img/2020/air-grenoble-app-clip/airgrenoble-app-clip.jpg)

Vous pouvez tester l’App Clip en visitant [cette page](https://www.studioamanga.com/airgrenoble/) avec un appareil iOS 14. La bannière devrait apparaître si l’application n’est pas déjà installée.

Dans le cas d’Air Grenoble, cette extension a un intérêt très limité. Mais pour les développeurs d’applications payantes qui réclament depuis des années un mode d’évaluation, Apple a enfin proposé une solution avec App Clip. Le seul problème, c’est qu’elle n’est pas disponible depuis l’App Store.
