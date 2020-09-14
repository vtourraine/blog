Title:     Comic Book Day pour Mac avec synchronisation iCloud  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      September 14, 2020  
Update:    
Keywords:  dev, iOS, macOS  
Summary:   Je viens de publier Comic Book Day 2.0. Mise à jour majeure ! Au programme : une version Mac et la synchronisation iCloud.  
Image:     https://www.vtourraine.net/blog/img/2020/comicbookday-mac-catalyst-sync/comicbookday-devices.jpg  
Language:  fr  


Je viens de publier [Comic Book Day 2.0](https://apps.apple.com/app/comic-book-day/id788312005). Mise à jour majeure ! Au programme : une version Mac et la synchronisation iCloud.

![Comic Book Day pour Mac, iPhone et iPad](/blog/img/2020/comicbookday-mac-catalyst-sync/comicbookday-devices.jpg)

La possibilité de synchroniser sa bibliothèque de comic books sur plusieurs appareils faisait partie des fonctionnalités les plus réclamées. Avec cette mise à jour, je mets en pratique une technologie d’abord testée sur Memorii (`NSPersistentCloudKitContainer`, [voir billet de blog précédent](https://www.vtourraine.net/blog/2020/memorii-mac-catalyst-sync)). Et cette fois, l’application se charge de propager les données des utilisateurs existants. Cela peut poser problème si un utilisateur a précédemment ajouté le même comic book sur plusieurs appareils. iCloud se trouvant avec des doublons, l’application tentera de réconcilier les données, en donnant la priorité aux comic books marqués comme lus. Ceci dit, le schéma de la base de donnée n’était pas conçu pour gérer cette situation, et il se peut que des données paraissent incohérentes. Dans une moindre mesure, l’application peut également être trompée lors de la première ouverture sur un nouvel appareil, si l’utilisateur possède déjà une bibliothèque associée à son compte iCloud.

Dans tous les cas, aucune donnée ne devrait disparaître involontairement, mais je vais garder un œil sur les commentaires App Store pour m’assurer que cette transition se passe bien pour tout le monde. La mise à jour est disponible depuis une semaine, et pour l’instant, aucun commentaire négatif à l’horizon.

Maintenant que la bibliothèque est partagée sur tous les appareils connectés à un compte iCloud, les conditions sont idéales pour ajouter une version Mac. Son interface est identique à la version mobile. Plutôt mal adaptée donc, mais je me réjouis de proposer l’application sur une plateforme supplémentaire. Mieux, le contexte (exigeant) du Mac est une motivation supplémentaire pour améliorer l’application. Prise en charge du clavier, menus contextuels, intégration avec le système, et bien d’autres. Puisque le code est commun à toutes les plateformes, les améliorations futures le seront également.
