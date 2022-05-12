Title:     Historique des versions avec Trackup  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      May 12, 2022  
Update:    
Keywords:  dev, iOS  
Summary:   Dans mon article du mois dernier, j’expliquais que Trackup était extensible, offrant des possibilités d’évolution intéressantes. Depuis, j’ai mis en pratique une de ces idées, avec un nouveau package Swift qui présente un historique de versions.  
Image:     https://www.vtourraine.net/blog/img/2022/trackup-version-history/contacts-version-history.jpg  
Language:  fr  


[Dans mon article du mois dernier](https://www.vtourraine.net/blog/2022/gestion-projet-todo-release-notes), j’expliquais que Trackup (mon système pour suivre le développement de mes applications) était extensible, offrant des possibilités d’évolution intéressantes. Depuis, j’ai mis en pratique une de ces idées, avec un nouveau package Swift qui présente un historique de versions. C’est un peu la même chose qu’on trouve sur chaque page d’application sur l’App Store, mais basé sur un fichier Trackup, et intégré nativement.

![Écran d’historique des versions pour Contact[s]](/blog/img/2022/trackup-version-history/contacts-version-history.jpg)

Ce package, [TrackupVersionHistory](https://github.com/vtourraine/TrackupVersionHistory), est un simple table view controller. Il se base sur le package [TrackupCore](https://github.com/vtourraine/Trackup) pour définir et charger le fichier Trackup. Il ne lui reste plus qu’à mettre en forme son contenu, avec sa table view et quelques `NSAttributedString`.

On peut ainsi facilement intégrer cet historique des versions à n’importe quelle application.

Mon utilisation est plus spécifique. J’utilise déjà un package pour l’écran « à propos » de la plupart de mes applications : [AMGAboutViewController](https://github.com/studioamanga/AMGAboutViewController). J’ai donc ajouté TrackupVersionHistory comme dépendance, et intégré l’historique aux fonctionnalités déjà présentes. Après quoi, ce n’est plus qu’une question de configuration. J’ai ainsi publié des mises à jour pour [1List](https://www.studioamanga.com/onelist/) et [Contact[s]](https://www.studioamanga.com/contacts/) incluant cette nouveauté. Et j’espère bientôt l’intégrer à l’ensemble de mes applications.
