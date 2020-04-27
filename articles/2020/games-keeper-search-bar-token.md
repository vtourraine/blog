Title:     Champ de recherche avec jetons iOS 13  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      April 27, 2020  
Update:    
Keywords:  dev, iOS  
Summary:   La dernière mise à jour de Games Keeper ajoute la possibilité de chercher dans l’historique des parties. Vous pouvez chercher le nom d’un joueur ou le titre de la partie. Pour aller plus vite, la liste complète des joueurs et des titres est affichée en dessous du champ de recherche.  
Image:     https://www.vtourraine.net/blog/img/2020/games-keeper-search-bar-token/history-search-bar.jpg  
Language:  fr  


La dernière mise à jour de [Games Keeper](https://www.studioamanga.com/gameskeeper/) ajoute la possibilité de chercher dans l’historique des parties.

Vous pouvez chercher le nom d’un joueur ou le titre de la partie. Pour aller plus vite, la liste complète des joueurs et des titres est affichée en dessous du champ de recherche.

![Games Keeper – Recherche dans l’historique des parties](/blog/img/2020/games-keeper-search-bar-token/history-search-devices.jpg)

En tapant sur une de ces suggestions, un jeton (« token ») apparaît dans la barre de recherche, et filtre les résultats. On peut combiner plusieurs jetons pour affiner la recherche, et bien sûr saisir un texte libre au clavier.

## UISearchTextField

Ce sont exactement les mêmes jetons qu’on trouve dans le champ de recherche de l’application Mail d’Apple. Avec iOS 13, les applications tierces peuvent enfin les inclure à leur interface.

Il suffit de passer par le `UISearchTextField` associé à la `UISearchBar`. Les jetons sont configurés avec un titre et une image facultative (les SF Symbols sont parfaits pour ça). On attache un objet avec `representedObject`, afin de donner une signification à chaque jeton en fonction de l’application. On les insère à une position donnée. Lorsqu’on souhaite appliquer les filtres correspondants, il suffit de les énumérer.

``` objc
// Création du jeton
UISearchToken *token = [UISearchToken tokenWithIcon:[UIImage systemImageNamed:@"person.crop.circle"] text:selectedPlayer.name];
token.representedObject = selectedPlayer;

// Insertion (ici, en dernière position)
[searchBar.searchTextField insertToken:token atIndex:searchBar.searchTextField.tokens.count];

// ...

// Itération
for (UISearchToken *token in searchBar.searchTextField.tokens) {
  // ...
}
```

- [`UISearchTextField` documentation](https://developer.apple.com/documentation/uikit/uisearchtextfield)
- [`UISearchToken` documentation](https://developer.apple.com/documentation/uikit/uisearchtoken)

Petit détail important : iOS 13 ajoute également la possibilité d’afficher la vue des résultats dès que la barre de recherche devient active. Ce n’est pas le cas par défaut, car iOS suppose qu’une barre de recherche vide n’a pas de résultats associés. C’est vrai pour une interface de recherche basique, mais comme ici les suggestions font techniquement partie de la vue des résultats, cette nouvelle option permet d’y accéder sans avoir à saisir de texte préalablement.

``` objc
self.searchController.showsSearchResultsController = YES;
```

![Games Keeper – Jetons de recherche](/blog/img/2020/games-keeper-search-bar-token/history-search-bar.jpg)

Je dois dire que l’ajout de cette fonctionnalité à Games Keeper était avant tout une excuse pour mettre en pratique cette nouvelle API. Le résultat me satisfait pleinement. L’API est simple d’utilisation, tout en offrant une fonctionnalité riche et parfaitement intégrée au système (sélection, copier-coller, support du clavier, etc). Et la possibilité de rechercher dans son historique de parties est une addition intéressante pour les joueurs qui utilisent beaucoup l’application.
