Title:     Nullability avec Objective-C  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      July 26, 2015  
Update:    
Keywords:  Objective-C, Xcode, dev
Summary:   J’adore quand Xcode trouve des bugs dans mon code. C’est un peu comme si une IA passait mon travail en revue pour m’aider à l’améliorer. Le pair-programming du futur, sans doute.    
Image:     http://www.vtourraine.net/blog/img/2015/objective-c-nullability/xcode-icon.png  
Language:  fr  

J’adore quand Xcode trouve des bugs dans mon code. C’est un peu comme si une IA passait mon travail en revue pour m’aider à l’améliorer. Le pair-programming du futur, sans doute.

Objective-C est un vieux langage qui a beaucoup évolué, encore récemment. On pouvait penser que l’arrivée de Swift allait marquer la fin de cette longue progression. Fausse alerte, visiblement, puisque certaines améliorations venues de Swift bénéficient déjà à Objective-C. 

C’est le cas avec les _nullability annotations_. Il s’agit d’annoter les interface de vos classes et les déclarations de vos méthodes pour lever certaines ambiguïtés, et ainsi faciliter le travail du compilateur. 

![Icône Xcode, image Apple][Xcode icon]


## nil

Objective-C a une gestion assez particulière de la valeur `nil` (devrais-je dire de l’absence de valeur ?). Invoquer une méthode sur une variable à `nil` sera simplement ignoré, ce qui constitue en soi un pattern couramment utilisé.

Pour autant, un certain nombre de méthodes — notamment dans Foundation, UIKit ou AppKit — déclarent ne pas supporter un argument à `nil`. Prenez par exemple la méthode `addObject:` de `NSMutableArray`. Si vous essayez d’y ajouter une valeur à `nil`, c’est le crash assuré. La documentation a toujours été claire, mais le compilateur ne pouvait pas y faire grand chose.


## En théorie

Avec Xcode 6.3, [Apple a ajouté le concept de _nullability annotation_][Blog].

Pour faire simple, il existe deux états possibles : `nullable` ou `nonnull`. Le premier indique que la valeur associée peut être `nil`, le second que `nil` est considéré comme invalide. Avec ça, Xcode peut enfin faire les vérifications nécessaires, et ainsi éviter de nombreux bugs potentiels.

![Détection _nonnull_ avec Xcode][Xcode nullability warning]


## En pratique

Il suffit donc d’ajouter le mot clé adéquat dans les interfaces de classes, pour les paramètres et valeurs de retour des méthodes, ainsi qu’aux `@property`.

``` objc
- (nullable AAPLListItem *)itemWithName:(nonnull NSString *)name;
- (NSInteger)indexOfItem:(nonnull AAPLListItem *)item;

@property (copy, nullable) NSString *name;
@property (copy, readonly, nonnull) NSArray *allItems;
```

Pour les paramètres des blocks, ça se complique très légèrement (notez le double underscore).

``` objc
- (void)methodWithArg:(nonnull NSString *)arg1 
             andArg:(nullable NSString *)arg2
  completionHandler:(nullable void (^)(NSArray * __nullable results, NSError * __nonnull error))completionHandler;
```

Vous pouvez aussi déclarer des régions comme auditées non-nulles avec `NS_ASSUME_NONNULL_BEGIN` et `NS_ASSUME_NONNULL_END`. Tout y sera traité comme `nonnull`, sauf contrindication. 

``` objc
NS_ASSUME_NONNULL_BEGIN
@interface AAPLList : NSObject <NSCoding, NSCopying>
- (nullable AAPLListItem *)itemWithName:(NSString *)name;
- (NSInteger)indexOfItem:(AAPLListItem *)item;

@property (copy, nullable) NSString *name;
@property (copy, readonly) NSArray *allItems;
@end
NS_ASSUME_NONNULL_END
```

À l’inverse, on remarquera qu’il n’existe pas de mot clé pour des régions auditées `nullable`, puisque n’importe quel code Objective-C existant l’est déjà, par définition.

Enfin, il faut savoir qu’Xcode vous encouragera à annoter complètement une interface de classe, avec un _warning_ qui apparaîtra si vous commencez à annoter une classe sans identifier l’intégralité des méthodes et propriétés concernées. 


## Swift-ification

Apple présente cette nouveauté comme un lien entre Objective-C et Swift. Les bénéfices en termes de qualité de code justifient à eux seuls cet ajout, mais la correspondance avec Swift apporte une perspective intéressante.

Le concept des _optionnels_ joue un rôle important avec Swift. Si je peux le résumer grossièrement, il s’agit d’un type d’objet pouvant être associé à deux états : nul, ou non-nul. La contrepartie veut donc qu’un objet non optionnel aura toujours une valeur, ce qui constitue une différence importante par rapport à Objective-C. Avec les _nullability annotations_, il devient possible d’exprimer des contraintes similaires avec Objective-C, ce qui améliore significativement l’interopérabilité entre les deux langages.

Objective-C continuera vraisemblablement à s’éclipser au profit de Swift. Mais cette transition prendra des années, et peu de développeurs peuvent se permettre de réécrire un projet existant. Avec les _nullability annotations_, il est possible de bénéficier de certains avantages de Swift, tout en conservant son code, et en le préparant pour les évolutions futures. Autant de bonnes raisons de faire un petit effort.


## À vous de jouer

Ces nouveaux mots clés sont disponibles à partir d’Xcode 6.3. Peu importe la version d’iOS ou d’OS X ciblée, il est toujours conseillé d’utiliser la dernière version stable disponible. Tout le monde peut donc profiter de cette nouveauté dès maintenant. 

Je ne vais pas prétendre que les _nullability annotations_ vont résoudre tous vos bugs, loin de là, mais ils constituent clairement un progrès pour la qualité et la sécurité du code. On peut les voir comme autant de tests unitaires qui seront vérifiés à chaque compilation. Tout ça pour le prix d’un mot clé.

_À la rentrée, [Xcode 7][Xcode 7] apportera une nouvelle avancée héritée de Swift : les « generics ». Qui sont-ils ? Que nous veulent-ils ? Les réponses dans un prochain billet de blog._


[Blog]: https://developer.apple.com/swift/blog/?id=25
[Xcode 7]: https://developer.apple.com/library/prerelease/ios/documentation/DeveloperTools/Conceptual/WhatsNewXcode/Articles/xcode_7_0.html

[Xcode icon]: http://www.vtourraine.net/blog/img/2015/objective-c-nullability/xcode-icon.png
[Xcode nullability warning]: http://www.vtourraine.net/blog/img/2015/objective-c-nullability/xcode-nullability-warning.png