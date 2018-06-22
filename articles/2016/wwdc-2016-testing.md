Title:     Test et Intégration Continue, WWDC 2016  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 18, 2016  
Update:    
Keywords:  WWDC, unit test   
Summary:   Dans le cadre de la WWDC 2016, voici un compte-rendu de la session « Advanced Testing and Continuous Integration ». Des informations trop renversantes pour être mentionnées lors du keynote, accrochez-vous bien.  
Image:     https://www.vtourraine.net/blog/img/2016/wwdc-2016-testing/409-1-summary.png  
Thumbnail: https://www.vtourraine.net/blog/img/2016/wwdc-2016-testing/thumbnail-wwdc-2016-testing.jpg  
Language:  fr  


Dans le cadre de la WWDC 2016, voici un compte-rendu de la session _Advanced Testing and Continuous Integration_. Des informations trop renversantes pour être mentionnées lors du keynote, accrochez-vous bien.

Vous pouvez bien sûr retrouver la vidéo, les slides, et la documentation associée sur le site [developer.apple.com](https://developer.apple.com/wwdc16/409) (accessibles à tous).


## Testing concepts

On commence avec une longue introduction au test et à l’intégration continue avec Xcode. Pour une session qui se veut « advanced », c’est un peu surprenant ; mais comme il s’agit de l’unique session sur le sujet cette année, c’est sans doute une bonne idée. 

![Extrait WWDC 2016 – session 409, image Apple](/blog/img/2016/wwdc-2016-testing/409-1-summary.png)

L’occasion de (re)présenter Xcode Server avec Xcode Bot, la solution d’intégration continue présentée en 2015, qui s’exécute sur un Mac équipé de macOS Server, et se pilote depuis Xcode. On mentionne également UI Testing pour les tests d’interface, la nouveauté la plus marquante de l’année passée.

Il est également question de `XCTestObservation`, un protocol pour suivre le déroulement des tests. Je n’avais jamais rencontré cette fonctionnalité, et à moins d’écrire un framework de tests au-dessus de XCTest, je ne suis pas sûr d’en saisir l’utilité. On reproche parfois au framework de test d’Xcode d’être trop rigide, au moins il s’agit là d’un bon contre-exemple.

Jusqu’ici, rien de nouveau, mais c’est toujours intéressant de résumer le contenu des années passées.


## Crash logs

Enfin une nouveauté : Xcode 8 prend mieux en charge les crash logs provenant du déroulement des tests. On peut maintenant les retrouver dans le rapport de test et dans le « Debug Navigator », pour les tests locaux et pour Xcode Bot. Une excellente nouvelle.

![Extrait WWDC 2016 – session 409, image Apple](/blog/img/2016/wwdc-2016-testing/409-2-crash-logs.png)


## Xcode Server

Quelques améliorations pour Xcode Server, avec des options supplémentaires concernant l’envoi des mails d’alerte. Le contenu des mails est également revu (supposément plus intelligent, pour identifier les personnes responsables au-delà d’un simple `blame`).

![Extrait WWDC 2016 – session 409, image Apple](/blog/img/2016/wwdc-2016-testing/409-3-triggers.png)

Plus intéressant, le rapport de test mettra maintenant en évidence les changements de configuration. Par exemple si vous modifiez le deployment target de votre projet, Xcode affichera clairement ce changement pour mieux contextualiser cette intégration. Encore une excellente idée.

![Extrait WWDC 2016 – session 409, image Apple](/blog/img/2016/wwdc-2016-testing/409-4-upgrade.png)


## Testing user

Xcode Server a toujours exécuté les tests avec un compte utilisateur dédié. Jusque là, cet utilisateur était géré de façon automatique, et il était impossible d’intéragir avec. Nouveauté Xcode 8 : cet utilisateur est maintenant éditable, et peut également être utilisé comme n’importe quel compte. On peut donc se logger avec cet utilisateur, modifier n’importe quelle configuration, et avoir ces changements appliqués aux tests.

![Extrait WWDC 2016 – session 409, image Apple](/blog/img/2016/wwdc-2016-testing/409-5-testing-user.png)

Apple a donné un exemple intéressant. On peut ainsi dupliquer le « device » du simulateur tvOS, et désactiver les services de localisation pour l’un des deux. De cette manière, on peut écrire deux suites de tests, une avec les services actifs, l’autre sans.

C’est donc une amélioration incontestablement utile. Malheureusement, il semble que ce genre de problème devrait être réglé de façon plus systématique (dans ce cas précis, avec un paramétrage des simulateurs). Le contrôle de l’utilisateur de test peut évidemment être utile pour des situations très différentes. Là aussi, il s’agit donc de donner plus de flexibilité aux outils de test.


## xcodebuild

Impossible de parler de test avec Xcode sans évoquer `xcodebuild`. Encore une fois, Apple a ajouté quelques options bienvenues.

Avec `-only-testing`, il est possible de se limiter à un bundle, à une suite, ou à un test case particulier (ou une combinaison des trois). À l’inverse, `-skip-testing` permet d’omettre certains tests.

![Extrait WWDC 2016 – session 409, image Apple](/blog/img/2016/wwdc-2016-testing/409-6-test-options.png)

Toujours plus fort, il est maintenant possible de compiler pour les tests sans tester (`build-for-testing`), ou de tester sans compiler (`test-without-building`). La première opération génère un nouveau fichier `xctestrun`, qui transmet les paramètres de test pour la seconde. 

![Extrait WWDC 2016 – session 409, image Apple](/blog/img/2016/wwdc-2016-testing/409-7-xcodebuild.png)

Aucun doute, il s’agit bien là d’« advanced testing ». Ce genre de manipulation correspond à une utilisation très poussée d’Xcode. Pour la grande majorité des projets, le mode de fonctionnement standard d’Xcode Server est amplement suffisant. Mais on sait bien que l’intégration continue peut être mise en place dans des contextes très variés, et dans ces cas Xcode 8 apporte des améliorations significatives.


## Bilan

Apple propose habituellement une session chaque année traitant des tests unitaires et de l’intégration continue. Ce n’est pas le sujet le plus populaire de la conférence, mais ça ne les empêche pas de présenter des nouveautés intéressantes.

Cette année, je trouve que les annonces sont plutôt décevantes. Des ajouts appréciables, mais rien de très enthousiasmant. Ce n’est pas forcément une mauvaise chose. Les outils actuels sont bien conçus, mais ils manquent de stabilité. UI Testing, en particulier, produit trop souvent des résultats apparemment aléatoires, ce qui n’est jamais souhaitable pour un framework de test.

Il faudra utiliser Xcode 8 sur la longueur pour voir si cette mise-à-jour gagne en robustesse. Apple n’a pas évoqué ce genre d’améliorations lors de cette session, ce qui est légèrement préoccupant, mais chaque année apporte son lot de corrections de bugs.

Pour l’année prochaine, j’aimerais beaucoup voir une intégration spécifique des repos GitHub, avec gestion des branchs et pull-requests. Et n’oublions pas qu’Xcode 8 propose maintenant une interface officielle pour les plugins. Très limitée pour l’instant, mais une bonne occasion pour supporter davantage de fonctionnalités.
