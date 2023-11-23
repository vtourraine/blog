Title:    Améliorer une application Catalyst avec une toolbar  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     November 23, 2023  
Update:   
Keywords: dev, macOS  
Summary:  Qu’est-ce qui différencie une application pour le Mac d’une application iOS ? Il n’existe pas de réponse simple, mais je crois que la toolbar est un élément important.  
Image:    https://www.vtourraine.net/blog/img/2023/macos-catalyst-toolbar/playguide-new-toolbar.jpg  
Language: fr  


Qu’est-ce qui différencie une application pour le Mac d’une application iOS ? Il n’existe pas de réponse simple, mais je crois que la toolbar (barre d’outils) est un élément important.

Je souhaitais améliorer la version Mac Catalyst de [PlayGuide](https://apps.apple.com/app/playguide/id6443413389). Par chance, [Apple propose un excellent tutoriel pour l’ajout d’une toolbar](https://developer.apple.com/tutorials/mac-catalyst/adding-a-toolbar). Pour PlayGuide, ça me permet de déplacer les boutons « localiser » et « rechercher » qui flottaient dans un coin de la carte. 

Avant :

![PlayGuide pour Mac sans toolbar](/blog/img/2023/macos-catalyst-toolbar/playguide-no-toolbar.jpg)

Après :

![PlayGuide pour Mac avec toolbar](/blog/img/2023/macos-catalyst-toolbar/playguide-new-toolbar.jpg)

La différence peut sembler anecdotique. Les boutons ont une apparence légèrement différente. La nouvelle barre prend même davantage de place. Mais je trouve que l’application est mieux intégrée à macOS avec cette nouvelle toolbar. 

Il y a juste un détail que j’ajouterais au tutoriel. Pour obtenir les mêmes boutons que dans les applications d’Apple, il convient d’activer la propriété `isBordered`.

``` Swift
// `toolbar(_:itemForItemIdentifier:willBeInsertedIntoToolbar:)`

let item = NSToolbarItem(itemIdentifier: itemIdentifier)
item.image = UIImage(systemName: "...")
item.label = "..."
item.action = #selector(...)
item.target = nil
item.isBordered = true
```

Là aussi, la différence est subtile, puisque le bord est caché par défaut et ne se révèle qu’en survolant le bouton avec le curseur. Les détails comptent.

![Survol d’un bouton de toolbar bordé](/blog/img/2023/macos-catalyst-toolbar/toolbar-item-bordered.jpg)
