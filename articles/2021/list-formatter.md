Title:    ListFormatter  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     January 19, 2021  
Update:   
Keywords: dev, iOS  
Summary:  Les Formatters sont des classes bien utiles. Dernière amélioration remarquable : l’ajout de ListFormatter avec iOS 13.  
Image:    
Language: fr  


Les Formatters (`DateFormatter`, `NumberFormatter` et compagnie) sont des classes bien utiles. Dernière amélioration remarquable : l’ajout de `ListFormatter` avec iOS 13.

Cette classe joint un tableau de `String` en utilisant la forme grammaticale et typographique correcte. `["A", "B", "C"]` devient donc `"A, B, and C"` en anglais, ou `"A, B et C"` en français.

Son utilisation est très simple :

``` swift
ListFormatter.localizedString(byJoining: ["A", "B", "C"])
```

En lisant [l’excellent article de NSHipster sur le sujet](https://nshipster.com/formatter/), je découvre qu’il est également possible de le combiner avec un autre Formatter, pour mettre en forme une collection qui n’est pas originellement représentée par des `String`. Voici un exemple avec des nombres :

``` swift
let numberFormatter = NumberFormatter()
let listFormatter = ListFormatter()
listFormatter.itemFormatter = numberFormatter
let string = listFormatter.string(from: [1, 2, 3])
```

Si vous avez déjà écrit `strings.joined(by: ", ")` (🙋‍♂️), ou si vous avez déjà implémenté une solution plus poussée, cette classe est pour vous.
