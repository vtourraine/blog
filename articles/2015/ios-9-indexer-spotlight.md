Title:     Indexer le contenu d’une app avec Spotlight pour iOS 9  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      September 5, 2015  
Update:   
Keywords:  iOS, dev
Summary:   Une API simple d’utilisation et intéressante pour la plupart des apps : une combinaison comme on les aime.  
Image:     http://www.vtourraine.net/blog/img/2015/watchkit-version-1/apple-watch-1.jpg  
Language:  fr  

Une API simple d’utilisation et intéressante pour la plupart des apps : une combinaison comme on les aime.

Avec iOS 9, on peut indexer le contenu d’une application, afin de rendre des données accessibles à tout moment depuis le champs recherche système (a.k.a. _Spotlight_). Il faudra encore attendre pour une API Siri, mais cette nouveauté constitue une amélioration importante.


## Indexer

On utilise une instance de `CSSearchableIndex` partagée, à laquelle on passe des éléments (`CSSearchableItem`), composés d’un ensemble d’attributs (`CSSearchableItemAttributeSet`) associés à un identifiant. Avec un exemple de code, c’est plus parlant :

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

La méthode d’indexation fonctionne avec un tableau d’éléments, vous pouvez donc bien-sûr en grouper plusieurs avec un seul appel. Le bloc `completionHandler` permet de connaître le résultat de l’opération et, le cas échéant, l’erreur en question. 

Il existe [de nombreux attributs possibles](https://developer.apple.com/library/prerelease/ios/documentation/CoreSpotlight/Reference/CSSearchableItemAttributeSet_Class/index.html#//apple_ref/occ/cl/CSSearchableItemAttributeSet) pour décrire votre object. Le titre et la description sont presque incontournables, et le `thumbnailData` est très intéressant pour donner un aperçu visuel dans les résultats de recherche. 

![Les attributs associés à un résultat de recherche Spotlight, image Apple][search result]

Dans certains cas, iOS peut même proposer des actions rapides sur les résultats, sans avoir à ouvrir l’application. Pour un numéro de téléphone, mettre `supportsPhoneCall` à `@1` et renseigner un numéro avec `phoneNumbers`. Pour une adresse, ce sera `supportsNavigation` avec une `latitude` et une `longitude`.

Détail important, chaque élément dispose d’une date d’expiration (`expirationDate`). Pour les premières beta iOS 9, cette propriété était initialisée par défaut avec une durée de validité d’un mois. Selon la nature des objets en question et la fréquence à laquelle ils seront ré-indexés, pensez à attribuer une valeur d’expiration satisfaisante pour ne pas voir les résultats de recherche disparaître prématurément.


## Présenter un résultat

Indexer c’est bien, mais tout ça ne serait pas très utile sans la capacité à restituer précisément l’objet concerné, lorsqu’il est sélectionné parmi les résultats d’une recherche.  

C’est l’_app delegate_ qui s’en charge (qui d’autre ?). La recherche est traitée comme une `NSUserActivity`, il suffit donc de la prendre en compte, en vérifiant son type d’activité. Vous obtenez alors l’identifiant de l’objet, à vous de faire le reste.

``` objc
- (BOOL)application:(UIApplication *)application 
 continueUserActivity:(NSUserActivity *)userActivity
 restorationHandler:(void (^)(NSArray * _nullable))restorationHandler {
  if ([userActivity.activityType isEqualToString:CSSearchableItemActionType]) {
    NSString *identifier = userActivity.userInfo[CSSearchableItemActivityIdentifier];
    // …
  }

  return YES;
}
```


## Mettre à jour un élément

Pour mettre à jour un élément, c’est toujours aussi simple, il suffit de réutiliser la méthode d’indexation, en précisant le même identifiant.


## Supprimer un élément

Quand un objet disparaît, il convient évidémment d’en informer Spotlight.

Le plus simple est d’indiquer l’identifiant de l’élément concerné. Comme précédemment, vous pouvez grouper les éléments, et connaître le résultat de l’opération.

``` objc
[searchableIndex deleteSearchableItemsWithIdentifiers:@[@"##ID##"] completionHandler:^(NSError * _nullable error) {}];
```

Plus radical, il existe une méthode pour supprimer l’intégralité des éléments de l’index.

``` objc
[searchableIndex deleteAllSearchableItemsWithCompletionHandler:^(NSError * _nullable error) {}];
```

Enfin, on remarque qu’il est possible de renseigner un `domainIdentifier` lors de la création d’un élément recherchable. Cette information permet justement de supprimer tous les éléments pour un domaine. À titre d’exemple, Apple évoque le cas d’un client mail, où le domaine pourrait correspondre au compte concerné. Lorsque l’utilisateur supprimer un compte, l’index peut être nettoyé très simplement.

``` objc
[searchableIndex deleteSearchableItemsWithDomainIdentifiers:@[@"##domain##"] completionHandler:^(NSError * _nullable error) {}];
```


## Bonus : l’extension pour entretenir de l’index


Enfin, si iOS 8 ou avant, tester avec truc.



## Documentation

- [_App Search Programming Guide: Index App Content_, Apple](https://developer.apple.com/library/prerelease/ios/documentation/General/Conceptual/AppSearch/AppContent.html#//apple_ref/doc/uid/TP40016308-CH7-SW1)
- [_Core Spotlight Framework Reference: CSSearchableIndex Class Reference_, Apple](https://developer.apple.com/library/prerelease/ios/documentation/CoreSpotlight/Reference/CSSearchableIndex_Class/index.html#//apple_ref/occ/instm/CSSearchableIndex/)
- [_Core Spotlight Framework Reference: CSSearchableItem Class Reference_, Apple](https://developer.apple.com/library/prerelease/ios/documentation/CoreSpotlight/Reference/CSSearchableItem_Class/index.html#//apple_ref/occ/cl/CSSearchableItem)
- [_Core Spotlight Framework Reference: CSSearchableItemAttributeSet Class Reference_, Apple](https://developer.apple.com/library/prerelease/ios/documentation/CoreSpotlight/Reference/CSSearchableItemAttributeSet_Class/index.html#//apple_ref/occ/cl/CSSearchableItemAttributeSet)

[search result]: https://developer.apple.com/library/prerelease/ios/documentation/General/Conceptual/AppSearch/Art/numbers_2x.png