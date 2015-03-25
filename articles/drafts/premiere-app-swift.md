# Bilan de ma première app Swift

Je ne me suis pas franchement jeté sur Swift après l’annonce de la WWDC 2014, mais [dotSwift]() est passé par là, et voici maintenant ma première application Swift [disponible sur l’App Store]().

À défaut d’être original, je pense que c’est le bon moment pour un premier bilan de mon expérience avec ce nouveau langage qui s’annonce comme l’avenir du développement pour les plateformes Apple.


## Le moins bien

Commençons par ce qui ne va pas, ou plutôt par ce qui est rend la transition difficile. Je vous rassure tout de suite, je n’ai rien trouvé de rédhibitoire.

Le langage évolue encore, de façon relativement significative, en ajustant sa syntaxe et sa sémantique. C’est très certainement nécessaire, mais c’est pour l’instant une forme de dette technique. J’ai crû comprendre que l’objectif était d’avoir un langage stable pour sa version 2.0 (ce qu’on appellerait donc communément une version… 1.0, mais je pinaille). 

J’ai vraiment envie de mettre un point virgule à la fin de chaque ligne;

L’application exportée en `.ipa` est alourdie de plusieurs Mo. Cela s’explique par le fait que cette archive comprend une partie des bibliothèques Swift correspondant à la version compilée de l’application. Elle assure ainsi sa rétro-compatibilité, indépendamment des évolutions du langage. 

Plus de fichier header (`.h`). Globalement, c’est sûrement un point positif, mais on perd quand même la lisibilité d’un fichier qui servait justement à présenter une classe, sans avoir à se soucier de son implémentation. 

Convertir un code Objective-C existant vers Swift est évidemment possible, mais relativement pénible. Mais le vrai problème, c’est qu’on obtient alors une traduction littérale, qui ne capture pas vraiment les particularités et les avantages de Swift. Ça revient à mettre une couche de peinture, sans rien reconstruire. Même pour écrire de nouvelles fonctions, je continue à utiliser les _patterns_ de l’ancien langage. Comme pour la Matrice, il va falloir désapprendre ce qu’on a appris, avant de passer aux choses vraiment intéressantes. Ça va forcément demander du temps.


## Le bien

Xcode relativement stable. Ça reste Xcode, avec quelques plantages supplémentaires, mais ce n’est pas la catastrophe ambulante des premiers jours.

Plutôt facile d’importer du code ObjC dans du code Swift.

Les enums avec des noms intelligents (comparaison avec ObjC)

Les super fonctions : maps(), etc…

Déjà beaucoup d’aide en ligne, sur Stack Overflow et ailleurs.