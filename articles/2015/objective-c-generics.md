Title:     Generics avec Objective-C  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      November 26, 2015  
Update:    
Keywords:  Objective-C, Xcode, dev
Summary:   Après les « nullability annotations » d’Xcode 6.3, voici les « generics » d’Xcode 7. L’intention est la même : faire évoluer Objective-C pour faciliter son interopérabilité avec Swift. Avec, au passage, l’occasion d’améliorer la qualité du code Objective-C pour lui-même, en permettant à Xcode de détecter toute une nouvelle catégorie de bugs.    
Image:     http://www.vtourraine.net/blog/img/2015/objective-c-generics/xcode-warnings.png  
Language:  fr  


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
- (void)doSomething:(NSSet <NSString *> *)words;

// Variable
NSDictionary <NSURL *, NSData *> *cachedData = nil;
```

Dans cet exemple, on attend donc un tableau de `NSDate`, un set de `NSString`, et enfin un dictionnaire avec des clés `NSURL` et des valeurs `NSData`.

Vous pouvez également utiliser le mot clé `__kindof` pour étendre cette définition à toutes les classes qui en héritent.

Détail important : comme pour le type d’une variable classique, il ne s’agit que d’une déclaration, pas d’une contrainte absolue. Les _generics_ ne garantissent pas dynamiquement le contenu d’une collection. En revenche, le compilateur utilise cette information pour repérer les cas non-conformes, et émettre des _warnings_ (⚠️) en conséquence. 

![Warnings Xcode][Xcode warning]

Comme on peut le voir sur cet exemple, Xcode ne s’arrête pas à l’affectation de valeurs, mais contrôle également les méthodes de manipulation de la collection, comme ici le `arrayByAddingObject:`.


## Interopérabilité Swift

Xcode permet à Swift d’importer du code Objective-C. Ces annotations permettent donc de conserver la richesse de la syntaxe des collections Swift, par opposition à un import classique qui doit se contenter d’un ensemble de `AnyObject`.

Pour reprendre les trois exemples donnés ci-dessus, voici ce que donnent les déclarations Swift correspondantes :

``` swift
var dates: [NSDate]

func doSomething (words: Set<String>) {}

var cachedData: [NSURL: NSData]
```


## Effort supplémentaire

Les _generics_ ne font pas l’unanimité chez les développeurs Objective-C. Combinés aux _nullability annotations_, on peut effectiver regretter une baisse significative de lisibilité du code concerné. Pour un langage déjà verbeux, ces nouveautés ont facilement tendance à doubler le nombre de caractères nécessaires par déclaration.

À mes yeux, ce compromis est largement justifié. Personne ne choisit de déclarer toutes ses variables en `id`, simplement pour gagner en lisibilité.

Quand une API manipule une collection (comme paramètre d’une méthode, par exemple), la documentation indique généralement le type attendu pour ses membres. Cette précision est cruciale, puisque que le passage d’un autre type peut facilement faire crasher l’application. Mais la documentation n’a aucun poids sur la compilation, alors que les _generics_ permettront à Xcode de contrôler directement le code concerné.

C’est important pour interagir avec un code tiers, venant d’Apple ou d’un autre développeur, mais aussi pour soi-même, afin de produire un code plus clair et donc de meilleure qualité. 


## Documentation

- [What’s New in Xcode: New Features in Xcode 7, Apple](https://developer.apple.com/library/prerelease/ios/documentation/DeveloperTools/Conceptual/WhatsNewXcode/Articles/xcode_7_0.html)
- [Using Swift with Cocoa and Objective-C: Interacting with Objective-C APIs, Apple](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithObjective-CAPIs.html#//apple_ref/doc/uid/TP40014216-CH4-ID35)

[Xcode warning]: http://www.vtourraine.net/blog/img/2015/objective-c-generics/xcode-warnings.png
