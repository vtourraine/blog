# Indexer le contenu d’une app, avec Spotlight pour iOS 9

Une API simple d’utilisation, intéressante pour la plupart des apps, une combinaison comme on les aime.

Avec iOS 9, vous pouvez indexer le contenu d’une application avec Spotlight, afin de rendre des données accessibles à tout moment depuis le champs recherche système. Il faudra encore attendre pour une API Siri, mais cette nouveauté constitue une amélioration importante.


## Indexer

On utilise un `CSSearchableIndex` partagé, auquel on passe des items, composés d’un ensemble d’attributs associés à un identifiant. Avec un exemple de code, c’est plus parlant :

``` objc
@import CoreSpotlight;

// (…)

CSSearchableIndex *searchableIndex = [CSSearchableIndex defaultSearchableIndex];

CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString *)kUTTypeItem];
attributeSet.title = @"...";
attributeSet.contentDescription = @"...";
attributeSet.thumbnailData = ...;

CSSearchableItem *searchableItem = [[CSSearchableItem alloc] initWithUniqueIdentifier:@"##ID##" domainIdentifier:nil attributeSet:attributeSet];

[searchableIndex indexSearchableItems:@[searchableItem] completionHandler:^(NSError * _nullable error) {}];
```

Il existe de très nombreux attributs possibles pour décrire votre object. Le titre et la description sont presque incontournables, et le `thumbnailData` est très intéressant pour donner un aperçu visuel dans les résultats d’une recherche. 

Dans certains cas, iOS peut même proposer des actions rapides sur les résultats, sans avoir à ouvrir l’application. Pour un numéro de téléphone, mettre `supportsPhoneCall` à `@1` et renseigner un numéro avec `phoneNumbers`. Pour une adresse, ce sera `supportsNavigation` avec une `latitude` et une `longitude`.

Détail import, chaque élément dispose d’une date d’expiration (`expirationDate`). Pour les premières beta iOS 9, cette propriété était initialisée avec une durée de validité d’un mois par défaut. Selon la nature des objets en question et la fréquence à laquelle ils seront ré-indexés, pensez à attribuer une valeur d’expiration satisfaisante pour ne pas voir les résultats de recherche disparaître prématurément.


## Présenter un résultat

Après avoir indexé un objet, encore faut-il pouvoir le restituer à l’utilisateur lorsqu’il est sélectionné parmi les résultats d’une recherche.  

C’est l’_app delegate_ qui s’en charge (qui d’autre ?). La recherche est traitée comme une `NSUserActivity`, il suffit donc de la prendre en compte, en vérifiant son type d’activité. Vous obtenez alors l’identifiant de l’objet, à vous de faire le reste.

``` objc
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _nullable))restorationHandler {
  if ([userActivity.activityType isEqualToString:CSSearchableItemActionType]) {
    NSString *identifier = userActivity.userInfo[CSSearchableItemActivityIdentifier];
    // …
  }

  return YES;
}
```


## Mettre à jour un élément

Pour ré-indexer un élément, c’est toujours aussi simple, il vous suffit d’utiliser la même méthode, en précisant le même identifiant.

## Supprimer un élément


## Bonus : l’extension d’entretien de l’index


## Références

- [_App Search Programming Guide: Index App Content_, Apple](https://developer.apple.com/library/prerelease/ios/documentation/General/Conceptual/AppSearch/AppContent.html#//apple_ref/doc/uid/TP40016308-CH7-SW1)
- [_Core Spotlight Framework Reference: CSSearchableIndex Class Reference_, Apple](https://developer.apple.com/library/prerelease/ios/documentation/CoreSpotlight/Reference/CSSearchableIndex_Class/index.html#//apple_ref/occ/instm/CSSearchableIndex/)
- [_Core Spotlight Framework Reference: CSSearchableItem Class Reference_, Apple](https://developer.apple.com/library/prerelease/ios/documentation/CoreSpotlight/Reference/CSSearchableItem_Class/index.html#//apple_ref/occ/cl/CSSearchableItem)