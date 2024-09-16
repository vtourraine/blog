Title:    Personnaliser les icônes sombres et teintées avec iOS 18  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     September 16, 2024  
Update:   
Keywords: dev, iOS  
Summary:  Avec iOS 18, les icônes évoluent. L’utilisateur peut maintenant personnaliser son écran d’accueil avec des icônes sombres ou teintées. Quel impact pour les développeurs ?  
Image:    https://www.vtourraine.net/blog/img/2024/ios-18-icones-sombres-teintees/xcode-icons-3.jpg  
Language: fr  


Avec iOS 18, les icônes évoluent. L’utilisateur peut maintenant personnaliser son écran d’accueil avec des icônes sombres (« dark ») ou teintées (« tinted »).

Quel impact pour les développeurs ? Si vous ne changez rien à votre application, iOS adapte automatiquement votre icône. La pertinence du résultat est... variable, selon les couleurs et le graphisme de l’icône d’origine. Pour garantir un résultat de qualité, vous avez donc tout intérêt à fournir vous-même des variantes, soigneusement conçues pour chaque mode.

## Créer les fichiers

Toutes les icônes doivent être des PNG 1024×1024 px.

**Icône principale** : rien ne change. Image carrée, entièrement opaque (les coins arrondis sont gérés par le système).

**Icône sombre** : vous pouvez utiliser de la transparence. Si c’est le cas, iOS ajoutera un fond sombre approprié. Sinon, l’icône sera affichée normalement, comme pour l’icône principale. En pratique, si votre icône utilise un logo qui ressort bien, Apple conseille d’utiliser de la transparence en fond, pour garantir la cohérence entre applications.

**Icône teintée** : image carrée, opaque, en niveaux de gris. Les zones sombres resteront sombres et les zones claires prendront la couleur de la teinte.

Vous trouverez les recommandations détailles dans les [Human Interface Guidelines (HIG)](https://developer.apple.com/design/human-interface-guidelines/app-icons#Platform-considerations). Et si vous voulez pousser la recherche graphique plus loin, notamment sur l’ajustement des couleurs, je vous conseille [cet excellent article de Louis Mantia](https://lmnt.me/blog/dark-mode-app-icons.html).

## Mettre à jour le project Xcode

1. Ouvrez l’asset catalog (`.xcassets`) principal.
2. Sélectionnez l’icône de base (intitulée `AppIcon` par défaut).
3. Dans l’inspecteur de droite, cliquez sur « Appearances ».
4. Choisissez « Any, Dark, Tinted ».
5. Glissez-déposez les variantes « dark » et « tinted ».

![Activation des « Appearances »](/blog/img/2024/ios-18-icones-sombres-teintees/xcode-icons-1.jpg)

![Variantes à glisser-déposer](/blog/img/2024/ios-18-icones-sombres-teintees/xcode-icons-2.jpg)

![Icônes sombres et teintées pour PlayGuide](/blog/img/2024/ios-18-icones-sombres-teintees/xcode-icons-3.jpg)

Votre application est prête pour iOS 18 !
