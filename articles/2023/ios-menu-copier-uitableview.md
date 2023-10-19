Title:    Copier le contenu d’une UITableView  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     October 19, 2023  
Update:   
Keywords: dev, iOS  
Summary:  Sur un site web, on peut sélectionner et copier n’importe quel texte. Sur une application, c’est plus limité. Pourtant, ça me semble important de laisser un maximum de contenu copiable.  
Image:    https://www.vtourraine.net/blog/img/2023/ios-menu-copier-uitableview/contacts-copies.jpg  
Language: fr  


Sur un site web, on peut sélectionner et copier n’importe quel texte. Sur une application, c’est plus limité. Pourtant, ça me semble important de laisser un maximum de contenu copiable.

Prenons un exemple simple : comment copier le contenu d’une cellule dans une `UITableView` ? Je me posais la question pour [PlayGuide](https://apps.apple.com/app/playguide/id6443413389), notamment pour permettre de copier l’adresse d’une aire de jeux.

J’ai regardé du côté des applications Apple, et découvert qu’il existe deux options. Si copier est l’unique option proposée, on aura tendance à utiliser le menu flottant, comme s’il s’agissait d’une sélection dans un champ de texte. S’il y a plusieurs options, on utilisera plutôt un menu contextuel, plus moderne.

Voici les deux options, toutes les deux présentes dans l’application Contacts avec iOS 17 :

![Menus « Copy » dans l’application Contacts](/blog/img/2023/ios-menu-copier-uitableview/contacts-copies)


## Menu flottant

Côté code, je réalise que la première option est dépréciée depuis... iOS 13. Et je découvre au passage un ensemble de fonctions sur `UITableViewDelegate` que je n’avais jamais remarqué. Assez incroyable, quand je pense au nombre de fois que j’ai implémenté une `UITableView`.

Ce code est donc déprécié, mais il fonctionne, et visiblement Apple continue de l’utiliser :

``` swift
override func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
  return true
}

override func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
  return action == #selector(copy(_:))
}

override func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
  if action == #selector(copy(_:)), let cell = tableView.cellForRow(at: indexPath) {
    let pasteboard = UIPasteboard.general
    pasteboard.string = cell.textLabel?.text
  }
}
```

Attention, cette approche supporte uniquement les options copier et coller.


## Menu contextuel

Depuis iOS 13, il convient d’utiliser un menu contextuel. Une seule fonction suffit :

``` swift
override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
  return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
    let copy = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
      if let cell = tableView.cellForRow(at: indexPath) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = cell.textLabel?.text
      }
    }
    return UIMenu(children: [copy])
  }
}
```

Le rendu est un peu bancal pour un menu avec un seul élément, mais cette approche a l’avantage d’être extensible.

À noter qu’avec iOS 17, il existe une nouvelle variation pour les menus contextuels, mais uniquement disponible avec SwiftUI (😢) : le `ControlGroup` ([en voici un exemple](https://nilcoalescing.com/blog/ControlGroupInContextMenus/)).

Pour le moment, voici donc le menu « Copier » pour l’adresse dans PlayGuide. Basique, mais pratique.

![Menu « Copier » dans l’application PlayGuide](/blog/img/2023/ios-menu-copier-uitableview/playguide-copy.jpg)
