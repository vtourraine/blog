Title:    Les Workspaces avec Xcode 4  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     January 23, 2012  
Update:   
Keywords: Tutoriel, Xcode, Workspace, iOS, OS X, projet, frameworks, Cedar  
Summary:  Arrivés avec Xcode 4, les workspaces vous permettent de gérer plusieurs projets simultanément. Voyons comment mettre en place cet outil afin d’utiliser efficacement une bibliothèque ou un framework tiers.  
Image:    http://www.vtourraine.net/blog/img/xcode-4-workspaces/xcode-4-workspaces.png  
Language: fr  
Project:  

Arrivés avec Xcode 4, les workspaces vous permettent de gérer plusieurs projets simultanément. Voyons comment mettre en place cet outil afin d’utiliser efficacement une bibliothèque ou un framework tiers.


## Introduction

Le passage à Xcode 4 est un changement important pour les développeurs OS X et iOS, avec une refonte totale du logiciel qui n'a pas laissé indifférent, comme on pouvait s'y attendre.

![Icône Xcode, Apple][Icone Xcode]

Passés relativement inaperçus, les workspaces sont une des grandes nouveautés d'Xcode 4. Il s'agit d'étendre le concept de projet pour pouvoir travailler sur plusieurs `.xcodeproj` au sein d'une même session. Plus concrètement, un workspace vous permet de rassembler plusieurs projets liés entre eux, pour mieux les coordonner.

Généralement, ce type de besoin arrive lorsque votre projet principal, donc votre application, utilise des bibliothèques ou des frameworks tiers, qui sont eux-même distribués comme des projets `.xcodeproj`.

