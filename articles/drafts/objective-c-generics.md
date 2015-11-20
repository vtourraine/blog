# Generics avec Objective-C

Après les _nullability annotations_ d’Xcode 6.3, voici les _generics_ d’Xcode 7. L’intention est la même :faire évoluer Objective-C pour améliorer son interopérabilité avec Swift. 

## En théorie

Les _generics_ Objective-C sont des annotations qui permettent de préciser le type d’objet appartenant à une collections.

En effet, les `NSArray`, `NSSet` et `NSDictionary` peuvent a priori mélanger des objets de différentes classes. Cette souplesse a incontestablement des avantages, mais elle est aussi la source de nombreux problèmes. Pire, il s’agit souvent de bugs à retardement liés à des contextes d’exécution partuliers, donc difficiles à corriger par la suite. Des soucis qu’on peut maintenant facilement éviter grace à ces annotations.


## En pratique

Tout se passe au moment de la déclaration, pour une `property` comme pour une variable locale, en précisant la classe attendue entre chevrons :

``` objc
@property NSArray <NSDate *> *dates;
@property NSDictionary <NSURL *, NSData *> *cachedData;

// ...

NSSet<NSString *> *words = nil;
```

Dans cet exemple, on attend donc un tableau de `NSDate`, un dictionnaire avec des clés `NSURL` et des valeurs `NSData`, et enfin un set de `NSString`.

Un peu comme pour le type d’une variable, il ne s’agit que d’une déclaration. Les generics ne garantissent pas dynamiquement le contenu d’une collection. En revenche, le compilateur utilise cette information pour repérer les cas non-conformes. 


## // Surcharge la syntaxe ObjC à cause de Swift ?


--

## Lightweight Generics

Objective-C declarations of NSArray, NSSet and NSDictionary types using lightweight generic parameterization are imported by Swift with information about the type of their contents preserved.

For example, consider the following Objective-C property declarations:

```` objc
@property NSArray<NSDate *> *dates;
@property NSSet<NSString *> *words;
@property NSDictionary<NSURL *, NSData *> *cachedData;
```

Here’s how Swift imports them:

``` swift
var dates: [NSDate]
var words: Set<String>
var cachedData: [NSURL: NSData]
```

NOTE: Aside from these Foundation collection classes, Objective-C lightweight generics are ignored by Swift. Any other types using lightweight generics are imported into Swift as if they were unparameterized.

--

- [What’s New in Xcode: New Features in Xcode 7, Apple](https://developer.apple.com/library/prerelease/ios/documentation/DeveloperTools/Conceptual/WhatsNewXcode/Articles/xcode_7_0.html)
- [Using Swift with Cocoa and Objective-C: Interacting with Objective-C APIs, Apple](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithObjective-CAPIs.html#//apple_ref/doc/uid/TP40014216-CH4-ID35)
