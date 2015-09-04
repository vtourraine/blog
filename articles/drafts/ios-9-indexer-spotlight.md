# Indexer le contenu d’une app, avec Spotlight pour iOS 9

Une API simple d’utilisation, intéressante pour la plupart des apps, une combinaison comme on les aime.

Avec iOS 9, vous pouvez indexer le contenu d’une application avec Spotlight, afin de le rendre accessible à tout moment depuis le champs recherche système. Il faudra encore attendre pour une API Siri, mais cette nouveauté constitue une amélioration importante.


## Indexer

On utilise un `CSSearchableIndex` partagé, auquel on passe des items, composés d’un ensemble d’attributs associés à un identifiant. Avec un exemple de code, c’est très simple :

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


## Présenter un résultat


https://developer.apple.com/library/prerelease/ios/documentation/General/Conceptual/AppSearch/AppContent.html#//apple_ref/doc/uid/TP40016308-CH7-SW1
