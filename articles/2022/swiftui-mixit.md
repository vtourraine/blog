Title:    Tentative de projet avec SwiftUI  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     September 29, 2022  
Update:   
Keywords: dev, iOS, SwiftUI  
Summary:  On peut difficilement ignorer SwiftUI. Au début, il y avait du potentiel et de l’enthousiasme. Ainsi que des limitations et des bugs. Normal ! Les premiers retours étaient prometteurs. Certains développeurs adorent expérimenter avec les technologies balbutiantes. En général, je préfère attendre.  
Image:    https://www.vtourraine.net/blog/img/2022/swiftui-mixit/mixit-macos-swiftui.jpg  
Language: fr  


On peut difficilement ignorer SwiftUI.

Au début, il y avait du potentiel et de l’enthousiasme. Ainsi que des limitations et des bugs. Normal ! Les premiers retours étaient prometteurs. Certains développeurs adorent expérimenter avec les technologies balbutiantes. En général, je préfère attendre.

En 2022, la situation est différente… et similaire. Certaines fonctionnalités majeures d’iOS sont uniquement disponibles avec SwiftUI. Apple proclame la technologie comme *la* solution pour écrire une application. « The best way to build an app is with Swift and SwiftUI. » Seulement voilà, les limites et bugs des premiers jours sont toujours présents, et semblent fondamentalement ancrés au framework. Tellement de progrès, et pourtant, la frustration reste la même.

C’était grand temps pour moi de passer à la pratique, pour me faire ma propre idée. J’ai donc essayé de développer une application avec SwiftUI. Pour limiter les inconnus, j’ai préféré convertir un projet existant. Mon application pour MiXiT a une interface très classique, avec une liste principale, une vue de détail, et une modale. Il y a plusieurs labels, des images, quelques boutons. Et la version actuelle utilise UIKit : un candidat parfait pour SwiftUI (petit bémol, il fallait d’abord réécrire le modèle et le moteur de synchronisation pour passer d’Objective-C à Swift).

Les premiers pas étaient très enthousiasmants, avec l’affichage de la liste principale et de la vue de détail. Aucun doute, SwiftUI est parfait pour ce type d’interface. Mieux, je découvre la prise en charge automatique des listes avec sections adossées à une entité Core Data (`@SectionedFetchRequest`), une nouveauté iOS 15/macOS 12. Je tâtonne un peu avec la documentation et les guides en ligne, mais j’obtiens finalement le résultat voulu. À ce stade, je me dis que c’est une franche réussite.

Pour iOS, on obtient essentiellement le même résultat (avec beaucoup moins de code). Comparatif UIKit/SwiftUI :

![MiXiT pour iPhone avec UIKit](/blog/img/2022/swiftui-mixit/mixit-uikit.jpg)

![MiXiT pour iPhone avec SwiftUI](/blog/img/2022/swiftui-mixit/mixit-swiftui.jpg)

Pour le Mac, SwiftUI fait beaucoup mieux que UIKit via Catalyst (notamment grâce à un split view automatique) :

![MiXiT pour Mac avec UIKit (1)](/blog/img/2022/swiftui-mixit/mixit-macos-catalyst-1.jpg)

![MiXiT pour Mac avec UIKit (1)](/blog/img/2022/swiftui-mixit/mixit-macos-catalyst-2.jpg)

![MiXiT pour Mac avec SwiftUI](/blog/img/2022/swiftui-mixit/mixit-macos-swiftui.jpg)

Bravo SwiftUI.

Vient ensuite la modale pour l’écran d’informations. Là, la machine commence à gripper. La version iOS fonctionne, mais le rendu pour macOS ne correspond pas du tout.

![« About MiXiT » pour iPhone avec SwiftUI](/blog/img/2022/swiftui-mixit/mixit-swiftui-about.jpg)

![« About MiXiT » pour Mac avec SwiftUI](/blog/img/2022/swiftui-mixit/mixit-macos-swiftui-about.jpg)

Il y a sûrement une solution simple. Je reconnais que l’interface est très UIKit, trop peut-être. Quelle serait la bonne approche avec SwiftUI, suffisamment neutre pour pouvoir s’adapter harmonieusement à chaque plateforme ? Je ne sais pas, et je ne sais pas où trouver cette information. Frustrant, mais pas déraisonnable. 

J’essaie de passer aux fonctionnalités plus avancées, comme l’ajout d’un événement au calendrier système, avec `EKEventEditViewController`. Un composant système, uniquement disponible avec UIKit, qui nécessite donc de construire un pont pour être présenté depuis SwiftUI. Ce n’est pas très élégant, mais ça fonctionne. Sauf que. Pour présenter cette vue, il faut d’abord obtenir l’autorisation de l’utilisateur. Donc appeler `EKEventStore.requestAccessToEntityType:completion:`, attendre la réponse, et présenter une interface en conséquence. J’imagine que la solution consiste à étendre le pont SwiftUI/UIKit pour ajouter un degré de navigation supplémentaire. Concrètement, je ne sais pas comment. Et surtout, c’est le moment où l’effort d’intégration me décourage complètement. À quoi bon simplifier le code d’un côté s’il faut le déformer à ce point d’un autre ? S’il existe une API SwiftUI pour remplir cette tâche, je ne l’ai pas trouvée. En attendant, il semble que le SDK iOS n’est pas prêt pour SwiftUI. Si Apple n’arrive pas à proposer ses interfaces avec SwiftUI, pourquoi m’y forcer, si UIKit répond à tous mes besoins ?

Je ne dis pas que SwiftUI n’est pas l’avenir du développement pour les plateformes Apple. Je constate simplement que SwiftUI n’est pas prêt, pour moi, avec ma connaissance d’UIKit. Évidemment, je garderai un œil sur les évolutions à venir, pour réévaluer la situation. Dans l’immédiat, ma FOMO est assagie, et je retourne à mon code UIKit.

Si vous êtes curieux, [le code de l’application MiXiT est sur GitHub](https://github.com/vtourraine/mixit/tree/swiftui).
