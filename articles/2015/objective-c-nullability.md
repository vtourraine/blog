Title:     Nullability avec Objective-C  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      July 19, 2015  
Update:   
Keywords:  Objective-C, dev
Summary:   ...  
Image:     
Language:  fr  

J’adore quand Xcode trouve des bugs dans mon code. Ça me donne l’impression qu’une AI passe mon travail en revue, et m’aide à l’améliorer. Le pair-programming du futur, sans doute.

Objective-C est un vieux langage qui a beaucoup évolué, encore récemment. On pouvait penser que l’arrivée de Swift allait marquer la fin de cette longue progression. C’est tout le contraire, en particulier avec certaines améliorations venues de Swift qui bénéficient déjà à Objective-C. 

C’est le cas des _nullability annotations_. Il s’agit d’annoter les interface de vos classes et les déclarations de vos méthodes pour lever certaines ambiguïtés. 


## nil

Objective-C a une gestion assez particulière de la valeur `nil` (devrais-je dire de l’absence de valeur ?). Invoquer une méthode sur une variable à `nil` sera simplement ignoré, ce qui constitue en soi un pattern couramment utilisé.

Pour autant, un certain nombre de méthodes — notamment dans Foundation, UIKit ou AppKit — déclarent ne pas supporter un argument à `nil`. Prenez par exemple la méthode `addObject:` de `NSMutableArray`. Si vous essayez d’y ajouter une valeur à `nil`, c’est le crash assuré. La documentation a toujours été claire, mais le compilateur ne pouvait pas y faire grand chose.

> « (…) This value must not be nil.  
> **IMPORTANT: Raises an `NSInvalidArgumentException` if _anObject_ is `nil`.** »  
> [NSMutableArray Class Reference](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSMutableArray_Class/#//apple_ref/occ/instm/NSMutableArray/addObject:)

Avec Xcode 6.3, Apple a donc ajouté le concept de _nullability annotation_. Pour faire simple, il existe deux états possibles : `nullable` ou `nonnull`. Le premier indique que la valeur associée peut être `nil`, le second qu’une valeur à `nil` est considérée comme invalide. Avec ça, Xcode peut enfin faire les vérifications nécessaires, et ainsi éviter de nombreux bugs potentiels.


## En pratique

Il suffit donc d’ajouter le mot clé adéquat aux paramètres et valeurs de retour des méthodes, ainsi qu’aux `@property`.

``` objc
- (nullable AAPLListItem *)itemWithName:(nonnull NSString *)name;
- (NSInteger)indexOfItem:(nonnull AAPLListItem *)item;

@property (copy, nullable) NSString *name;
@property (copy, readonly, nonnull) NSArray *allItems;
```

Pour les paramètres des blocks, ça se complique très légèrement.

``` objc
- (void)methodWithArg:(nonnull NSString *)arg1 
             andArg:(nullable NSString *)arg2
  completionHandler:(nullable void (^)(NSArray * __nullable results, NSError * __nonnull error))completionHandler;
```

Vous pouvez aussi déclarer des régions comme auditées non-nulles avec `NS_ASSUME_NONNULL_BEGIN` et `NS_ASSUME_NONNULL_END`, où tout sera traité comme non `nonnull`, sauf contrindication. 

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

À l’inverse, on remarquera qu’il n’existe pas de mot clé pour des régions auditées `nullable`, puisque n’importe quel code Objective-C l’est déjà, par définition.

Enfin, il faut noter qu’Xcode vous encouragera à annoter complètement une interface de classe, avec un _warning_ qui apparaîtra si vous commencez à annoter une classe sans identifier l’intégralité des méthodes et propriétés. 


## Swift-ification

Apple présente cette nouveauté comme un lien entre Objective-C et Swift. Les bénéfices en termes de qualité de code justifient à eux seuls cet ajout, mais la correspondance avec Swift apporte une perspective intéressante.

Le concept des _optionnels_ joue un rôle important avec Swift. Si je peux le résumer grossièrement, il s’agit d’un type d’objet pouvant être associé à deux états : nul, ou non-nul. La contrepartie veut donc qu’un objet non optionnel aura toujours une valeur, ce qui constitue une différence importante par rapport à Objective-C. Avec les _nullability annotations_, il devient possible d’exprimer des contraintes similaires avec Objective-C, ce qui améliore significativement l’interopérabilité entre les deux langages.


## À vous de jouer

Ces nouveaux mots clés sont disponibles à partir d’Xcode 6.3. Peu importe la version d’iOS ou d’OS X ciblée, il est toujours conseillé d’utiliser la dernière version stable disponible, tout le monde peut donc profiter de cette nouveauté dès maintenant.



https://developer.apple.com/swift/blog/?id=25