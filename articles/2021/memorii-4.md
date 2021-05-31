Title:     Memorii 4  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      May 31, 2021  
Update:    
Keywords:  dev, iOS, macOS  
Summary:   Voici Memorii 4, une nouvelle version de mon application d’apprentissage par cartes mémoire. Au programme des nouveautés : l’ajout de vocabulaire coréen, un widget pour les Favorites, et de nombreuses améliorations de l’interface.  
Image:     https://www.vtourraine.net/blog/img/2021/memorii-4/memorii-4.jpg  
Language:  fr  


Voici [Memorii 4](https://apps.apple.com/app/memorii/id352411168), une nouvelle version de mon application d’apprentissage par cartes mémoire. Au programme des nouveautés : l’ajout de vocabulaire coréen (une liste gratuite pour les nouveaux utilisateurs, et une liste supplémentaire disponible avec achat in-app), un widget pour les Favorites, et [de nombreuses améliorations de l’interface](https://www.studioamanga.com/memorii/releasenotes).

![Air Grenoble 4 sur Mac, iPad et iPhone](/blog/img/2021/memorii-4/memorii-4.jpg)

J’aime beaucoup cette application. L’interface s’adapte à chaque plateforme : tab bar sur iPhone, split view sur iPad et optimisations Catalyst pour le Mac. Les données sont synchronisées automatiquement par iCloud avec Core Data (!). Il y a des menus contextuels, des raccourcis clavier… à peu près tout ce qu’on peut attendre d’une application moderne.

Le seul problème que j’ai rencontré concerne la recherche sur le Mac. Pour iOS, `UISearchController` rempli son rôle. Pour macOS, idéalement, le champs de recherche devrait aller dans la toolbar, comme la plupart des applications. Mais ce n’est pas possible avec Catalyst pour l’instant (pas d’équivalent à  `NSSearchToolbarItem`). Je pourrais le garder en haut de la vue de gauche comme pour iOS, mais cette liste n’a pas de titre sur le Mac, le champs de recherche n’y semble pas à sa place, et l’affichage des résultats manque de cohérence visuelle. Bref, j’ai préféré omettre complètement cette fonctionnalité de l’application pour Mac. J’espère qu’une prochaine version de Catalyst aidera à résoudre ce problème. Ou bien il faudra ajouter une couche supplémentaire de code dédié pour arriver à un résultat satisfaisant. Comme toujours avec Catalyst, il faut chercher un équilibre entre un code entièrement partagé et les optimisations spécifiques à chaque plateforme.

J’ai également revu [le site web](https://www.studioamanga.com/memorii/), en y ajoutant un descriptif plus détaillé, et avec de nouveaux screenshots pour mieux illustrer les différentes fonctionnalités. Je trouve toujours difficile de présenter les différentes plateformes disponibles. Les écrans d’iPhone se focalisent naturellement sur une fonctionnalité, et sont plus parlants. En revanche, pour le Mac et l’iPad il faut recadrer les screenshots pour mettre en avant un élément, et en même temps garder l’appareil visible pour contextualiser et différencier ces deux plateformes. Pour l’instant, je me contente d’une image principale avec tous les appareils, puis uniquement des screenshots iPhone pour les détails. À l’avenir, j’espère avoir plus de temps pour travailler cette page. C’est important pour le marketing et la communication (même si la page App Store reste la principale vitrine), mais c’est aussi un défi de conception graphique. Et puis, ça me change de travailler avec du HTML/CSS de temps en temps.

Si vous souhaitez réviser votre vocabulaire chinois, japonais ou coréen, [Memorii](https://apps.apple.com/app/memorii/id352411168) est fait pour vous.