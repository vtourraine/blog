Title:    Structurer un code Objective-C  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     October 25, 2014  
Update:   
Keywords: code, dev, Objective-C, Cocoa
Summary:  La qualité d’un code source est avant tout une question de structure. Lorsque je relis un code (notamment le mien), mon premier reproche concerne très souvent le manque de structure. Il n’existe pas de solution universelle, mais les bonnes pratiques en la matière permettent vraiment de développer plus efficacement, seul ou à plusieurs sur un projet. Voici donc un résumé des points qui me paraissent les plus importants pour bien structurer un code Objective-C.  
Image:    
Language: fr  
Project:    

La qualité d’un code source est avant tout une question de structure. Lorsque je relis un code (notamment le mien), mon premier reproche concerne très souvent le manque de structure. Il n’existe pas de solution universelle, mais les bonnes pratiques en la matière permettent vraiment de développer plus efficacement, seul ou à plusieurs sur un projet. 

Voici donc un résumé des points qui me paraissent les plus importants pour bien structurer un code Objective-C.


## Le header

Tout commence avec le fichier d’en-tête, `.h`, qui a la lourde tâche de présenter la classe. Avant toute chose, ce fichier ne doit contenir que le strict minimum, ni plus, ni moins. On doit y déclarer essentiellement deux types d’information : les propriétés et les méthodes.

Pour stocker les variables d’instance, il est vraiment préférable de n’utiliser que des propriétés `@property`, et de laisser tomber les `ivar`. N’hésitez-pas à déclarer en lecture seule (`readonly`) toutes celles qui le permettent, et préférez les types immuables autant que possible (par exemple `NSArray` plutôt que `NSMutableArray`). Ces paramètres favorisent un code plus précis, et donc plus efficace.

Du côté des méthodes, on trouve généralement un initialiseur, qui permet d’indiquer au développeur comment bien instancier un objet. On peut en profiter pour passer des propriétés en lecture seule déclarées juste avant, pour des variables de configuration par exemple. Pour économiser des `alloc/init` et faciliter la création d’instances, on peut aussi proposer des constructeurs similaires à `[NSString stringWithFormat:]` ou `[NSArray array]`. On aura sûrement besoin d’autres méthodes, notamment les “actions” pour un view controller, qui seront reliées aux différents éléments d’interface.

Voici un exemple de ce que cela peut donner concrètement :

``` objc
@import UIKit;

@interface MyController : UIViewController

@property (nonatomic, strong, readonly) Context *context;

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UIButton *createButton;

- (instancetype)initWithContext:(Context *)context;
+ (instancetype)controllerWithContext:(Context *)context;

- (IBAction)createStuff:(id)sender;

@end
```

On peut aussi garder à l’esprit que tout ce qui apparaît dans l’en-tête doit être testable (mieux : testé). Les comportements observables de l’object doivent être conformes aux attentes, et les tests unitaires sont là pour s’en assurer. On dit parfois que le header est une sorte de contrat passé entre l’auteur du code et tout ce qui interagit avec cette classe. Tout le monde se porte mieux si ce contrat reste court, précis et clair.


## Le header privé

Il existe une technique très utile permettant d’utiliser un en-tête privé pour toutes les déclarations qui doivent rester cachées. Encore une fois, il s’agit de limiter autant que possible les déclarations publiques. Mais comment faire alors pour déclarer tout ce dont on a besoin pour faire fonctionner la classe ? En haut de votre fichier d’implémentation, `.m`, déclarez une catégorie anonyme sur votre classe. Vous pouvez alors y inclure de nouvelles propriétés et de nouvelles méthodes qui resteront invisibles de l’extérieur.

``` objc
@interface MyController ()

@property (nonatomic, strong, readwrite) Context *context;

- (NSString *)generateRandomName;

@end
```

Comme le montre cet exemple, vous pouvez même en profiter pour re-déclarer une propriété, publiquement en lecture-seule, pour l’utiliser en privé en lecture-écriture. Il s’agira bien de la même variable, mais vous en simplifiez l’utilisation en la limitant à la lecture pour un code externe.


## Découper avec #pragma mark

