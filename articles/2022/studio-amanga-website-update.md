Title:    Mise à jour du site internet Studio AMANgA  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     December 13, 2022  
Update:   
Keywords: dev, web  
Summary:  La page d’accueil pour StudioAMANgA.com n’avait pas bougé depuis plusieurs années. Je viens de la mettre à jour, avec des nouveautés visuelles mais aussi un gros changement technique.  
Image:    https://www.vtourraine.net/blog/img/2022/studio-amanga-website-update/stdamg-2022.jpg  
Language: fr  


La page d’accueil pour [StudioAMANgA.com](https://www.studioamanga.com) n’avait pas bougé depuis plusieurs années. Je viens de la mettre à jour, avec des nouveautés visuelles mais aussi un gros changement technique.

Voici à quoi ressemblait la page jusqu’au mois dernier, et sa nouvelle apparence.

![StudioAMANgA.com version précédente](/blog/img/2022/studio-amanga-website-update/stdamg-2021.jpg)

![StudioAMANgA.com version fin 2022](/blog/img/2022/studio-amanga-website-update/stdamg-2022.jpg)

Au revoir l’intégration Twitter. C’était pratique pour voir les dernières versions publiées, mais dans le contexte actuel, je préfère m’en éloigner autant que possible. Je prévois de faire la même chose pour [vtourraine.net](https://www.vtourraine.net).

J’ai aussi ajouté du texte. Une description générale (« Mobile and desktop applications »), et une description par application. C’est bête, mais en y réflechissant ça me paraît incontournable. Je sais ce que font mes applications, mais ce site n’est pas pour moi.

[Côté technique](https://github.com/studioamanga/stdamg-website), j’ai laissé tombé le script Ruby que j’utilisais précédemment. C’était trop complexe pour une page si simple. Et à la place ? Swift ! Pour l’instant, c’est juste un script qui génère la page statiquement. OK, ça ne sert pas à grand chose. Je pourrais me contenter d’une page HTML éditée à la main. Mais j’aime bien l’idée, et ça pourrait permettre des évolutions sympas à l’avenir.
