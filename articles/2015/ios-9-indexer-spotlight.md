Title:     Indexer le contenu d’une app avec Spotlight pour iOS 9  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      September 12, 2015  
Update:   
Keywords:  iOS, dev
Summary:   Une nouvelle API à la fois simple d’utilisation et intéressante pour la plupart des apps : une combinaison comme on les aime. Avec iOS 9, on peut donc indexer le contenu d’une application, afin de rendre des données accessibles à tout moment depuis le champs de recherche système (a.k.a. « Spotlight »). Une opportunité plutôt rare dans un OS où chaque app est soigneusement sandboxée. Il faudra encore attendre pour une éventuelle API Siri, mais cette nouveauté constitue déjà une amélioration importante.  
Image:     http://www.vtourraine.net/blog/img/2015/ios-9-indexer-spotlight/search-result-wake.png  
Thumbnail: http://www.vtourraine.net/blog/img/2015/ios-9-indexer-spotlight/thumbnail-search.jpg  
Language:  fr  

Une nouvelle API à la fois simple d’utilisation et intéressante pour la plupart des apps : une combinaison comme on les aime.

![iOS 9, image Apple][ios 9 icon]

Avec iOS 9, on peut donc indexer le contenu d’une application, afin de rendre des données accessibles à tout moment depuis le champs de recherche système (a.k.a. _Spotlight_). Une opportunité plutôt rare dans un OS où chaque app est soigneusement sandboxée. Il faudra encore attendre pour une éventuelle API Siri, mais cette nouveauté constitue déjà une amélioration importante.


## Indexer

Tout repose sur une instance de `CSSearchableIndex` partagée, à laquelle on passe des éléments (`CSSearchableItem`), composés d’un ensemble d’attributs (`CSSearchableItemAttributeSet`) associés à un identifiant. Avec un exemple de code, c’est plus parlant :

``` objc
// @import CoreSpotlight;

CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString *)kUTTypeData];
attributeSet.title = @"...";
attributeSet.contentDescription = @"...";
attributeSet.thumbnailData = ...;

CSSearchableItem *searchableItem = [[CSSearchableItem alloc] initWithUniqueIdentifier:@"##ID##" domainIdentifier:nil attributeSet:attributeSet];

CSSearchableIndex *searchableIndex = [CSSearchableIndex defaultSearchableIndex];
[searchableIndex indexSearchableItems:@[searchableItem] completionHandler:^(NSError * _Nullable error) {}];
```

La méthode d’indexation sur la dernière ligne fonctionne avec un tableau d’éléments, vous pouvez donc bien-sûr en grouper plusieurs avec un seul appel. Le bloc `completionHandler` permet de connaître le résultat de l’opération et, le cas échéant, l’erreur en question. 

