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

<p>Arrivés avec Xcode 4, les workspaces vous permettent de gérer plusieurs projets simultanément. Voyons comment mettre en place cet outil afin d’utiliser efficacement une bibliothèque ou un framework tiers.</p>

<h2>Introduction</h2>
<p>
	Le passage à Xcode 4 est un changement important pour les développeurs OS X et iOS, avec une refonte totale du logiciel qui n'a pas laissé indifférent, comme on pouvait s'y attendre.
</p>
<div class="slideshow">
	<img src="img/xcode-4-workspaces/xcode-icon.png" class="nostyle" alt="Xcode icon" />
</div>
<p>
	Passés relativement inaperçus, les workspaces sont une des grandes nouveautés d'Xcode 4. Il s'agit d'étendre le concept de projet pour pouvoir travailler sur plusieurs "<em>.xcodeproj</em>" au sein d'une même session. Plus concrètement, un workspace vous permet de rassembler plusieurs projets liés entre eux, pour mieux les coordonner.
</p>
<p>
	Généralement, ce type de besoin arrive lorsque votre projet principal, donc votre application, utilise des bibliothèques ou des frameworks tiers, qui sont eux-même distribués comme des projets "<em>.xcodeproj</em>".
</p>
<p>
	Prenons donc l'exemple d'une bibliothèque classique (ici <a href="https://github.com/pivotal/cedar">Cedar</a>, pour la mise en place de tests orientés BDD), et voyons comment l'utiliser au sein d'un workspace.
</p>

<h2>Exemple de mise en place</h2>
<h3>Création du workspace</h3>
<p>
	Commencez par glisser le dossier "<em>.xcodeproj</em>" de la bibliothèque depuis une fenêtre Xcode ou depuis le Finder, et déposez-le à la racine (donc au même niveau que votre project principal) de votre "<em>project navigator</em>". Xcode comprend alors que vous souhaitez utiliser un workspace, il vous proposera donc la première fois de l'enregistrer explicitement dans ce nouvel état (à vous de choisir le nom et l'emplacement).
</p>
<div class="slideshow">
	<img src="img/xcode-4-workspaces/project-navigator.png" alt="Xcode project navigator" />
</div>
<p>
	Attention : un projet ne peut pas être ouvert plusieurs fois simultanément. Si c'est le cas, Xcode refusera d'en déplier le contenu dans le "<em>project navigator</em>". Fermez simplement toutes les autres fenêtres pour le rendre à nouveau disponible.
</p>
<h3>Bibliothèque statique</h3>
<p>
	Dans l'inspecteur de votre projet, vous pouvez maintenant ajouter la bibliothèque en question, comme pour un framework classique ("<em>Build Phases</em>"/"<em>Link Binary With Libraries</em>"). Choisissez de préférence la bibliothèque statique (<em>.a</em>), en particulier pour un projet iOS.
</p>
<div class="slideshow">
	<img src="img/xcode-4-workspaces/link-binaries.png" alt="Xcode link binary" />
</div>
<p>
	La bibliothèque apparaît alors en rouge dans le navigateur (fichier introuvable), car elle sera créée seulement au moment de la compilation, dans le dossier "<em>Build</em>" commun au workspace.
</p>
<p>
	Voilà, la bibliothèque est presque prête.
</p>
<h3>Fichiers entêtes</h3>
<p>
	Pour pouvoir utiliser notre bibliothèque, il ne reste plus qu'à indiquer à Xcode le chemin vers les fichiers d'entêtes (<em>.h</em>).
</p>
<p>
	Dans l'inspecteur de votre target principale, retrouvez l'option "<em>Build Settings</em>"/"<em>User Header Search Paths</em>", et ajoutez-y le chemin du dossier contenant les entêtes ("<em>Headers</em>") du projet tiers. Je vous conseille au passage d'utiliser la variable "<em>$(PROJECT_DIR)</em>" pour indiquer un chemin relatif.
</p>
<p>
	Dans notre cas :
</p>
<code>
	$(PROJECT_DIR)/Frameworks/Cedar/Source/Headers
