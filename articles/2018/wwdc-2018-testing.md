Title:     WWDC 2018 : test d’applications  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 22, 2018  
Update:    
Keywords:  dev, iOS, Xcode, unit test  
Summary:   Doucement mais sûrement, Apple améliore ses outils pour le « testing » des applications (tests unitaires, intégration continue, etc). Voici le compte-rendu de la session « WWDC 2018 - What’s New in Testing », avec tous les changements apportés cette année.  
Image:     https://www.vtourraine.net/blog/img/2018/wwdc-2018-testing/6-parallel-testing.jpg  
Language:  fr  


Doucement mais sûrement, Apple améliore ses outils pour le « testing » des applications (tests unitaires, intégration continue, etc). Voici le compte-rendu de la session [_WWDC 2018 - What’s New in Testing_](https://developer.apple.com/wwdc18/403), avec tous les changements apportés cette année.

## Couverture de code
On commence avec des améliorations concernant la couverture de code (code coverage). Ces nouveautés faisaient partie d’Xcode 9.3, elles sont donc déjà disponibles depuis quelques mois.

![Couverture de code - WWDC 2018 session 403, image Apple](/blog/img/2018/wwdc-2018-testing/4-show-coverage.jpg)

- Performances : amélioration notable pour le temps de chargement et la taille des fichiers concernés
- Précision : meilleure représentation du code couvert, en particulier pour les fichiers d’en-tête (`.h`)

On trouve aussi une nouvelle option dans le scheme editor : la possibilité de sélectionner quelles targets au sein du projet sont concernées par la couverture de code.

![Sélection des targets - WWDC 2018 session 403, image Apple](/blog/img/2018/wwdc-2018-testing/1-xcode-target-selection.jpg)

Concernant la couverture de code, `xccov` est sans doute la nouveauté la plus intéressante. Il s’agit d’un nouvel outil en ligne de commande, avec la possibilité de générer des rapports au format texte et au format JSON. Ces rapports incluent le pourcentage de couverture par target, par fichier et par fonction, ainsi que les nombres d’exécution pour chaque fichier. Xcode offrait déjà un bon affichage de la couverture de code, mais la possibilité d’intégrer ces données avec des outils tiers est particulièrement intéressante, surtout concernant l’intégration continue (bonjour Jenkins ?).

![Produits xccov - WWDC 2018 session 403, image Apple](/blog/img/2018/wwdc-2018-testing/2-coverage-data)

![Résultat xccov - WWDC 2018 session 403, image Apple](/blog/img/2018/wwdc-2018-testing/3-xcrun.jpg)

## Sélection des tests
La sélection des tests permet de maintenir, pour chaque scheme, la liste des tests à exécuter. Par défaut, il s’agit de tous les tests de la target, mais on peut imaginer un scheme testant uniquement une partie de l’application, ou ignorant les tests de performances. Tout ça dans l’objectif d’accélérer l’exécution des tests, notamment lorsque les tests sont trop nombreux et/ou trop lents pour un certain cycle de développement.

Ce qui est nouveau avec Xcode 10, c’est de pouvoir passer l’ajout des tests en opt-in, au niveau du scheme. Une fois l’option activée, les nouveaux tests ne seront plus sélectionnés par défaut. Rien de renversant, mais je suppose que cette option était réclamée par certaines équipes. 

## Ordre des tests
L’autre nouveauté, beaucoup plus intéressante à mon avis, permet désormais d’exécuter les tests dans un ordre aléatoire. Jusqu’à present, ils étaient toujours exécutés par ordre alphabétique (par classe de test).

Dans un monde idéal, les tests unitaires sont indépendants, et leur ordre n’a aucune incidence sur leur résultat. Dans la pratique, les choses sont évidemment plus compliquées. Ce mode aléatoire devrait donc aider à découvrir les tests problématiques. Cet ordre change bien sûr à chaque fois que les tests sont lancés, ce qui pourra aussi apporter une certaine confusion, lorsque la dépendance entre deux tests n’est pas évidente.

Vous trouverez ces nouvelles options dans le scheme editor.

![Options du scheme editor - WWDC 2018 session 403, image Apple](/blog/img/2018/wwdc-2018-testing/5-xcode-scheme-options.jpg)

## Tests parallèles
Il s’agit probablement de la star de la session, teasée lors du _Platforms State of the Union_. Avec Xcode 10, les tests peuvent être exécutés en parallèle.

Xcode 9 avait apporté le « parallel destination testing », disponible uniquement en ligne de commande, pour exécuter les tests sur plusieurs destinations (c’est à dire différents modèles et/ou différentes versions de l’OS) en simultané.

Xcode 10 apporte le « parallel distributed testing », accessible en ligne de commande et par l’interface graphique classique, permettant d’exécuter des tests pour une même destination en simultané. 

![Parallel testing - WWDC 2018 session 403, image Apple](/blog/img/2018/wwdc-2018-testing/6-parallel-testing.jpg)

Concrètement, Xcode crée des « clones » du simulateur au lancement de la suite de tests, et y installe les test bundles, répartis par classes de tests. Le simulateur d’origine n’est pas utilisé, uniquement ses clones. Chacun bénéficie d’un « data container » qui lui est propre, il faut donc s’assurer encore une fois qu’il n’existe pas de dépendance cachée entre les tests. Les tests parallèles sont disponibles pour les tests unitaires iOS et macOS, et pour les tests UI iOS uniquement. 

En ligne de commande, cette fonctionnalité apporte deux nouvelles options pour `xcodebuild` :
- `-parallel-testing-worker-count n` pour préciser le nombre de clones, la valeur par défaut étant déterminée en fonction du matériel disponible
- `-parallel-testing-enabled YES | NO` pour surcharger la valeur déjà configurée au niveau du scheme

Les tests parallèles sont distribués par classe de tests. Si une classe est encore trop lente à exécuter, il peut être interessant de diviser ses tests entre deux classes.

Les tests de performance peuvent produire des résultats moins fiables lorsqu’ils sont exécutés en parallèle. Il convient parfois de les garder dans un test bundle à part, en exécution linéaire classique.

Enfin, certains tests peuvent poser problème s’ils manipulent des ressources partagées (un fichier ou une base de données commune, par exemple). Dans ces cas, il faudra soit gérer la synchronisation d’exécutions simultanées, soit en rester au mode d’exécution classique. 

Vous pouvez retrouver la session complète, avec la vidéo et le fichier de présentation, sur le [site de la WWDC 2018](https://developer.apple.com/wwdc18/403).
