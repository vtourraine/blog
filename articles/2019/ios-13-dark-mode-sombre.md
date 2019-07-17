Title:     iOS 13 : s’adapter au mode sombre  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      July 17, 2019  
Update:    
Keywords:  dev, iOS  
Summary:   Le mode sombre ne laisse pas indifférent. Mais que vous soyez enthousiasmé ou consterné, Apple annonce « Dark Mode » comme la nouveauté principale d’iOS 13. Si vous développez une application iPhone ou iPad, ça signifie qu’il vous faudra supporter cette fonctionnalité aussi tôt que possible.  
Image:     https://www.vtourraine.net/blog/img/2019/ios-13-dark-mode-sombre/ios-dark-mode.jpg  
Language:  fr  


Le mode sombre ne laisse pas indifférent. Mais que vous soyez enthousiasmé ou consterné, Apple annonce « Dark Mode » comme *la* nouveauté principale d’iOS 13. Si vous développez une application iPhone ou iPad, ça signifie qu’il vous faudra supporter cette fonctionnalité aussi tôt que possible, pour ne pas recevoir une pluie d’avis négatifs sur l’App Store déplorant son absence.

![Mode sombre sur iOS 13](/blog/img/2019/ios-13-dark-mode-sombre/ios-dark-mode.jpg)

La bonne nouvelle, c’est que le mode sombre peut être très facile à prendre en charge. La mauvaise, c’est que ça peut aussi s’avérer très complexe, selon votre façon de configurer l’interface de votre application.

## Configuration par défaut

Premier conseil : **utilisez autant que possible les composants standards dans leur configuration par défaut**.

Par exemple, si vous voulez afficher un texte en noir sur fond blanc, c’est justement la configuration par défaut d’un `UILabel` dans une `UIView`. Ne modifiez les `textColor`, `backgroundColor`, etc, que si c’est absolument nécessaire.

Ça peut sembler évident, mais c’est le genre de code qui s’accumule facilement, surtout pour des projets plus anciens. Moins de code == moins de problèmes.

## Couleurs dynamiques

On arrive au plus important : les couleurs. Le SDK iOS 13 prend en charge les couleurs « dynamiques ». Ce sont des `UIColor` pouvant prendre plusieurs valeurs, typiquement une pour le mode clair et une pour le mode sombre. **En utilisant des couleurs dynamiques, la prise en charge du mode sombre est automatique. Pas la moindre ligne de code à ajouter**.

