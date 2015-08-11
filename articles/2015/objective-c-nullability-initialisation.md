Title:     Nullability et initialisation  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      August 9, 2015  
Update:    
Keywords:  Objective-C, Xcode, dev
Summary:   …  
Image:     http://www.vtourraine.net/blog/img/2015/objective-c-nullability/xcode-icon.png  
Language:  fr  


Mon dernier billet de blog présentait les [_nullability annotations_](http://www.vtourraine.net/blog/2015/objective-c-nullability), en essayant d’expliquer comment elles contribuent à améliorer un code Objective-C. Avec un peu de recul, et après davantage de temps passé à les mettre en pratique, ces annotations me posent _un_ problème. Un cas particulier, peut-être, mais absolument incontournable, puisqu’il s’agit de l’initialisation des variables.


## if (self)

L’implémentation d’un constructeur commence habituellement comme ceci :

```objc
- (instancetype)init {
  self = [super init];
  if (self) {
    // …
  }
  return self;
}
```

Rien de surprenant, il s’agit même du template fourni par Xcode. Pourtant, ce conditionnel au milieu de la méthode soulève une question intéressante : 

**Que se passe-t-il quand l’initialisation d’un objet échoue ?**

Soit la classe parent retourne `nil`, soit elle émet une exception.

Ce template a justement pour but de gérer ce premier cas, pour empêcher de poursuivre l’initialisation inutilement. Le problème vient alors potentiellement du code qui initialise l’objet sans considérer la possibilité d’un échec. La neutralité d’Objective-C vis-à-vis des variables nulles permet généralement de s’en tirer sans trop de problèmes, mais on voit bien comme les _nullability annotations_ exposent ce cas particulier, et nous encouragent à fournir une solution explicite.


## « nonnull » ou « nullable » ?

Pour formuler le problème différemment : la valeur de retour d’un constructeur doit-elle être annotée `nonnull` ou `nullable` ?

L’en-tête de `NSObject` pour le SDK iOS 9 ne tranche pas, mais celui pour `UIView`, par exemple, fournit un début de réponse :

``` objc
NS_ASSUME_NONNULL_BEGIN
// (…)
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
// (…)
NS_ASSUME_NONNULL_END
```

Réponse : les deux. Ça paraît tout à fait raisonnable, puisque selon la signification et/ou le contexte des paramètres passés, on peut facilement imaginer les deux situations (pour `UIView`, le constructeur fonctionne quel que soit le `CGRect` donné, même avec `CGRectZero`, mais on ne peut pas en dire autant pour un `NSCoder *`, dont le contenu est totalement indéterminé au moment de la compilation).

Le cas du `nullable` est assez banal et inintéressant, mais peut-il vraiment y avoir un constructeur avec retour `nonnull` ? 

Le principe de constructeur désigné devrait en théorie nous donner une réponse. Hélas, `init` n’est pas marqué comme `NS_DESIGNATED_INITIALIZER` pour `NSObject` (et sa valeur n’est pas annotée, ce qui nous laisse dans le flou complet). Le cas de `NSObject` est d’autant plus incertain que l’en-tête varie pour une même version du SDK entre celui trouvé dans `usr/include/objc` et dans `Frameworks/Foundation.framework/Headers`. On y découvre même un magnifique `#if NS_ENFORCE_NSOBJECT_DESIGNATED_INITIALIZER`.


## Logique ?

Si `initWithFrame:` de `UIView` est marquée avec `nonnull`, on peut alors logiquement attendre la même chose de `init` pour `NSObject`, le constructeur le plus élémentaire qui soit. Si votre classe hérite de `NSObject`, alors votre constructeur doit pouvoir déclarer la même chose, assurer un retour `nonnull`. Dans ce cas, le `if (self) {}` du template évoqué au début de ce billet n’a plus de sens.

J’aimerais beaucoup que ce soit le cas, qu’on puisse ainsi simplifier les classes concernées en éliminant ces conditionnels superflus. Tous les `if` sont des sources de bugs, et un `nonnull` catégorique est largement préférable à un `nullable` indéterminé.

Mais cette petite réflexion a des allures de simplification optimiste, qui met à mal l’intérêt des _nullability annotations_. Le compilateur peut donner des indications précieuses, encore faut-il que les suppositions de base soient fondées. Entre les bonnes pratiques habituelles et les avantages potentiels d’une nouvelle approche plus exigeante, mon code hésite. 

Vos remarques et conseils sont, évidemment, les bienvenus.


### Liens

- [_Object Initialization_, Apple](https://developer.apple.com/library/ios/documentation/General/Conceptual/CocoaEncyclopedia/Initialization/Initialization.html)
- [_Nullability and Inherited Initializers in Objective-C_, Cocoa at Tumblr](http://cocoa.tumblr.com/post/117719761353/nullability-and-inherited-initializers-in-objective-c)
