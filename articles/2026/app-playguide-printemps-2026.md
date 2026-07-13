Title:    PlayGuide version printemps/été 2026  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     July 13, 2026  
Update:   
Keywords: dev, iOS  
Summary:  Comment numéroter les versions d’une application ? Une tendance actuelle consiste à utiliser l’année en cours comme valeur principale.  
Image:    https://www.vtourraine.net/blog/img/2026/app-playguide-printemps-2026/playguide-detail-sheet.jpg  
Language: fr  


## Versions

Comment numéroter les versions d’une application ? La question est un peu dépassée, maintenant que les mises à jour sont installées automatiquement, avec des notes de versions qui répètent à l’infini « bug fixes and performance improvements ». Une tendance actuelle consiste à utiliser l’année en cours comme valeur principale. Même Apple y est passé avec iOS 26/macOS 26/etc. Je continue de préférer le classique [SemVer](https://semver.org/). Mais pour certaines applications qui dépendent intrinsèquement du calendrier, nommer les versions avec l’année me paraît judicieux.

Pour mes applications, cela concernerait d’abord [MiXiT](https://www.vtourraine.net/blog/2026/app-mixit-v11), avec une mise à jour majeure par édition, donc par année. Mais ça pourrait aussi s’appliquer à [PlayGuide](https://apps.apple.com/app/playguide/id6443413389). Il s’agit d’activités en plein air, a fortiori pour des enfants, alors logiquement l’application est davantage utilisée au printemps et en été… Un rythme annuel qui me motive en retour à développer un lot d’améliorations plus significatives chaque début d’année.

(Je reste quand même sur SemVer, avant tout parce que ces applications ont été lancées avec ce format et que je déteste quand une série de livres change de format en milieu de diffusion. Je sais, ce n’est pas vraiment le même problème, mais ça me fait la même impression.)

Pour en revenir à PlayGuide, je voulais évoquer les nouveautés de cette version printemps/été 2026. Après l’ajout des terrains de sport l’année dernière, il n’y a aucune nouvelle « fonctionnalité » à proprement parler, mais plusieurs changements notables.

## Liquid Glass

PlayGuide supporte techniquement Liquid Glass depuis la sortie d’iOS 26. La dernière version améliore cette intégration en adaptant la vue de détail d’une aire de jeux. La liste des équipements est affichée sans couleur de fond, les sections ont des titres plus appuyés et des arrondis harmonisés.

![Aperçu d’une aire de jeux (v1.4 à gauche, v1.6 à droite)](/blog/img/2026/app-playguide-printemps-2026/playguide-detail-sheet.jpg)

![Détail d’une aire de jeux (v1.4 à gauche, v1.6 à droite)](/blog/img/2026/app-playguide-printemps-2026/playguide-detail-plein-ecran.jpg)

Ces modifications sont modestes, mais je tiens à garder la compatibilité avec les OS précédents, en utilisant au maximum les composants système. Difficile de reproduire le style des applications d’Apple quand elles-mêmes ne suivent pas les implémentations standard du SDK (je pense en particulier à Cartes/Maps, qui est la plus proche de PlayGuide). Un vrai casse-tête.

Pour m’en sortir, [j’ai même configuré un `#Preview` dans Xcode qui charge l’écran depuis le Storyboard et le configure avec une aire de jeux à partir d’une URL fixe](https://codeberg.org/PlayGuide/ios/src/commit/2fe186c1d3e44e2ef7a96140dd0728b4a8ccaa07/PlayGuide/Sources/DetailsViewController.swift#L660). Je trouve ça un peu contre-intuitif d’utiliser ces techniques (conçues pour SwiftUI) avec UIKit, mais il faut avouer que ça fonctionne bien, et que c’est très pratique pour affiner le rendu plus facilement.

## À propos

L’autre nouveauté concerne l’écran « À propos ». Une carte digne de ce nom a besoin d’une légende. L’écran détaille désormais les différents types d’aires de jeux et terrains de sport, avec les icônes et couleurs correspondantes. Ces informations auraient dû être présentes dès la première version. Elles sont maintenant disponibles et facilement accessibles, avec l’ajout d’un bouton sur la carte principale. Auparavant, il fallait passer par l’écran de recherche.

![À propos de PlayGuide (v1.4 à gauche, v1.6 à droite)](/blog/img/2026/app-playguide-printemps-2026/playguide-a-propos.jpg)

À cette occasion, j’ai repris [l’implémentation de cet écran « À propos » pour passer d’UIKit avec Storyboard à SwiftUI](https://codeberg.org/PlayGuide/ios/src/branch/main/PlayGuide/Sources/AboutViewController.swift). Je commence à avoir un peu de recul avec SwiftUI, et même si UIKit est intrinsèquement plus puissant, un développeur doit savoir choisir l’outil le plus adapté selon la situation. Pour un écran avec peu de données à afficher mais beaucoup de personnalisations visuelles comme ici, SwiftUI me semble plus intéressant. On pourrait même dire qu’il remplit le rôle d’un Storyboard.

# Bug fixes

Je termine cet article en mentionnant un bug à présent corrigé. Quand l’utilisateur autorise l’application à accéder à sa position géographique pour la première fois, la carte zoome sur sa position actuelle. Ça paraît normal ? Oui, c’était même dans le code. Sauf que ça ne fonctionnait pas, à cause d’un petit oubli. Le `delegate` du `LocationManager` n’était pas configuré avant d’avoir l’autorisation. Une erreur de débutant, comme on dit, [enfin corrigée](https://codeberg.org/PlayGuide/ios/commit/d3f4562933c644042cd5d54c3cd687fc1fe2f6eb). Je le mentionne pour rappeler, si quelqu’un en doute encore, qu’on peut toujours faire des erreurs. La seule solution : constamment prêter attention aux détails. 

Je vous laisse profiter du beau temps (canicules ?). Heureusement que les aires de jeux sont ouvertes toute l’année. 