Pour utiliser ces couleurs dynamiques, vous avez plusieurs options :
- **Couleurs sémantiques** : ce sont de nouvelles couleurs prêtes à l’emploi, qui couvrent les besoins de base. Tout est décrit dans le nom : `labelColor` pour le texte, `systemBackgroundColor` pour le fond, mais aussi des variations comme `secondaryLabelColor`. [Documentation](https://developer.apple.com/documentation/uikit/uicolor/ui_element_colors?language=objc)
- **Couleurs adaptables** : même chose pour les couleurs classiques (bleu, rouge, vert, etc), mais avec des valeurs ajustées spécialement pour le mode sombre. `systemBlueColor`, `systemRedColor`, `systemGreenColor`, etc. [Documentation](https://developer.apple.com/documentation/uikit/uicolor/standard_colors?language=objc)
- **Couleurs nommées** : depuis iOS 11, il est possible de définir des couleurs dans un Asset Catalog. Avec la nouvelle version d’Xcode, vous pouvez y ajouter des valeurs spécifiques à chaque mode.
- **Couleurs en code** : vous pouvez aussi définir une couleur dynamique directement dans votre code avec `UIColor.resolvedColorWithTraitCollection:`. Le bloc en paramètre retourne une couleur fixe en fonction d’un `UITraitCollection` donné. [Documentation](https://developer.apple.com/documentation/uikit/uicolor/3238042-resolvedcolorwithtraitcollection?language=objc)

![Sélection des couleurs avec Xcode 11](/blog/img/2019/ios-13-dark-mode-sombre/xcode-11-colors.jpg)

Ces nouvelles couleurs sont uniquement disponibles sur iOS 13. Si votre application supporte des versions antérieures, il faudra adapter votre projet, avec là aussi plusieurs options :
- Storyboard : c’est la solution la plus simple. Vous pouvez sélectionner une couleur dynamique, et le Storyboard l’adaptera à la version iOS courante.
- Couleurs nommées : la méthode pour invoquer une couleur à partir d’un Asset Catalog n’a pas changé depuis iOS 11. Vous pouvez donc spécifier une variante pour le mode sombre sur iOS 13, elle sera simplement ignorée sur iOS 11 et iOS 12.
- Pour toutes les autres situations, il faudra tester dans votre code la disponibilité de la couleur souhaitée. Pour ne pas répéter ça partout, je vous conseille de créer une catégorie (Objective-C) ou extension (Swift) sur `UIColor` avec des méthodes dédiées.

```objc
@implementation UIColor (XYZ)

+ (UIColor *)xyz_labelColor {
  if (@available(iOS 13.0, *)) {
    return [UIColor labelColor];
  } else {
    return [UIColor blackColor];
  }
}

@end
```

Une dernière note concernant les couleurs : les `CGColor` ne sont pas dynamiques. On les utilise parfois, par exemple pour ajouter une bordure ou une ombre à une vue, en passant par le `CALayer`. Les éléments utilisant des `CGColor`, même créées à partir d’`UIColor`, ne s’adapteront pas automatiquement au mode sombre. Il vous faudra alors explicitement les mettre à jour avec des `CGColor` différentes. Je vous explique comment en bas de cet article, dans la section « Implémentation personnalisée ».

## Images
Vous pouvez utiliser des images spécifiques au mode sombre. Là aussi, `UIImageView` s’occupe de tout, et s’adapte automatiquement en fonction du mode actif, si l’image dispose d’une variante sombre. Avec un Asset Catalog, il suffit de spécifier la variante pour chaque image concernée, comme pour les couleurs nommées.

## Glyphes
On peut aussi évoquer les glyphes, c’est à dire les images avec un rendu en mode « template », qui sont colorisées selon le `tintColor` de la vue concernée. Concrètement, c’est ce qu’on utilise pour les icônes de boutons : le « + » pour l’ajout, le carré avec une flèche vers le haut pour le partage, etc. iOS 13 ajoute par ailleurs les « SF Symbols », une collection de quelques centaines de glyphes disponibles avec variantes de taille et d’épaisseur.

Dans tous les cas, il suffit d’utiliser une couleur dynamique en `tintColor` pour que le rendu de l’image s’adapte automatiquement au mode actif.


## Implémentation personnalisée
La prise en charge du mode sombre est largement automatisée, mais il est également possible d’intervenir manuellement.

`traitCollectionDidChange:` est la méthode la plus importante, puisque c’est `UITraitCollection` qui contient la valeur du mode, clair ou sombre, avec la propriété `userInterfaceStyle`. Vous pouvez surcharger cette méthode à différents niveaux, sur `UIView`, `UIViewController`, `UIScreen` et `UIPresentationController`. [Documentation](https://developer.apple.com/documentation/uikit/uitraitenvironment/1623516-traitcollectiondidchange?language=objc)

``` objc
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
    // ...
  }
}
```

## Désactiver le mode sombre
Toute application compilée avec le SDK iOS 13 supporte a priori le mode sombre.

Si vous souhaitez modifier la prise en charge automatique pour une partie de votre application, vous pouvez assigner la propriété `overrideUserInterfaceStyle` sur une `UIView` ou un `UIViewController` pour forcer un mode spécifique.

Enfin, si vous souhaitez désactiver complètement le mode sombre, vous pouvez ajouter la clé `UIUserInterfaceStyle` dans le fichier `Info.plist` de votre application, avec une valeur de `Light`.
