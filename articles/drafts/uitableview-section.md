# Table view avec sections dynamiques

`UITableView` est un élément fondamental de l’interface d’iOS depuis sa toute première version. Elle s’organise en deux niveaux : des sections, et des lignes.

## Cas #1

Dans le cas le plus simple, il s’agit de présenter une liste homogène issue d’un tableau, donc avec une seule section, et une ligne par élément. 

Concrètement, on se retrouve à implémenter le data source comme cela :

``` swift
var objects = [Any]()

// override func numberOfSections(in tableView: UITableView) -> Int {
//  Inutile d’implémenter cette fonction, par défaut la table view possède une section.
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

Parfois, il s’agit de présenter une table view avec plusieurs sections, toujours statiques. On peut donc ajouter un `enum`, et ajouter une petite dose de `switch` pour ajuster le tout.

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

_Note : ces exemples sont écrits en Swift, mais peuvent fonctionner exactement de la même manière en Objective-C (dont acte, cela fait des années que les développeurs iOS utilisent ce format de code). Avec Swift, les enums offrent de nouvelles possibilités, permettant d’adresser ce problème bien plus efficacement. Pour aujourd’hui, j’en reste à une solution compatible avec les deux langages._


## Cas #3

Mais dans d’autres situations, le contenu de la table view doit être entièrement dynamique. C’est particulièrement important en style groupé (`UITableViewStyleGrouped`), puisqu’iOS affiche une marge autour de chaque section, même lorsqu’elles sont vides. Pour ne pas accumuler des marges superflues, il faut donc faire correspondre un numéro de section à différents contenus, selon le contexte d’exécution.

 On peut la présenter avec deux styles : « plain » et « grouped ». 