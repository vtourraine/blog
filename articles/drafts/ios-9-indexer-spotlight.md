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

[searchableIndex indexSearchableItems:@[searchableItem]
                                                                                completionHandler:^(NSError * _Nullable error) {}];
```


## Présenter un résultat


https://developer.apple.com/library/prerelease/ios/documentation/General/Conceptual/AppSearch/AppContent.html#//apple_ref/doc/uid/TP40016308-CH7-SW1