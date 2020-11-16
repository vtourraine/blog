Title:     Adapter une application iOS pour le Mac avec Catalyst  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      November 16, 2020  
Update:    
Keywords:  dev, macOS  
Summary:   On peut réellement porter une application iOS sur le Mac en cochant une case dans Xcode. C’est la promesse de Catalyst, qui implémente UIKit sur macOS, pour permettre de compiler un projet mobile en application Mac.  
Image:     https://www.vtourraine.net/blog/img/2020/adapter-ios-macos-catalyst/memorii-3-5-mac.jpg  
Language:  fr  


On peut réellement porter une application iOS sur le Mac en cochant une case dans Xcode. C’est la promesse de Catalyst, qui implémente UIKit sur macOS, pour permettre de compiler un projet mobile en application Mac. Ça fonctionne, et [ça permet même d’être mis en avant sur le Mac App Store](https://www.vtourraine.net/blog/2020/comicbookday-mac-app-store).

Mais ce n’est qu’un point de départ. L’application obtenue ressemble trop souvent à une émulation d’iPad. Malgré une certaine convergence, les interfaces de macOS et d’iOS n’utilisent pas les mêmes éléments, les mêmes conventions.

Ce qui nous amène au véritable défi du développement avec Catalyst : **comment adapter une application iOS pour qu’elle s’intègre harmonieusement au Mac ?** Vaste question, qui dépend évidemment de l’application concernée.

Pour [Memorii](https://apps.apple.com/app/memorii/id352411168), j’ai d’abord distribué un portage direct. Quelques mises à jour plus tard, je suis arrivé à une refonte complète de l’interface, pour mieux l’adapter au Mac, tout en améliorant sa version iOS et iPadOS. Voici une revue des différents aspects concernés par cette mise à jour.

## Tab bar

Originellement, Memorii utilisait un `UITabBarController`. C’est une excellente approche pour l’iPhone, acceptable pour l’iPad, mais très mal adaptée au Mac.

![Memorii pour Mac v3.2, interface avec tab bar](/blog/img/2020/adapter-ios-macos-catalyst/memorii-3-2-mac.jpg)

Une première solution consiste à remplacer la tab bar en bas de l’écran par un bouton segmenté dans la toolbar en haut de l’écran (comme sur l’application Photos, par exemple). Cette approche demande un peu de code supplémentaire pour associer le bouton avec la tab bar cachée, mais la structure générale reste identique, et le résultat est plus satisfaisant.

![Memorii pour Mac v3.3, interface avec toolbar](/blog/img/2020/adapter-ios-macos-catalyst/memorii-3-3-mac.jpg)

## Split view

Catalyst adore les applications à base de `UISplitViewController`. Il suffit d’utiliser le style « sidebar » pour que le panneau principal gagne un fond translucide, et s’intègre visuellement avec la toolbar.

![Memorii pour Mac v3.5, interface avec split view](/blog/img/2020/adapter-ios-macos-catalyst/memorii-3-5-mac.jpg)

La différence est assez frappante (ok, ok, le changement d’image de fond d’écran n’y est pas pour rien). Avec une ligne de code, on passe d’une application pour iPad tournant sur le Mac à une véritable application native, même si le reste du code est identique.

``` swift
splitViewController.primaryBackgroundStyle = .sidebar
```

Bien sûr, le passage d’une tab bar à une split view demande une réorganisation plus importante de l’interface. Le controller principal devient une sorte de menu. Pour Memorii, j’affiche les options principales (favoris, packs de vocabulaire) et la liste des dossiers. Là encore, tout dépend de l’application en question.

La split view est parfaite pour le Mac et l’iPad, mais il ne faut pas oublier l’iPhone. Solution basique : l’aplatir en une unique pile de navigation avec `UINavigationController`. Mieux, avec iOS 14, on dispose d’une nouvelle option bien pratique : assigner le tab bar controller comme alternative au split view controller lorsque l’écran est « compact ». Memorii nécessite iOS 14 sur iPhone et iPad, mais supporte macOS 10.15 pour Catalyst (donc équivalent SDK iOS 13), où cette fonction n’est pas disponible. Il me faut donc vérifier la disponibilité de l’API en fonction de la plateforme.

``` swift
#if !targetEnvironment(macCatalyst)
splitViewController.setViewController(tabBarController, for: .compact)
#endif
```

## Menus

Catalyst propose automatiquement des menus pour l’application, mais se contente de proposer les actions génériques : copier/coller, gestion des fenêtres, etc. Vous avez donc tout intérêt à y ajouter des fonctionnalités propres à votre application.

Tout passe par la fonction `buildMenu(with builder: UIMenuBuilder)`. D’un côté, on retire les menus qui n’ont pas raison d’être, de l’autre on ajoute soit des menus nouveaux, soit on ajoute des éléments aux menus existants. L’API est un peu bancale. Pour insérer un sous-menu, par exemple, il faut ajouter un nouveau menu avec l’option « afficher en ligne ». Chaque élément doit avoir une action et une touche de raccourci unique. Pour activer ou désactiver les éléments dynamiquement, c’est la méthode `validate(_ command: UICommand)` qui entre en jeu.

[Voici un aperçu du code pour les menus Memorii](https://gist.github.com/vtourraine/f5af6067bce48dec76e812251335dc76), si vous cherchez un exemple d’implémentation.

Par ailleurs, iOS 13 ajoute une API pour les menus contextuels, qui s’adaptent merveilleusement sur le Mac (mais sans icônes).

## Éclater l’écran Réglages

Memorii pour iOS dispose, comme beaucoup d’applications mobiles, d’un écran « Settings ». Il contient des réglages, ainsi que quelques commandes (contacter le support) et informations (numéro de version, licences). Cet écran paraît déplacé sur le Mac, il existe heureusement des solutions prêtes à l’emploi.

Pour les réglages, il suffit de passer à un `Settings.bundle` classique. Cette solution est limitée, austère même, mais permet à Catalyst de générer un écran « Preferences » automatiquement. Un gain de code très appréciable.

![Réglages Memorii pour Mac](/blog/img/2020/adapter-ios-macos-catalyst/memorii-3-5-mac-preferences.jpg)

Pour les commandes, on peut utiliser des menus. Contacter le support est généralement proposé dans le menu « Aide », cette solution était donc toute trouvée (cf. section précédente sur les menus).

Pour les informations, enfin, il m’a suffit d’ajouter un fichier nommé `Credits.html` pour le voir automatiquement intégré au menu « About Memorii ». [Voici le code HTML/CSS que j’utilise](https://gist.github.com/vtourraine/91ed6ea1644de15e0c41c0cc4b343280) pour donner à cet écran une apparence satisfaisante.

![À propose de Memorii pour Mac](/blog/img/2020/adapter-ios-macos-catalyst/memorii-3-5-mac-about.jpg)

## Titres

Pour l’iPhone et l’iPad, j’aime beaucoup les grands titres des barres de navigation (`prefersLargeTitles`) disponibles depuis iOS 11. Ils sont disponibles avec Catalyst, mais je préfère les y désactiver.

``` swift
#if !targetEnvironment(macCatalyst)
navigationController.navigationBar.prefersLargeTitles = true
#endif
```

Dans certains cas, je pense qu’il vaut mieux cacher complètement le titre et/ou la barre de navigation d’un view controller pour le Mac. Avec Memorii, le controller à gauche de la split view possède un titre sur iPad, mais je le cache pour Catalyst. Encore une fois, j’utilise l’application « Photos » d’Apple comme référence.

## Modales

Quand un écran modal propose un bouton de fermeture, plutôt que d’utiliser le classique « Done » hérité d’iOS, j’utilise `UIBarButtonItem.SystemItem.close` (l’icône en forme de croix), que je place du côté gauche. De cette façon, le résultat se rapproche d’une fenêtre classique façon AppKit.

![Memorii pour Mac, fenêtre modale](/blog/img/2020/adapter-ios-macos-catalyst/memorii-3-5-mac-modal.jpg)

Enfin, j’ajoute une « key command » avec la touche Escape comme une option supplémentaire pour fermer la modale. Je ne mets pas de `discoverabilityTitle`, afin de cacher cette option sur iOS, puisque les claviers d’Apple pour l’iPad ne contiennent pas cette touche.

## Icône

Pour l’icône de l’application, il convient de sélectionner l’image dans l’assets catalog, de cocher l’option Mac, et de fournir les variantes avec les dimensions demandées.

![Icônes Memorii pour Mac](/blog/img/2020/adapter-ios-macos-catalyst/memorii-macos-icon.jpg)

Bonne nouvelle : il n’y a pas de forme imposée, vous pouvez utiliser la transparence de l’image et donner libre cours à votre créativité. Mauvaise nouvelle : avec Big Sur la tendance est d’appliquer la même forme de carré arrondi à toutes les icônes, comme pour iOS.

À vous de voir si vous préférez miser sur la cohérence ou sur l’originalité. Comme d’habitude, j’ai tendance à suivre Apple dans ses choix, le problème étant qu’il faut appliquer soi-même la forme à partir [des fichiers de référence](https://developer.apple.com/design/resources/), disponibles uniquement pour Photoshop, Sketch et XD. L’affaire serait beaucoup plus simple si on pouvait fournir une image carrée et laisser le système s’occuper du reste, comme sur iOS.
