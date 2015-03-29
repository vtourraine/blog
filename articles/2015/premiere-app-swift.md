Title:    Bilan de ma première application Swift  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     March 29, 2015  
Update:   
Keywords: Swift, dev
Summary:  Je ne me suis pas franchement jeté sur Swift après l’annonce de la WWDC 2014, mais dotSwift est passé par là, et voici maintenant ma première application Swift disponible sur l’App Store (pour être précis, l’application principale est en Swift, l’extension du clavier est encore en Objective-C). À défaut d’être original, je pense que c’est le bon moment pour un premier bilan de ma courte expérience avec ce nouveau langage qui s’annonce, rappelons-le, comme l’avenir du développement pour les plateformes Apple.  
Image:    http://www.vtourraine.net/blog/img/2015/premiere-app-swift/swift-icon.png  
Language: fr  


Je ne me suis pas franchement jeté sur Swift après l’annonce de la WWDC 2014, mais [dotSwift](http://www.vtourraine.net/blog/2015/dotswift-swift) est passé par là, et voici maintenant ma première application Swift [disponible sur l’App Store](https://itunes.apple.com/app/scikey-scientific-keyboard/id927863083?mt=8) (pour être précis, l’application principale est en Swift, l’extension du clavier est encore en Objective-C).

![Icône Swift, image Apple][Icon Swift]

À défaut d’être original, je pense que c’est le bon moment pour un premier bilan de ma courte expérience avec ce nouveau langage qui s’annonce, rappelons-le, comme l’avenir du développement pour les plateformes Apple.


## Le moins bien :-(

Commençons par ce qui ne va pas, ou plutôt par ce qui n’est pas encore tout à fait au point. Je vous rassure tout de suite, je n’ai rien trouvé de rédhibitoire.

❋ Le langage évolue encore, de façon relativement significative, en ajustant sa syntaxe et sa sémantique. C’est très certainement nécessaire, mais c’est pour l’instant une forme de dette technique. J’ai crû comprendre que l’objectif était d’avoir un langage stable cette année pour sa version 2.0 (ce qu’on appellerait donc communément une version… 1.0, mais je pinaille). 

❋ J’ai vraiment envie de mettre un point virgule à la fin de chaque ligne;

❋ L’application exportée en `.ipa` est alourdie de plusieurs Mo. Cela s’explique par le fait que cette archive comprend une partie des bibliothèques Swift pour la version compilée de l’application. Elle assure ainsi sa rétro-compatibilité, indépendamment des évolutions du langage. 

❋ L’absence de fichiers header (`.h`). Globalement, c’est peut-être un point positif, mais on perd quand même la lisibilité d’un fichier qui servait justement à présenter une classe, sans avoir à se soucier de son implémentation. 

❋ Convertir un code Objective-C existant vers Swift est évidemment possible, bien que relativement pénible. Mais le vrai problème, c’est qu’on obtient alors une traduction littérale, qui ne capture pas vraiment les particularités et les avantages de Swift. Ça revient à mettre une couche de peinture sur une vieille maison, sans rien reconstruire. 

Même pour écrire de nouvelles fonctions ou de nouvelles applications, je continue à utiliser systématiquement les _patterns_ de l’ancien langage. Comme pour la Matrice, il va falloir désapprendre ce qu’on a appris, avant de passer aux choses vraiment intéressantes. Ça va forcément demander du temps.


## Le bien :-)

❋ Surprise : Xcode relativement stable. Ça reste Xcode, avec quelques crashs supplémentaires, mais ce n’est pas la catastrophe ambulante des premiers jours.

❋ Plutôt facile d’importer du code Objective-C dans du code Swift. Tout repose sur un « bridging header », qui regroupe tous les fichiers concernés, qui deviennent ainsi accessibles par le code Swift.

❋ Les `enum` avec une syntaxe sensée. On passe par exemple de `UITableViewCellStyleDefault` à `UITableViewCellStyle.Default`.  Oui, la différence est subtile, mais elle est bienvenue. Ça ne nous sauvera pas totalement de l’autocomplétion Xcode, mais c’est un peu de bon sens qui s’applique constamment. Les `switch` y gagnent aussi en concision :

``` swift
directionToHead = .South
switch directionToHead {
  case .North:
    println("Lots of planets have a north")
  case .South:
    println("Watch out for penguins")
}
```

❋ En parlant d’`enum`, il faut dire qu’ils n’ont plus grand chose à voir avec leur ancienne forme héritée directement du C, et disposent maintenant de « valeurs associées » qui ouvrent des possibilités de modélisation inédites.

❋ Des constantes plus souples. Il est toujours préférable d’utiliser des constantes plutôt que des variables, lorsque la situation le permet. Exemple fréquent : je souhaite déclarer une constante, mais dont la valeur dépend d’un conditionnel. Magie du compilateur avec Swift, si mon code ne présente pas d’ambiguïté, je peux affecter la valeur de ma constante plus tard. 

``` swift
let myConstant
if ... {
  myConstant = A
}
else {
  myConstant = B
}
```

C’est encore mieux d’éviter les conditionnels, mais dans un cas comme celui-ci, le code Swift est nettement plus rigoureux, sans réel équivalent Objective-C.

❋ Les collections typées. Moins d’ambiguïté = moins de bugs.

❋ Une petite révélation en ce qui me concerne : les « higher-order functions », _a.k.a_ méta-fonctions, _a.k.a_ super-fonctions. 

Imaginons une classe `Person`, avec une `@property` `identifier`. Je dispose d’un `NSArray` de `Person`, et je veux un nouveau `NSArray` contenant uniquement les `identifiers`. C’est le genre de manipulation qui arrive constamment. Ce n’est pas compliqué à implémenter en Objective-C, mais ce n’est pas très élégant. Typiquement, vous créez un `NSMutableArray`, vous énumérez les membres du tableau d’origine, et vous ajoutez les valeurs dans le nouveau tableau, que vous pourrez finalement transformer en tableau non-mutable. Avec Swift, vous pouvez utiliser `map` pour exprimer directement, exactement, la même chose.

``` swift
let persons = [Person(identifier: "A"), Person(identifier: "B")]
let identifiers = map(persons, {$0.identifier})
print(identifiers) // ["A", "B"]
```

Boom. De la même façon, il existe notamment `sort`, `filter` et `reduce`, tous très utiles. 

Il y a sûrement un risque, avec ces fonctions comme avec la plupart des concepts propres à Swift, de favoriser une écriture trop compacte, au détriment de la clarté du code. L’Objective-C et Cocoa (Touch) sont verbeux pour une bonne raison. Swift permet de se débarrasser de certaines formes ampoulées, j’espère simplement que nous n’allons pas tomber dans l’excès inverse.

❋ Enfin, on peut constater que de nombreux développeurs ont déjà bien expérimenté avec Swift, ce qui permet de trouver facilement de l’aide et des références en ligne, sur Stack Overflow comme ailleurs. 

On savait qu’Apple pouvait convaincre beaucoup de monde de l’intérêt d’acheter une montre en 2015, on sait maintenant qu’ils peuvent aussi convaincre de nombreux développeurs d’essayer un nouveau langage de programmation. 


[Icon Swift]: http://www.vtourraine.net/blog/img/2015/premiere-app-swift/swift-icon.png  
