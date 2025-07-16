Title:    Nano Notes, grande réussite  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     July 16, 2025  
Update:   
Keywords: dev, iOS, watchOS  
Summary:  Les projets les plus simples sont parfois ceux qui réussissent le mieux.  
Image:    https://www.vtourraine.net/blog/img/2025/nano-notes-succes/nano-notes-devices.jpg  
Language: fr  


Les projets les plus simples sont parfois ceux qui réussissent le mieux.

J’ai publié la première version de [Nano Notes](https://www.studioamanga.com/nanonotes/) en avril 2019. Le concept est simple : prendre des notes sur un iPhone pour les lire sur une Apple Watch.

![Nano Notes pour iPhone et Apple Watch](/blog/img/2025/nano-notes-succes/nano-notes-devices.jpg)

L’application est tout aussi simple : une liste de notes (`UITableViewController`) et une vue de détail pour éditer (`UITextView`). Un bouton pour ajouter une note, un bouton pour réordonner et supprimer. Les données sont sauvegardées dans un fichier `plist`. `WCSession` assure la synchronisation avec la montre. Quelques centaines de lignes de code, avec uniquement des composants système.

Et, à ma grande surprise, c’est mon application la plus appréciée. En 6 ans, elle a été téléchargée 100.000 fois. Aujourd’hui, elle vient de passer la barre des 2000 avis sur l’App Store, avec une moyenne à 4,9 étoiles sur 5. Pardonnez-moi cet instant d’auto-satisfaction, mais ce n’est pas tous les jours qu’une application mobile reçoit des retours si positifs.

![Note moyenne sur l’App Store, avec les derniers avis](/blog/img/2025/nano-notes-succes/nano-notes-ratings.jpg)

[Apple vient d’annoncer](https://www.apple.com/os/watchos/) que la prochaine version de watchOS allait inclure une nouvelle application : Notes. Elle permettra de lire sur sa montre les notes prises sur son téléphone. Ah ! Excellente idée !

Me voici donc « [sherlocké](https://en.wikipedia.org/wiki/Sherlock_(software)?wprov=sfti1#Sherlocked_as_a_term) ». Quelle place pour Nano Notes, face à une application installée par défaut et proposant de nombreuses autres fonctionnalités ? L’avenir le dira. Pour concurrencer Apple, un développeur indépendant a généralement intérêt à proposer une application plus poussée, avec davantage d’options, gérant des situations plus complexes. Pour Nano Notes, mon objectif est de garder une extrême simplicité. Ça lui réussit plutôt bien pour l’instant.
