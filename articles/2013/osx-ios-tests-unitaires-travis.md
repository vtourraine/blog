Title:    Intégration continue OS X et iOS avec Travis CI  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     May 06, 2013  
Update:   
Keywords: OS X, iOS, Objective-C, TDD, Travis  
Summary:  Il faut savoir regarder la vérité en face : les projets OS X et surtout iOS incluant des tests unitaires sont plutôt rares. Les contraintes techniques entourant les plateformes d’Apple compliquent leur intégration, et donc leur mise en œuvre. Mais rassurez-vous, les choses s’améliorent.  
Image:    http://www.vtourraine.net/blog/img/osx-ios-tests-unitaires-travis/travis.png  
Language: fr  
Project:  

<p>Il faut savoir regarder la vérité en face : les projets OS X et surtout iOS incluant des tests unitaires sont plutôt rares. Les contraintes techniques entourant les plateformes d’Apple compliquent leur intégration, et donc leur mise en œuvre. Mais rassurez-vous, les choses s’améliorent.</p>

<p>Travis CI est une plateforme d’intégration continue hébergée, Open Source, et gratuite. <a href="http://about.travis-ci.org/blog/introducing-mac-ios-rubymotion-testing/" title="http://about.travis-ci.org/blog/introducing-mac-ios-rubymotion-testing/">Depuis un mois</a>, elle propose aussi la prise en charge des projets OS X et iOS (ainsi que RubyMotion). Il vous suffit d’une simple ligne de configuration dans votre projet pour en bénéficier. C’est assez génial.</p>

<div class="slideshow">
	<img src="http://www.vtourraine.net/blog/img/osx-ios-tests-unitaires-travis/travis.png" alt="Travis CI logo" class="nostyle" />
</div>

<h2>Marche à suivre</h2>

<p>Prenons donc un projet bénéficiant de tests unitaires. Petit rappel : Xcode vous propose d’ajouter une target de tests à la création d’un projet, mais vous pouvez bien sûr aussi en ajouter a posteriori.</p>

<p>Tout ceci est intéressant, mais je vous ai promis une configuration en une seule ligne de code. Chose promise, chose due. À la racine de votre projet, créez simplement un fichier nommé <code>.travis.yml</code>, avec pour contenu <code>language: objective-c</code>. Et voilà !</p>

<p>Une fois votre projet hébergé publiquement sur GitHub, vous pourrez vous identifier sur <a href="http://travis-ci.org" title="http://travis-ci.org">travis-ci.org</a> (avec votre compte GitHub justement), et y spécifier le repository en question (a.k.a. “turn on the Travis service hook”). Le tour est joué, les tests seront maintenant exécutés automatiquement pour chaque nouvelle version du code.</p>

<h2>Configurons un peu</h2>

<p>Par défaut, sans aucune information supplémentaire, Travis se charge de lancer les tests automatiquement à l’aide d’un <a href="https://github.com/jspahrsummers/objc-build-scripts" title="https://github.com/jspahrsummers/objc-build-scripts">script</a> générique. Il est bien sûr possible, et souvent nécessaire, de personnaliser un peu cette configuration de base.</p>

<p>Nous allons utiliser une ligne de commande pour exécuter ces tests, à l’aide d’un outil fourni avec Xcode qui s’appelle <a href="https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/xcodebuild.1.html" title="https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/xcodebuild.1.html">“xcodebuild”</a>. Si vous utilisez un projet (<code>.xcodeproj</code>), vous pouvez alors lui adresser directement la target concernée.</p>

<p>Si vous utilisez un workspace (<code>.xcworkspace</code>), en revanche, il vous faudra donner le nom du scheme, et non pas celui de la target. Cette différence est compréhensible, puisque la particularité d’un workspace consiste justement à configurer une ou plusieurs targets de test. Pour les détails, je vous renvoie vers la <a href="http://developer.apple.com/library/mac/#documentation/developertools/Conceptual/UnitTesting/04-Configuring_a_Scheme_to_Run_Unit_Tests/scheme.html" title="http://developer.apple.com/library/mac/#documentation/developertools/Conceptual/UnitTesting/04-Configuring_a_Scheme_to_Run_Unit_Tests/scheme.html">documentation d’Xcode</a>. Attention au passage : les schemes ne sont pas partagés par défaut, et donc exclus de votre gestionnaire de versions. Pensez à cocher la case “Shared” dans la vue de configuration.</p>

<p>Vous avez au moins une bonne raison d’utiliser un workspace : <a href="http://cocoapods.org" title="http://cocoapods.org">CocoaPods</a>. Encore un sujet qui mériterait un billet dédié, mais pour expliquer brièvement, il s’agit d’un outil de gestion de dépendances pour vos projets OS X et iOS. Un outil tellement génial qu’il se retrouve installé par défaut sur les machines virtuelles Travis. Mieux : le fameux <code>pod install</code> nécessaire à résolution des dépendances est lancé automatiquement lorsqu’un projet utilise CocoaPods.</p>

<p>À partir de là, tout est possible pour personnaliser l’exécution de vos tests. Le fichier <code>.travis.yml</code> déjà créé peut contenir des instructions qui seront exécutées afin de lancer les tests. Vous pouvez également invoquer un fichier script dédié, comme le <a href="https://github.com/dulaccc/DPMeterView/blob/master/Makefile" title="https://github.com/dulaccc/DPMeterView/blob/master/Makefile">Makefile</a> donné en exemple par Travis.</p>

<h2>À propos d’iOS</h2>

<p>Tout ceci fonctionne à merveille pour des applications OS X. En ce qui concerne iOS, la situation est un peu plus compliquée.</p>

<p>Les outils mis à disposition par Apple nécessitent l’utilisation du Simulateur pour exécuter une série de tests. Ce n’est pas un problème lorsque vous utilisez votre poste de travail classique, mais c’en est un lorsqu’il s’agit de machines virtuelles souhaitant opérer en mode headless.</p>

<p>Il existe plusieurs moyens pour contourner ce problème. On trouve notamment des projets comme <a href="https://github.com/phonegap/ios-sim" title="https://github.com/phonegap/ios-sim">ios-sim</a>, qui permettent justement de lancer un simulateur depuis une ligne de commande, avec certains paramètres qui ne sont pas proposés avec les outils officiels. Vous pouvez prendre exemple sur le projet <a href="https://travis-ci.org/jpsim/LetterpressPlayer" title="https://travis-ci.org/jpsim/LetterpressPlayer">LetterpressPlayer</a>, configuré pour Travis et qui utilise justement ios-sim pour ses tests.</p>

<p>Ce genre de mécanisme n’étant pas supporté par Apple, il demande un certain effort de maintenance, puisque chaque mise à jour d’Xcode peut entraîner une incompatibilité des programmes concernés.</p>

<p>Dans la mesure du possible, je préfère donc restreindre les tests unitaires pour un projet iOS au modèle et à une partie des contrôleurs (cf. MVC) pouvant être inclus et exécutés depuis une application OS X. Concrètement, ne pas tester l’interface, et se concentrer sur la fameuse “logique métier”. Il est difficile de tester efficacement les vues d’une application, et encore plus un contexte d’exécution et d’enchainement de ces vues. Il me semble donc plus judicieux et plus efficace dans la plupart des cas d’utiliser un second projet de type OS X, testant le code utilisé pour l’application iOS. Dans ces conditions, les outils standards d’Apple fonctionnent parfaitement. À vous de choisir entre une (supposée) couverture à 100%, et la stabilité d’exécution des tests. Non, les tests ne sont pas une finalité, mais oui, ils peuvent vous faire gagner du temps.</p>