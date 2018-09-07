Title:     Table view minimaliste avec Swift  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      September 7, 2018  
Update:    
Keywords:  iOS, app, dev  
Summary:   Développer pour iOS en 2018, c’est encore et toujours une histoire de UITableView. Les protocoles de data source et de delegate n’ont pas vraiment changé depuis iPhone OS 2, mais on continue à débattre des mille et une façons de les implémenter. Swift, en particulier, apporte de nouvelles solutions.  
Image:     https://www.vtourraine.net/blog/img/2018/air-grenoble-2-table-view/about-table-view.png  
Language:  fr  


Développer pour iOS en 2018, c’est encore et toujours une histoire de `UITableView`. Les protocoles de _data source_ et de _delegate_ n’ont pas vraiment changé depuis iPhone OS 2, mais on continue à débattre des mille et une façons de les implémenter. Swift, en particulier, apporte de nouvelles solutions.

Pour Air Grenoble 2, j’ai ajouté un nouvel écran d’informations. Un `UITableViewController` très simple, qui me donne l’occasion de chercher une implémentation toute aussi simple et efficace.

Concrètement, je cherche à éviter les méthodes à base de `switch`, qui font typiquement correspondre une `section` et une `row` à une cellule.

Pour mon écran, j’ai une seule section, et des cellules uniformes : un titre, une image, et une action associée. Pas la peine de passer par un `enum`. Je définis plutôt une `struct`, décrivant une cellule avec ces trois valeurs (`String` pour le titre, `String` pour le nom de l’image, et closure).

Cette solution est tout-à-fait implémentable avec Objective-C, mais Swift la simplifie considérablement. On peut définir la `struct` à l’intérieur de la classe du View Controller, et ainsi lui donner un nom plus court tout en clarifiant son rôle au sein du projet. Le constructeur est généré automatiquement. La `struct` et ses valeurs sont explicitement définies comme des constantes. On évite pas mal de bugs, et le code est nettement plus lisible.

Voici donc la définition de la `struct`, et du tableau qui correspond aux cellules de la Table View qui m’intéresse.

``` swift
class AboutViewController: UITableViewController {
  struct Row {
    let title: String
    let imageName: String
    let didSelectHandler: (AboutViewController)->Void
  }

  let rows: [Row] = [
    Row(title: "...", imageName: "...", didSelectHandler: {_ in
      // ...
    }),
    Row(title: "...", imageName: "...", didSelectHandler: {_ in
      // ...
    })]
}
```

Il ne reste plus qu’à implémenter les méthodes de _data source_ et de _delegate_, en faisant correspondre les valeurs du tableau instancié ci-dessus.

``` swift
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return rows.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
  let row = rows[indexPath.row]
  cell.textLabel?.text = NSLocalizedString(row.title, comment: "")
  cell.imageView?.image = UIImage(named: row.imageName)

  return cell
}

override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  let row = rows[indexPath.row]
  row.didSelectHandler(self)
  tableView.deselectRow(at: indexPath, animated: true)
}
```

Et voici le résultat pour Air Grenoble 2. 

![Écran d’informations, Air Grenoble 2](/blog/img/2018/air-grenoble-2-table-view/about-table-view.png)

Swift est un langage très puissant, mais qui peut parfois conduire à un code moins compréhensible, comparé à la syntaxe très (trop ?) descriptive d’Objective-C. Dans un cas comme celui-ci, en revanche, Swift brille par sa clarté et son expressivité. Tout simplement.
