Title:    AcknowList : affichage des licences avec l’API GitHub  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     January 27, 2024  
Update:   
Keywords: dev, iOS, UIKit, SwiftUI  
Summary:  Ma bibliothèque AcknowList est partie d’un modèle simple : afficher le contenu des licences CocoaPods. Plus tard, j’ai ajouté le support de Swift Package Manager. Petit problème : SPM ne gère pas explicitement les licences, juste l’URL où se trouve le code. AcknowList 3.1.0 améliore cette situation grâce à l’API GitHub.  
Image:    
Language: fr  


Ma bibliothèque [AcknowList](https://github.com/vtourraine/AcknowList) est partie d’un modèle simple : afficher le contenu des licences CocoaPods. Plus tard, j’ai ajouté le support de Swift Package Manager. Petit problème : SPM ne gère pas explicitement les licences, juste l’URL où se trouve le code. Dans ce cas, AcknowList se contentait donc d’ouvrir la page dans le navigateur.

[AcknowList 3.1.0](https://github.com/vtourraine/AcknowList/releases/tag/3.1.0) améliore cette situation grâce à l’API GitHub. En effet, celle-ci permet d’obtenir [le texte de la licence pour une URL donnée](https://docs.github.com/en/rest/licenses/licenses#get-the-license-for-a-repository). Pas besoin d’authentification, juste une simple requête `GET`. Évidemment, cette solution ne fonctionne que pour les dépendances hébergées sur GitHub, mais il me semble qu’il s’agit de la grande majorité des bibliothèques (même Apple héberge ses packages sur GitHub).

Concrètement, quand l’utilisateur sélectionne une dépendance sans licence mais avec une URL `github.com`, AcknowList fait appel à l’API GitHub. Si elle retourne une licence, on l’affiche nativement, comme pour les licences CocoaPods. Sinon, on ouvre l’adresse dans le navigateur, comme précédemment. Ça fonctionne vraiment bien.

## UIKit/SwiftUI

Comme AcknowList propose deux interfaces, une avec UIKit et une autre avec SwiftUI, j’ai implémenté cette fonctionnalité deux fois.

Avec UIKit, la requête à l’API intervient lorsque l’utilisateur sélectionne une ligne (`tableView(_:didSelectRowAt:)`), ce qui retarde l’affichage de la vue pour la licence. Dans la pratique, l’API est très rapide, le chargement est quasiment imperceptible. Mais il y a bien un délai, ce qui est contraire aux recommendations des [HIG](https://developer.apple.com/design/human-interface-guidelines).

Côté SwiftUI, la solution est plus élégante. La vue de détail est présentée immédiatement. La licence est représentée par une propriété `@State`. J’utilise `.onAppear` pour détecter une URL GitHub, appeler l’API et mettre à jour la propriété `@State` avec le texte de la licence. SwiftUI s’occupe du reste, en actualisant le texte ainsi affiché. On pourrait encore améliorer certaines situations (par exemple, quand la requête à l’API échoue), mais cette version est plus satisfaisante. C’est peut-être la première fois que j’apprécie concrètement le passage d’UIKit à SwiftUI. Pas mal.