Il existe [de nombreux attributs possibles](https://developer.apple.com/library/prerelease/ios/documentation/CoreSpotlight/Reference/CSSearchableItemAttributeSet_Class/index.html#//apple_ref/occ/cl/CSSearchableItemAttributeSet) pour décrire votre objet. Le titre et la description sont presque incontournables, et le `thumbnailData` est très intéressant pour donner un aperçu visuel des résultats de recherche. 

![Les attributs associés à un résultat de recherche Spotlight, image Apple][search result cell]

Dans certains cas, iOS peut même proposer des actions rapides sur les résultats, sans avoir à ouvrir l’application. Pour un numéro de téléphone, mettre `supportsPhoneCall` à `@1` et renseigner un numéro avec `phoneNumbers`. Pour une adresse, ce sera `supportsNavigation` avec une `latitude` et une `longitude`.

Détail important, chaque élément dispose d’une date d’expiration (`expirationDate`). Pour les premières beta iOS 9, cette propriété était initialisée par défaut avec une durée de validité d’un mois. Selon la nature des objets en question et la fréquence à laquelle ils seront ré-indexés, pensez à attribuer une valeur d’expiration suffisante pour ne pas voir les résultats de recherche disparaître prématurément.


## Mettre à jour un élément

Pour mettre à jour un élément, c’est toujours aussi simple, il suffit de réutiliser la méthode d’indexation, en précisant le même identifiant.


## Supprimer un élément

Quand un objet disparaît, il convient évidemment d’en informer Spotlight.

Le plus direct est d’indiquer l’identifiant de l’élément concerné. Comme précédemment, vous pouvez grouper les éléments, et connaître le résultat de l’opération.

``` objc
[searchableIndex deleteSearchableItemsWithIdentifiers:@[@"##ID##"] completionHandler:^(NSError * _Nullable error) {}];
```

Plus radical, il existe une méthode pour supprimer l’intégralité des éléments de l’index.

``` objc
[searchableIndex deleteAllSearchableItemsWithCompletionHandler:^(NSError * _Nullable error) {}];
```

Enfin, on remarque qu’il est possible de renseigner un `domainIdentifier` lors de la création d’un élément recherchable. Cette information permet justement de supprimer tous les éléments pour un domaine. À titre d’exemple, Apple évoque le cas d’un client mail, où le domaine pourrait correspondre au compte concerné. Lorsque l’utilisateur supprimer un compte, l’index peut être nettoyé très simplement.

``` objc
[searchableIndex deleteSearchableItemsWithDomainIdentifiers:@[@"##domain##"] completionHandler:^(NSError * _Nullable error) {}];
```


## Présenter un résultat

Indexer c’est bien, mais tout ça ne serait pas très utile sans la capacité à restituer précisément l’objet concerné, lorsqu’il est sélectionné par l’utilisateur parmi les résultats d’une recherche.  

C’est votre _app delegate_ qui s’en charge (qui d’autre ?). La recherche est traitée comme une `NSUserActivity`, il suffit donc de la prendre en compte, en vérifiant son type d’activité. Vous obtenez alors l’identifiant de l’objet, à vous de faire le reste.

``` objc
- (BOOL)application:(UIApplication *)application 
 continueUserActivity:(NSUserActivity *)userActivity
 restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
  if ([userActivity.activityType isEqualToString:CSSearchableItemActionType]) {
    NSString *identifier = userActivity.userInfo[CSSearchableItemActivityIdentifier];
    // …
  }

  return YES;
}
```

![Exemple de résultats de recherche pour [Comic Book Day](http://www.studioamanga.com/comicbookday/)][search results]


## Bonus : l’extension pour entretenir de l’index

Avec ces méthodes, vous avez tout le nécessaire pour gérer Spotlight. Pour une prise en charge exemplaire, il reste un dernier élément : une extension d’entretien de l’index.

La documentation est pour l’instant assez limitée, ce qui ne nous dit pas vraiment quand cette extension est invoquée par le système. Elle pourrait intervenir après une restoration, par exemple, pour reconstituer Spotlight à partir des données des applications concernées. 

Dans les réglages du projet, ajoutez une _target_ de type “Spotlight Index Extension”.

![Création d’une nouvelle target “Spotlight Index Extension” avec Xcode][target spotlight]

Par défaut, vous y trouvez une seule classe, `IndexRequestHandler`, avec deux méthodes qu’il vous reste à compléter. Une première pour ré-indexer l’ensemble des éléments recherchables, une seconde pour mettre à jour un certain nombre d’éléments sur la base de leurs identifiants. Dans les deux cas, la méthode vous passe le `CSSearchableIndex` à utiliser, et un bloc à exécuter lorsque l’indexage est terminé.

``` objc
@implementation IndexRequestHandler

- (void)searchableIndex:(CSSearchableIndex *)searchableIndex reindexAllSearchableItemsWithAcknowledgementHandler:(void (^)(void))acknowledgementHandler {
  // Reindex all data with the provided index
  acknowledgementHandler();
}

- (void)searchableIndex:(CSSearchableIndex *)searchableIndex reindexSearchableItemsWithIdentifiers:(NSArray <NSString *> *)identifiers acknowledgementHandler:(void (^)(void))acknowledgementHandler {
  // Reindex any items with the given identifiers and the provided index
  acknowledgementHandler();
}

@end
```

Il s’agit d’une extension, avec toutes les limitations qui vont avec. Pour une application utilisant Core Data, par exemple, il faudra placer les fichiers de persistance dans un conteneur partagé. 


## Pré-iOS 9

Enfin, n’oubliez pas que même si cette nouvelle API est uniquement disponible à partir d’iOS 9, vous pouvez l’utiliser dans une application supportant des versions antérieures (_deployment target_ < iOS 9). Il suffit de tester l’existence d’une des classes concernées avant de les utiliser dans votre code.

``` objc
if ([CSSearchableIndex class]) {
  // Spotlight OK
}
```


## Conclusion

Les APIs de recherche pour iOS 9 vont encore plus loin, en gérant également les activités et la correspondance avec des ressources web (_deep linking_).

Le code présenté dans cet article permet déjà une prise en charge à la fois simple et flexible. Si vous cherchiez un moyen d’améliorer vos applications sans remettre en question le support des OS précédents, Spotlight vous tend les bras.


## Documentation

- [_App Search Programming Guide: Index App Content_, Apple](https://developer.apple.com/library/prerelease/ios/documentation/General/Conceptual/AppSearch/AppContent.html#//apple_ref/doc/uid/TP40016308-CH7-SW1)
- [_Core Spotlight Framework Reference: CSSearchableIndex Class Reference_, Apple](https://developer.apple.com/library/prerelease/ios/documentation/CoreSpotlight/Reference/CSSearchableIndex_Class/index.html#//apple_ref/occ/instm/CSSearchableIndex/)
- [_Core Spotlight Framework Reference: CSSearchableItem Class Reference_, Apple](https://developer.apple.com/library/prerelease/ios/documentation/CoreSpotlight/Reference/CSSearchableItem_Class/index.html#//apple_ref/occ/cl/CSSearchableItem)
- [_Core Spotlight Framework Reference: CSSearchableItemAttributeSet Class Reference_, Apple](https://developer.apple.com/library/prerelease/ios/documentation/CoreSpotlight/Reference/CSSearchableItemAttributeSet_Class/index.html#//apple_ref/occ/cl/CSSearchableItemAttributeSet)

[ios 9 icon]: http://www.vtourraine.net/blog/img/2015/ios-9-indexer-spotlight/ios-9.png
[search result cell]: http://www.vtourraine.net/blog/img/2015/ios-9-indexer-spotlight/search-result-cell.png
[search results]: http://www.vtourraine.net/blog/img/2015/ios-9-indexer-spotlight/search-result-wake.png
[target spotlight]: http://www.vtourraine.net/blog/img/2015/ios-9-indexer-spotlight/target-spotlight.png