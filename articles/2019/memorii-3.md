Title:     Memorii, le retour  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      February 12, 2019  
Update:     
Keywords:  iOS, app, dev  
Summary:   Memorii est une application de mémorisation de vocabulaire pour l’étude d’une langue étrangère. Elle fonctionne sur le principe des cartes mémoire : on y entre des listes de mots, et l’application fait défiler cette liste de différentes façons pour faire travailler la mémoire.  
Image:     https://www.vtourraine.net/blog/img/2019/memorii-3/memorii-3-screenshots.png  
Language:  fr  


[Memorii](http://itunes.apple.com/fr/app/memorii/id352411168?mt=8) est une application de mémorisation de vocabulaire pour l’étude d’une langue étrangère. Elle fonctionne sur le principe des cartes mémoire (ou _flash cards_) : on y entre des listes de mots, et l’application fait défiler cette liste de différentes façons pour faire travailler la mémoire.

![Memorii 2 (dernière mise à jour en 2011)](/blog/img/2019/memorii-3/memorii-2-screenshots.png)

J’avais initialement développé cette application, comme c’est souvent le cas, pour ma propre utilisation. Elle était conçue sur mesure pour mes cours de langues étrangères en école d’ingénieur, et je l’utilisais quotidiennement. C’était une de mes premières applications, publiée en 2010 sur l’App Store. 9 ans déjà.

Développer une application pour ses propres besoins a beaucoup d’avantages, mais le corollaire est moins reluisant. Depuis que je ne l’utilisais plus pour moi-même, je ne la mettais plus à jour.

## Grand nettoyage de l’App Store

L’App Store contient tellement d’applications (environ 2 millions) que ça en devient un problème. Depuis quelques années, Apple essaie d’entretenir plus agressivement son catalogue.

Un critère en particulier est venu balayer un grand nombre d’applications : le passage au 64-bit. Cette décision controversée repose sur des motivations techniques (simplification et optimisation du système), et permet par la même occasion à Apple de se débarasser des projets abandonnés.

Depuis iOS 11, il est donc impossible de lancer une application compilée en 32-bit (c’est à dire généralement pré-Xcode 5, datant de 2013). Memorii, qui n’avait pas été mis à jour depuis 2011, était concerné.

Dans cette même logique, Apple a maintenant décidé de retirer de l’App Store toutes les applications concernées. Cette nouvelle décision affecte donc les personnes qui continuent de se connecter à l’App Store avec iOS 10, ou plus ancien. Le pourcentage d’utilisateurs concernés est évidemment faible, mais symboliquement, cette disparition totale de Memorii de l’App Store me faisait quelque chose.

## Réécriture Swift

Il fallait donc actualiser le projet. Le code pouvait compiler sans trop de difficultés avec la dernière version d’Xcode, mais les concepts d’interface avaient trop changé. Pas de _size class_, pas d’Auto Layout, les vues pour iPad étaient traitées séparément avec `UI_USER_INTERFACE_IDIOM()`, les cadres fixés à coups de `CGRectMake()` et de _resizing mask_, sans oublier le bon vieux `didRotateFromInterfaceOrientation:`.

Repartir de zéro est généralement une mauvaise idée, mais dans cette situation, je pense que la réécriture totale était la solution la moins pire.

C’était aussi l’occasion parfaite pour écrire la nouvelle version avec Swift. Je me sens toujours plus à l’aise avec Objective-C, mais j’apprécie davantage Swift. Pour un projet existant, il est techniquement possible de mélanger les deux langages. Mais dans la pratique, je trouve que passer constamment de l’un à l’autre demande un effort mental supplémentaire. Pour les projets existants, j’en reste donc à Objective-C. Pour les nouveaux, je suis ravi de passer à Swift.


## Simplification

L’idée de reprendre le projet pour le moderniser était forcément intéressante mais, à terme, cette expérience ne sera vraiment satisfaisante que si je continue à le tenir à jour. Pour faciliter la maintenance de l’application, je voulais donc simplifier certaines fonctionnalités.

Le changement principal concerne l’aplatissement du modèle : l’organisation des mots passe d’une structure configurable à multiples niveaux (possibilité de créer autant de sous-dossiers qu’on le souhaite) à une gestion à un seul niveau (des dossiers de mots à la racine, et c’est tout).

Pour l’écran de défilement des mots (là où on étudie les mots enregistrés), j’utilisais précédemment une `UIScrollView` avec pagination. Cette approche fonctionne parfaitement en théorie, mais pose des problèmes de gestion de la mémoire dès que le nombre de mots à afficher augmente. Pour simplifier, donc, il s’agit maintenant d’une vue statique avec trois labels et des `UISwipeGestureRecognizer` pour passer d’un mot à l’autre. Le résultat est ergonomiquement moins plaisant, mais le code est nettement plus simple.

J’ai aussi retiré quelques fonctionnalités secondaires, telles que le mode aléatoire, la recherche et les options d’export. Avec un peu de motivation, je pourrais toujours les rajouter dans une future mise à jour.

Et oui, comme vous pouvez le constater sur les captures d’écran avant/après, le fond jaune est parti.

Au final, le projet passe de cinquante classes dans sa version Objective-C (donc le double de fichiers, `.h` et `.m`), à quinze classes pour la version Swift, tout en conservant l’essentiel de ses fonctionnalités. Simplicité, efficacité.

![Memorii 3](/blog/img/2019/memorii-3/memorii-3-screenshots.png)

Memorii est donc à nouveau [disponible sur l’App Store](http://itunes.apple.com/fr/app/memorii/id352411168?mt=8), et j’en suis ravi.