Dans n’importe quel texte et pour n’importe quel domaine, vous trouvez des sections pour structurer un ensemble. Dans le cas d’une classe Objective-C, il existe une instruction qui remplit bien ce rôle : le `#pragma mark`. Comme tout ce qui est précédé par un “#”, il s’agit d’une instruction pour le pré-processeur C, qui est donc traitée avant la compilation du code. Dans ce cas précis, c’est une simple décoration, qui n’a donc aucun impact sur le reste du code ou même sur la compilation elle-même. En revanche, cette instruction est notamment reconnue par Xcode, qui l’interprète comme une marque de mise en forme pour le navigateur de code. En bonus, les tirets “-” sont traités comme des barres horizontales de séparation.

![Xcode code navigation][Xcode navigation]

On peut tout de même noter pour les plus curieux que Clang (le compilateur utilisé par Xcode) utilise dans certains cas #pragma pour configurer localement des paramètres, comme indiqué dans [sa documentation][LLVM Pragmas].

Mes view controllers commencent généralement par une section “view lifecycle” qui contient le `init`, le `viewDidLoad`, et les `viewDid/Will/Appear/Disappear`. Ensuite, une section “configuration” regroupe les méthodes de mise en place des vues et de coordination avec le modèle. Viennent ensuite les “actions”, qui pourront être invoquées avec les différents boutons ou événements attachés au controller. Enfin, j’organise classiquement une section par protocole implémenté par la classe. Pour un `UITableViewController`, on y retrouve bien sûr le `UITableViewDelegate` et `UITableDataSource`, mais il en existe bien d’autres, pour répondre à un `UIAlertView` ou un `MFMailComposeViewController` par exemple.

## Découpage

La longueur du code n’est pas un problème en soi, a fortiori avec Objective-C et Cocoa qui assument fièrement leur caractère verbeux, mais elle peut souvent être symptomatique d’un certain manque d’organisation. De mon point de vue, quand un view controller dépasse les 1000 lignes de code, il faut commencer à songer à en séparer certains aspects. Pour un modèle ou une vue, le seuil est plutôt vers 100 LoC. C’est aussi dans cette situation que l’organisation en `#pragma` se révèle utile, puisqu’on devrait pouvoir découper la plupart des sections vers des classes dédiées.

Ce re-découpage nécessite parfois d’exposer davantage de propriétés ou de méthodes afin de conserver le même fonctionnement réparti sur plusieurs objects. Encore une fois, il convient de limiter les portes d’entrée de vos classes, mais un fichier trop volumineux est également problématique à terme. Il s’agit donc de trouver un équilibre satisfaisant, pour faire le tri entre ce qui constitue une interface et ce qui tient du détail d’implémentation.

Comme c’est parfois le cas avec Cocoa, il peut être intéressant de regrouper certaines parties d’une classe à l’intérieur d’une catégorie. C’est particulièrement approprié quand un ensemble de méthodes apporte une nouvelle dépendance, par exemple lorsque NSString se base sur UIKit pour dessiner une chaîne de caractères.

Cette technique a ses avantages et ses inconvénients. On peut facilement y mettre des méthodes de configuration, qui vont globalement agir sur des propriétés déjà déclarées, ou générer un résultat à partir de certains paramètres. Par contre, on ne peut pas utiliser une catégorie pour déclarer de nouvelles propriétés, et ses méthodes ne pourront pas être surchargées par une sous-classe (certes, il existe des techniques pour contourner ces limitations, mais ça ne me paraît vraiment pas correspondre à une bonne pratique).


## Conclusion

Autant de pistes différentes et souvent complémentaires pour structurer un code source, et garantir un bon niveau de qualité. Pour les autres, mais avant tout pour soi.

Évidemment, ce ne sont que mes modestes recommandations. Si vous avez d’autres suggestions, ou mieux, si vous avez des contre-arguments concernant les points évoqués, les commentaires sont là pour ça.


[Xcode navigation]: http://www.vtourraine.net/blog/img/structure-code-objective-c/xcode-navigation.png
[LLVM Pragmas]:     http://clang.llvm.org/docs/UsersManual.html#controlling-diagnostics-via-pragmas