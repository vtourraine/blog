# Generics avec Objective-C

Après les [_nullability annotations_](http://www.vtourraine.net/blog/2015/objective-c-nullability) d’Xcode 6.3, voici les _generics_ d’Xcode 7. 

L’intention est la même : faire évoluer Objective-C pour faciliter son interopérabilité avec Swift. Avec, au passage, l’occasion d’améliorer la qualité du code Objective-C pour lui-même, en permettant à Xcode de détecter toute une nouvelle catégorie de bugs.


## Pourquoi

Les _generics_ Objective-C sont des annotations qui permettent de préciser le type d’objets appartenant à une collection.

En effet, les `NSArray`, `NSSet` et `NSDictionary` peuvent a priori mélanger des instances de différentes classes. Cette souplesse a incontestablement des avantages, mais elle est aussi la source de nombreux problèmes. Pire, il s’agit souvent de bugs à retardement liés à des contextes d’exécution partuliers, donc difficiles à corriger par la suite. Des soucis qu’on peut maintenant facilement éviter grâce à ces annotations.


## Comment

Tout se passe au moment de la déclaration, en précisant la classe attendue entre chevrons :

``` objc
// Property
@property NSArray <NSDate *> *dates;

// Argument
- (void)doSomething:(NSDictionary <NSURL *, NSData *> *)cachedData;

// Variable
NSSet <NSString *> *words = nil;
```

Dans cet exemple, on attend donc un tableau de `NSDate`, un dictionnaire avec des clés `NSURL` et des valeurs `NSData`, et enfin un set de `NSString`.

Vous pouvez également utiliser le mot clé `__kindof` pour étendre cette définition à toutes les classes qui en héritent.

Détail important : comme pour le type d’une variable classique, il ne s’agit que d’une déclaration, pas d’une contrainte absolue. Les _generics_ ne garantissent pas dynamiquement le contenu d’une collection. En revenche, le compilateur utilise cette information pour repérer les cas non-conformes, et émettre des _warnings_ (⚠️) en conséquence. 

![Warnings Xcode][Xcode warning]

Comme on peut le voir sur cet exemple, Xcode ne s’arrête pas à l’affectation de valeurs, mais contrôle également les méthodes de manipulation de la collection, comme ici le `arrayByAddingObject:`.


## Interopérabilité Swift

Xcode permet à Swift d’importer du code Objective-C. Ces annotations permettent donc de conserver la richesse de la syntaxe des collections Swift, par opposition à un import classique qui se contenterait d’un ensemble de `AnyObject`.

Pour reprendre les trois exemples donnés ci-dessus, voici ce que donnent les déclarations Swift correspondantes :

``` swift
var dates: [NSDate]
// ...
func doSomething (words: Set<String>) {}
// ...
var cachedData: [NSURL: NSData]
```


## // Surcharge la syntaxe ObjC à cause de Swift ?

Les _generics_ ne font pas l’unanimité chez les développeurs Objective-C. Combinés aux _nullability annotations_, on peut effectiver regretter une baisse de lisibilité pour la déclaration des variables. Pour un langage déjà verbeux, ces nouveautés peuvent facilement doubler le nombre de caractères nécessaires par déclaration.

À mes yeux, ce compromis est largement justifié. Personne ne choisit de déclarer toutes ses variables en `id`, simplement pour gagner en lisibilité.

On trouvait souvent des documentations précisant le type attendu pour les variables d’une collection.

// Pour soi

// Pour les autres (API) (imaginez utiliser tout en `id`)

// Mieux qu’une documentation



- [What’s New in Xcode: New Features in Xcode 7, Apple](https://developer.apple.com/library/prerelease/ios/documentation/DeveloperTools/Conceptual/WhatsNewXcode/Articles/xcode_7_0.html)
- [Using Swift with Cocoa and Objective-C: Interacting with Objective-C APIs, Apple](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithObjective-CAPIs.html#//apple_ref/doc/uid/TP40014216-CH4-ID35)

[Xcode warning]: http://www.vtourraine.net/blog/img/2015/objective-c-generics/xcode-warnings.png
