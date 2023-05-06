Title:    Partager/copier une URL avec Catalyst  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     May 6, 2023  
Update:   
Keywords: dev, iOS, macOS  
Summary:  Quand on partage une URL avec UIActivityViewController, iOS propose de la copier dans le presse-papiers. Rien de plus normal. Mais si on compile ce même code pour macOS avec Catalyst, cette option n’est pas proposée.  
Image:    https://www.vtourraine.net/blog/img/2023/catalyst-share-copy/catalyst-share-copy-ios-macos.jpg  
Language: fr  


Quand on partage une URL avec `UIActivityViewController`, iOS propose de la copier dans le presse-papiers. Rien de plus normal. Mais si on compile ce même code pour macOS avec Catalyst, cette option n’est pas proposée.

![Partage d’une URL dans PlayGuide sur iOS et macOS](/blog/img/2023/catalyst-share-copy/catalyst-share-copy-ios-macos.jpg)

Heureusement, il existe une solution pour proposer la copie d’une information (URL ou autre) sur macOS : il suffit d’implémenter la fonction `copy(_:)`, en passant une valeur à `UIPasteboard.general`. Par exemple :

``` swift
override func copy(_ sender: Any?) {
  UIPasteboard.general.string = playground?.shareUrl
}
```

Vous pouvez placer ce code dans un `UIViewController` si cela concerne tout l’écran, ou bien dans une `UIView` pour copier un élément plus spécifique. En fait, l’application analyse la [responder chain](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/using_responders_and_the_responder_chain_to_handle_events), et utilise le premier objet qui implémente cette fonction.

C’est d’autant plus intéressant que macOS gère tout le reste automatiquement. Le menu « Édition » activera l’élément « Copier » dynamiquement et le raccourci clavier `⌘C` fonctionnera normalement. En bonus, si vous utilisez cette application sur iPad avec un clavier externe, l’option sera également proposée.

Une façon simple et rapide pour améliorer vos applications avec Catalyst.
