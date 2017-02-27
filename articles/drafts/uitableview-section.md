Title:     Table view avec sections dynamiques  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      February 27, 2017  
Update:    
Keywords:  dev, Swift, UIKit  
Summary:   « UITableView » est un élément fondamental de l’interface d’iOS depuis la toute première version du SDK. Elle s’organise en deux niveaux : des sections, et des lignes. Rien de compliqué lorsque le contenu est statique. Mais les choses peuvent vite se corser quand ces sections et ces lignes apparaissent dynamiquement.  
Image:     
Language:  fr  


`UITableView` est un élément fondamental de l’interface d’iOS depuis la toute première version du SDK. Elle s’organise en deux niveaux : des sections, et des lignes. Rien de compliqué lorsque le contenu est statique. Mais les choses peuvent vite se corser quand ces sections et ces lignes apparaissent dynamiquement.

## Cas #1

Dans le cas le plus simple, il s’agit de présenter une liste homogène issue d’un tableau, donc avec une seule section, et une ligne par élément. 

Concrètement, on se retrouve à implémenter le data source comme cela :

``` swift
var objects = [Any]()

// Inutile d’implémenter cette fonction, par défaut la table view possède une section.
// override func numberOfSections(in tableView: UITableView) -> Int {
//  return 1
//}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return objects.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

  let object = objects[indexPath.row] as? …
  cell.textLabel!.text = object.description
  return cell
}
```

## Cas #2

Parfois, il s’agit de présenter une table view avec plusieurs sections, toujours statiques. On peut donc ajouter un `enum`, et une petite dose de `switch` pour ajuster le tout.

``` swift
enum Section: Int {
  case first
  case second
}

var objectsFirst = [Any]()
var objectsSecond = [Any]()

override func numberOfSections(in tableView: UITableView) -> Int {
  return 2
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  switch Section(rawValue: section)! {
  case .first:
    return objectsFirst.count
  case .second:
    return objectsSecond.count
  }
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

  switch Section(rawValue: indexPath.section)! {
  case .first:
    // …
  case .second:
    // …
  }
}
```

Davantage de code, mais rien de bien compliqué.

_Note : ces exemples sont écrits en Swift, mais peuvent fonctionner exactement de la même manière en Objective-C (dont acte, cela fait des années que les développeurs iOS utilisent ce modèle de code). Swift offre de nouvelles possibilités, qui permettent d’adresser ce problème bien plus efficacement. Pour aujourd’hui, j’en reste à une solution compatible avec les deux langages._

## Cas #3

Mais dans d’autres situations, le contenu de la table view doit être entièrement dynamique. C’est notamment important en style groupé (`UITableViewStyleGrouped`), puisqu’iOS affiche une marge autour de chaque section, même lorsqu’elles sont vides. Pour ne pas accumuler des marges superflues au milieu de l’écran, il faut donc faire correspondre un numéro de section à différents contenus, selon le contexte d’exécution.

Il y a bien sûr de nombreuses façons de résoudre ce problème. Celle que j’utilise généralement consiste à ajouter un niveau d’indirection sous la forme d’une fonction qui retourne la valeur d’énumération de section pour un indice de section donné. C’est-à-dire, au lieu de se reposer sur le fait qu’un enum correspond par défaut à des valeurs entières croissantes (0, 1, 2, 3, _etc_), faire correspondre l’indice de section brut à un cas d’énumération de façon non-linéaire.

C’est sans doute plus parlant avec du code :

``` swift
func content(for section: Int) -> Section {
  switch (section) {
  case 0:
    return .second
  case 1:
    return .first
  default:
    return Section(rawValue: section)!
  }
}
```

Dans cet exemple d’implémentation, on se retrouve à inverser le contenu des deux sections : `.second`, puis `.first`. Bien sûr, le détail de cette fonction dépend complètement du contenu spécifique à l’app en question, et le nombre total de sections peut également varier. Une fois cette fonction définie, il suffit de mettre à jour le data source pour y passer tous les indices de sections. Par exemple, pour le nombre de lignes :

``` swift
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  switch content(for: section) {
  case .first:
    return objectsFirst.count
  case .second:
    return objectsSecond.count
  }
}
```

Avec cette approche, toute la logique de dynamisme des sections est regroupée dans une seule fonction, et le data source garde une implémentation classique, sans complexité apparente.

## Au cas par cas

Je me suis rendu compte que j’utilisais cette solution dans plusieurs applications de façon assez similaire. J’ignore s’il s’agit d’une approche très répandue, mais j’imagine que de nombreux développeurs iOS font face à cette situation.

Ce problème me paraît vraiment intéressant car il s’agit d’un cas simple, mais pas complètement trivial. Si on en reste à une suite de `if`/`else`, le code paraît trop fragile. Si on essaie d’intégrer une bibliothèque spécialisée ou même juste une classe dédiée, le code peut rapidement devenir inutilement complexe. « Make things as simple as possible, but not simpler », pour reprendre [une citation bien célèbre](http://quoteinvestigator.com/2011/05/13/einstein-simple/).

Le passage d’Objective-C à Swift autorise de nouvelles approches. Les énumérations bénéficient de valeurs associées, et les `switch` sont plus expressifs. Cette combinaison est généralement suffisante pour implémenter une table view dynamique en gardant un code concis. Mais dans d’autres situations, et pour un code écrit en Objective-C, il faudra trouver des solutions sur mesure.