Prenons donc l'exemple d'une bibliothèque classique (ici [Cedar](https://github.com/pivotal/cedar), pour la mise en place de tests orientés BDD), et voyons comment l'utiliser au sein d'un workspace.


## Exemple de mise en place

### Création du workspace

Commencez par glisser le dossier `.xcodeproj` de la bibliothèque depuis une fenêtre Xcode ou depuis le Finder, et déposez-le à la racine (donc au même niveau que votre project principal) de votre « project navigator ». Xcode comprend alors que vous souhaitez utiliser un workspace, il vous proposera donc la première fois de l'enregistrer explicitement dans ce nouvel état (à vous de choisir le nom et l'emplacement).

![Xcode : project navigator][Xcode project]

Attention : un projet ne peut pas être ouvert plusieurs fois simultanément. Si c'est le cas, Xcode refusera d'en déplier le contenu dans le « project navigator ». Fermez simplement toutes les autres fenêtres pour le rendre à nouveau disponible.


### Bibliothèque statique

Dans l'inspecteur de votre projet, vous pouvez maintenant ajouter la bibliothèque en question, comme pour un framework classique (« Build Phases »/« Link Binary With Libraries »). Choisissez de préférence la bibliothèque statique (`.a`), en particulier pour un projet iOS.

![Xcode : link binary][Link binaries]

La bibliothèque apparaît alors en rouge dans le navigateur (fichier introuvable), car elle sera créée seulement au moment de la compilation, dans le dossier « Build » commun au workspace.

Voilà, la bibliothèque est presque prête.


### Fichiers entêtes

Pour pouvoir utiliser notre bibliothèque, il ne reste plus qu'à indiquer à Xcode le chemin vers les fichiers d'entêtes (`.h`).

Dans l'inspecteur de votre target principale, retrouvez l'option « Build Settings »/« User Header Search Paths », et ajoutez-y le chemin du dossier contenant les entêtes (« Headers ») du projet tiers. Je vous conseille au passage d'utiliser la variable `$(PROJECT_DIR)` pour indiquer un chemin relatif.

Dans notre cas :

```
$(PROJECT_DIR)/Frameworks/Cedar/Source/Headers
```

Attention : « User Header Search Paths » correspond aux commandes `#import "xxx.h"`, alors que « Header Search Paths » est utilisé pour les `#import <xxx.h>`. Choisissez l'option qui correspond à votre bibliothèque (il vous suffit de jeter un œil aux entêtes), en activant si besoin l'option « recursive ».

Vous pouvez maintenant utiliser la bibliothèque normalement. Mais les choses peuvent parfois se compliquer.


### Inclusion des bundles

Certaines bibliothèques sont accompagnées de `.bundle`, généralement pour inclure des images, ou d'autres ressources statiques. Ces fichiers ne sont pas inclus automatiquement. Pour qu'ils soient accessibles, il faut donc les ajouter à notre projet.

Pour cela, glissez le `.bundle` depuis le projet tiers ou depuis le Finder, et déposez-le dans votre « project navigator ». Choisissez bien sûr l'ajout par référence afin de ne rien dupliquer.


## Quels avantages ?

Notre workspace est donc maintenant correctement configuré, mais quel est l'intérêt d'une méthode aussi fastidieuse (oui, c'est même un peu pénible à mettre en place) ?


### Git (submodule)

La grande majorité des bibliothèques sont aujourd'hui hébergées sur [GitHub](http://www.github.com). Cela signifie que pouvez directement les copier pour votre projet, en une seule ligne de commande.

Il vous faudra un repository git déjà initialisé, et voilà qui tombe bien, Xcode 4 propose justement de s'en occuper à la création d'un projet.

![Xcode : create project with Git][Create project]

Vous pouvez maintenant utiliser le Terminal, en vous plaçant dans le répertoire du projet, et saisir la commande suivante :

```
git submodule add git://github.com/pivotal/cedar.git Frameworks/Cedar
```

Je ne vais pas entrer dans les détails, l'utilisation de git est un sujet qui dépasse largement le périmètre de ce billet. Ce qu'il faut retenir ici, c'est qu'on peut gérer ses bibliothèques sans les modifier, simplement en reprenant les repositories mis à disposition. Cela vous permettra de faire évoluer le projet par la suite, sans jamais perdre la trace des sources utilisées.


### Intégration continue

Les workspaces permettent également à leur manière la mise en place d'un environnement d'intégration continue. Il est en effet possible de compiler votre code directement en ligne de commande, et donc d'automatiser la compilation, le test et le déploiement de votre application.

Pour préciser les dépendances entre projets, nous utilisons les "schemes", une autre nouveauté d'Xcode 4.

Cliquez sur le nom du scheme actif (en haut à gauche), puis sur « Edit Scheme... ». Dans l'onglet « Build », vous allez pouvoir ajouter la bibliothèque statique `.a`) du projet tiers. Déplacez-la en première position pour respecter l'ordre de compilation.

![Xcode : Scheme][Scheme]

Avec ce couple workspace/scheme, la compilation est parfaitement maîtrisée. Nous allons pouvoir utiliser la commande `xcodebuild`, en réutilisant donc la configuration ainsi établie.

```
xcodebuild -workspace Contacts.xcworkspace -scheme ContactsTests
```

Cette commande devrait suffire à construire votre application, en gérant toutes les bibliothèques associées. Plutôt pratique.


## Conclusion

Comme vous le voyez, le processus est assez pénible, loin des promesses d'Xcode 4 ("dépendances gérées automatiquement", je préfère en rire). Pour autant, les avantages sont réels et peuvent largement compenser la lourdeur de la mise en place, selon la nature du projet concerné.

Si vous utilisez une technique similaire en réglant les problèmes évoqués ici, ça m'intéressait beaucoup d'en savoir plus. En espérant qu'une prochaine version d'Xcode améliore un peu tout ça.


[Icone Xcode]:    http://www.vtourraine.net/blog/img/xcode-4-workspaces/xcode-icon.png
[Xcode project]:  http://www.vtourraine.net/blog/img/xcode-4-workspaces/project-navigator.png
[Link binaries]:  http://www.vtourraine.net/blog/img/xcode-4-workspaces/link-binaries.png
[Create project]: http://www.vtourraine.net/blog/img/xcode-4-workspaces/create-project-git.jpg
[Scheme]:         http://www.vtourraine.net/blog/img/xcode-4-workspaces/scheme.jpg
