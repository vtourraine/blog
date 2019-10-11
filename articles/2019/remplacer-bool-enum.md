Title:     Remplacer les Bool par des enum  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      March 25, 2019  
Update:    
Keywords:  dev, Swift, Objective-C  
Summary:   J’ai découvert cette astuce avec un billet de Paul Hudson, sur une idée partagée en 2016 par Maciej Konieczny. Plutôt que d’utiliser des booléens, il est souvent préférable de déclarer des énumérations à deux valeurs.  
Image:     
Language:  fr  


J’ai découvert cette astuce avec un billet de [Paul Hudson](https://www.hackingwithswift.com/articles/172/using-two-cased-enums-in-place-of-a-boolean), sur une idée partagée en 2016 par [Maciej Konieczny](http://narf.pl/posts/2cased).

**Plutôt que d’utiliser des booléens (`Bool`), il est souvent préférable de déclarer des énumérations (`enum`) à deux valeurs.**

A priori, c’est la même chose, avec davantage de code à taper. Quel intérêt, alors ?

Je vous invite à lire les articles cités ci-dessus pour plus d’explications, mais pour moi, c’est d’abord une question de lisibilité. Pour reprendre l’exemple donné par Paul Hudson, considérons la propriété `isHidden` sur `UIView`. On peut tester la visibilité d’une vue avec `if !view.isHidden`, ou `if view.isHidden == false`. Ça fonctionne, évidemment, mais je ne trouve pas ça très intuitif. Maintenant imaginons qu’il s’agisse d’une propriété `view.display`, déclarée en `enum` avec deux valeurs possibles : `.visible` et `.hidden`. C’est plus verbeux, mais surtout plus explicite. Pour tester la visibilité, il suffit d’un `if view.display == .visible`. Pas besoin de gymnastique du cerveau pour savoir que `isHidden = false` signifie « visible ».

Expliqué comme ça, ça semble trivial, et complètement superflu. C’est le genre de technique qu’il faut mettre en pratique pour en évaluer l’impact. La logique booléenne est peut-être l’aspect le plus simple de la programmation. Et pourtant, il faut toujours se méfier d’un code qui privilégie l’efficacité sur la lisibilité. Même à l’échelle d’un `Bool`.

Par ailleurs, cet aspect n’est pas l’unique avantage de cette approche. Votre code sera plus facilement modifiable (on peut facilement ajouter une troisième valeur), et son typage sera plus sûr (impossible de comparer directement des `enum` différents). Ça ne veut pas dire qu’il faut remplacer absolument tous les booléens, mais dans la plupart des cas, ces bénéfices valent bien la déclaration d’un `enum`, surtout pour des langages comme Swift (et Objective-C dans une moindre mesure) qui en facilitent l’utilisation.

En ce qui me concerne, le bilan est simple : depuis que j’ai découvert cette technique, je me retrouve à la mettre en pratique de plus en plus fréquemment, et j’en constate à chaque fois la pertinence. À vous d’essayer.
