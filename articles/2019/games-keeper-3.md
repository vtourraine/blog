Title:     Games Keeper 3  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      September 27, 2019  
Update:    
Keywords:  iOS, app, dev  
Summary:   Je n’ai jamais vraiment été satisfait de l’interface de Games Keeper. Depuis sa première version, elle ressemble davantage à un prototype qu’à une application aboutie. En l’adaptant pour iOS 13, j’ai développé une nouvelle interface qui me paraît plus plaisante, tout en restant cohérente avec le fonctionnement de l’application. Je ne dirais pas que je suis pleinement satisfait du résultat, mais il s’agit d’une amélioration significative. Voici donc Games Keeper 3.  
Image:     https://www.vtourraine.net/blog/img/2019/games-keeper-3/games-keeper-3.png  
Language:  fr  


Je n’ai jamais vraiment été satisfait de l’interface de [Games Keeper](https://itunes.apple.com/app/games-keeper/id674138310?mt=8). Depuis sa première version, elle ressemble davantage à un prototype qu’à une application aboutie.

En l’adaptant pour iOS 13, j’ai développé une nouvelle interface qui me paraît plus plaisante, tout en restant cohérente avec le fonctionnement de l’application. Je ne dirais pas que je suis pleinement satisfait du résultat, mais il s’agit d’une amélioration significative. Voici donc Games Keeper 3.

![Games Keeper 1 (2013), Games Keeper 2 (2016), Games Keeper 3 (2019)](/blog/img/2019/games-keeper-3/games-keeper-1-2-3.png)

## Fond uni

La barre de navigation est un élément fondamental d’UIKit. iOS 11 avait introduit la notion de « large title » (`UINavigationBar.prefersLargeTitles`), avec une barre plus haute et un titre plus grand. iOS 13 pousse ce concept plus loin, en faisant disparaître la ligne qui sépare la barre de navigation du contenu, et en étendant le fond de la vue principale jusqu’en haut de l’écran.

Games Keeper 2 utilisait des barres de navigation oranges. Avec la nouvelle apparence d’iOS 13, l’orange disparaît, et la barre devient blanche ou grise comme le reste de l’écran. Je trouve dommage de perdre cette distinction visuelle. Le résultat est plus terne, et les modales apparaissent moins détachées de la vue principale, surtout avec leur nouveau style qui laisse dépasser l’écran présentant.

Il fallait donc que je change quelque chose, mais je ne savais pas quoi. J’ai commencé par tester plusieurs styles de barre de navigation. Puis j’ai essayé d’étendre la couleur orange à l’intégralité des modales. C’était visuellement remarquable, mais un peu aveuglant.

Enfin, j’ai laissé les modales avec le style par défaut, en gris, et j’ai utilisé l’orange pour le fond de la vue principale. Cela permet de garantir un contraste visuel fort entre la partie en cours et le reste de l’application, tout en renforçant son identité visuelle. Mais comment éviter l’effet éblouissant d’un écran complètement orange ?

## Cartes

La réponse s’est imposée logiquement. L’interface fonctionnait déjà sur le principe des cartes, chaque carte représentant le score pour un joueur, que l’utilisateur fait défiler pour passer au joueur suivant. Il suffisait donc de leur en donner l’apparence, sous la forme d’un rectangle blanc aux coins arrondis.

C’est un motif fréquent pour les interfaces mobiles, parfaitement adapté aux interactions tactiles, et qui s’intègre naturellement au format du smartphone (lui aussi, un rectangle aux coins arrondis). J’ai donc mis chaque score dans un rectangle blanc. J’ai ajouté une ombre portée et un léger dégradé sur le fond pour renforcer subtilement l’impression de relief.

Cette solution me plaît d’autant plus qu’elle est cohérente avec le mode de fonctionnement de l’application (un bel exemple de skeuomorphisme). A posteriori, ça paraît évident.

Je suis moins satisfait par les boutons, qui ne s’intègrent pas vraiment à ce nouveau système de cartes. En haut, les boutons sont des rectangles arrondis. Au-dessous, on trouve des boutons représentés uniquement par des images, sans fond. Enfin, les boutons de score sont des ronds. Cette vue principale intègre donc de nombreux boutons, je dois veiller à ne pas surcharger leur apparence, tout en gardant une certaine hiérarchie visuelle. Pour l’instant, je n’ai pas trouvé de meilleure approche.

Côté programmation, cette disposition relève du casse-tête. Auto Layout est facile à appréhender pour des cas simples, mais la `UIScrollView` complique les choses. Pour l’instant, mon implémentation fonctionne bien sur iPhone en portrait, mais s’étire médiocrement sur iPad.

Dans un autre contexte, j’aurais probablement attendu davantage avant de publier cette version, mais l’opportunité de sortir Games Keeper pour iOS 13 était trop belle. Comme iOS 13, il faudra quelques mises à jour pour corriger ces problèmes. Mais dans l’ensemble, je suis content de cette évolution.

![Games Keeper 3](/blog/img/2019/games-keeper-3/games-keeper-3.png)
