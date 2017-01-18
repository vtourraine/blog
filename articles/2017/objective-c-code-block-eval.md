Title:     Code block evaluation  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      January 18, 2017  
Update:    
Keywords:  Objective-C, dev
Summary:   Pour garantir la bonne qualité d’un code source, on conseille souvent de garder les fonctions courtes. Au-delà d’une dizaine de lignes, mieux vaut re-découper. C’est généralement une bonne règle à suivre, mais qui peut entraîner un nouveau problème. En effet, cette contrainte favorise des fonctions plus concises, mais parfois trop fragmentées, ce qui nuit à la lisibilité du code dans son ensemble.  
Image:     
Language:  fr  


Pour garantir la bonne qualité d’un code source, on conseille souvent de garder les fonctions courtes. Au-delà d’une dizaine de lignes, mieux vaut re-découper. C’est généralement une bonne règle à suivre, mais qui peut entraîner un nouveau problème. En effet, cette contrainte favorise des fonctions plus concises, mais parfois trop fragmentées, ce qui nuit à la lisibilité du code dans son ensemble.

Heureusement, il existe avec Objective-C une construction qui peut résoudre élégamment cette situation. Connaissez-vous le « code block evaluation » ?

Ok, ok, le nom n’est pas très parlant. Il s’agit d’une extension GCC/Clang (donc intégrée nativement à Xcode), qui évalue un code contenu entre `({` et `})`, et retourne la valeur se trouvant sur la dernière ligne.

Bref, en voici un exemple :

``` objc
UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:({
  CGRect frame = self.tableView.frame;
  frame.size.height = 50;
  frame;
})];
```

Ce n’est pas tout-à-fait une fonction (pas de paramètres), simplement un bloc imbriqué, à usage unique. On est donc assez proche d’une fonction `inline`.

Cette construction a un avantage principal : elle limite la portée et la durée de vie des variables déclarées à l’intérieur du bloc. Pour revenir au code d’exemple ci-dessus, vous pouvez initialiser de la sorte plusieurs vues, en créant à chaque fois un `CGRect frame` dédié, sans conflit entre eux. Pas la peine de réutiliser le même frame entre deux vues (ce qui serait sémantiquement incorrect, et donc une source potentielle de bugs), et inutile de complexifier le nom des variables simplement pour les distinguer.

Le code est plus propre, donc plus facile à maintenir, et réduit la possibilité d’introduire des bugs. Et comme le bloc est placé à l’endroit même de son utilisation, on évite le problème de fragmentation des méthodes et fonctions séparées. Je trouve ça très utile, notamment pour remédier à certains comportements potentiellement problématiques avec Objective-C, et mieux structurer son code.

Source : [cocoa-dom](http://cocoa-dom.tumblr.com/post/56517731293/new-thing-i-do-in-code), via [NSHipster](http://nshipster.com/new-years-2014/)