</code>
<p>
Attention : "<em>User Header Search Paths</em>" correspond aux commandes '<em>#import "xxx.h"</em>', alors que "<em>Header Search Paths</em>" est utilisé pour les '<em>#import &lt;xxx.h&gt;</em>'. Choisissez l'option qui correspond à votre bibliothèque (il vous suffit de jeter un œil aux entêtes), en activant si besoin l'option "<em>recursive</em>".
</p>
<p>
	Vous pouvez maintenant utiliser la bibliothèque normalement. Mais les choses peuvent parfois se compliquer.
</p>
<h3>Inclusion des bundles</h3>
<p>
	Certaines bibliothèques sont accompagnées de "<em>.bundle</em>", généralement pour inclure des images, ou d'autres ressources statiques. Ces fichiers ne sont pas inclus automatiquement. Pour qu'ils soient accessibles, il faut donc les ajouter à notre projet.
</p>
<p>
	Pour cela, glissez le "<em>.bundle</em>" depuis le projet tiers ou depuis le Finder, et déposez-le dans votre "<em>project navigator</em>". Choisissez bien sûr l'ajout par référence afin de ne rien dupliquer.
</p>

<h2>Quels avantages ?</h2>
<p>
Notre workspace est donc maintenant correctement configuré, mais quel est l'intérêt d'une méthode aussi fastidieuse (oui, c'est même un peu pénible à mettre en place) ?
</p>
<h3>Git (submodule)</h3>
<p>
	La grande majorité des bibliothèques sont aujourd'hui hébergées sur <a href="http://www.github.com">github.com</a>. Cela signifie que pouvez directement les copier pour votre projet, en une seule ligne de commande.
</p>
<p>
	Il vous faudra un repository git déjà initialisé, et voilà qui tombe bien, Xcode 4 propose justement de s'en occuper à la création d'un projet.
</p>
<div class="slideshow">
	<img src="img/xcode-4-workspaces/create-project-git.jpg" alt="Xcode git" />
</div>
<p>
	Vous pouvez maintenant utiliser le Terminal, en vous plaçant dans le répertoire du projet, et saisir la commande suivante :
</p>
<code>
	git submodule add git://github.com/pivotal/cedar.git Frameworks/Cedar
</code>
<p>
	Je ne vais pas entrer dans les détails, l'utilisation de git est un sujet qui dépasse largement le périmètre de ce billet. Ce qu'il faut retenir ici, c'est qu'on peut gérer ses bibliothèques sans les modifier, simplement en reprenant les repositories mis à disposition. Cela vous permettra de faire évoluer le projet par la suite, sans jamais perdre la trace des sources utilisées.
</p>
<h3>Intégration continue</h3>
<p>
	Les workspaces permettent également à leur manière la mise en place d'un environnement d'intégration continue. Il est en effet possible de compiler votre code directement en ligne de commande, et donc d'automatiser la compilation, le test et le déploiement de votre application.
</p>
<p>
	Pour préciser les dépendances entre projets, nous utilisons les "schemes", une autre nouveauté d'Xcode 4.
</p>
<p>
	Cliquez sur le nom du scheme actif (en haut à gauche), puis sur "<em>Edit Scheme...</em>". Dans l'onglet "<em>Build</em>", vous allez pouvoir ajouter la bibliothèque statique (<em>.a</em>) du projet tiers. Déplacez-la en première position pour respecter l'ordre de compilation.
</p>
<div class="slideshow">
	<img src="img/xcode-4-workspaces/scheme.jpg" alt="Xcode scheme" />
</div>
<p>
	Avec ce couple workspace/scheme, la compilation est parfaitement maîtrisée. Nous allons pouvoir utiliser la commande "<em>xcodebuild</em>", en réutilisant donc la configuration ainsi établie.
</p>
<code>
	xcodebuild -workspace Contacts.xcworkspace -scheme ContactsTests
</code>
<p>
	Cette commande devrait suffire à construire votre application, en gérant toutes les bibliothèques associées. Plutôt pratique.
</p>

<h2>Conclusion</h2>
<p>
	Comme vous le voyez, le processus est assez pénible, loin des promesses d'Xcode 4 ("dépendances gérées automatiquement", je préfère en rire). Pour autant, les avantages sont réels et peuvent largement compenser la lourdeur de la mise en place, selon la nature du projet concerné.
</p>
<p>
	Si vous utilisez une technique similaire en réglant les problèmes évoqués ici, ça m'intéressait beaucoup d'en savoir plus. En espérant qu'une prochaine version d'Xcode améliore un peu tout ça.
</p>