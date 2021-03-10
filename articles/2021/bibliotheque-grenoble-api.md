Title:     API pour l’application Bibliothèque de Grenoble  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      March 10, 2021  
Update:    
Keywords:  iOS, dev  
Summary:   Comment construire une application pour un service web qui ne dispose pas d’API publique ? Pour la Bibliothèque de Grenoble, je vous avais expliqué que j’utilisais une web view invisible, pilotée par des commandes JavaScript, extrayant les informations des pages HTML. La situation vient de changer avec la dernière mise à jour.  
Image:     
Language:  fr  


Comment construire une application pour un service web qui ne dispose pas d’API publique ? Pour la Bibliothèque de Grenoble, [je vous avais expliqué](https://www.vtourraine.net/blog/2019/bibliotheque-grenoble) que j’utilisais une web view invisible, pilotée par des commandes JavaScript, extrayant les informations des pages HTML. Je n’irai pas jusqu’à recommander cette approche, mais, depuis deux ans, je continuais de développer et d’utiliser cette application.

La situation vient de changer avec [la dernière mise à jour](https://apps.apple.com/app/grenoble-municipal-library/id1483022528?l=en). Les utilisateurs du site web officiel de la bibliothèque auront remarqué il y a quelques semaines un important changement d’interface. Le système informatique vient manifestement de passer sur une toute nouvelle solution. Cette version s’adapte mieux aux écrans mobiles, mais ça n’enlève pas l’utilité d’une application native. Surtout, le nouveau système semble offrir une API. Elle n’est pas explicitement documentée, mais on peut facilement la prendre en main en observant le fonctionnement de l’interface web (*web inspector-driven API retro-engineering* ?).

Cette nouvelle version de mon application mobile conserve la même interface, mais la synchronisation est entièrement revue. Plus de web view, tout passe par des requêtes « normales » à l’API.

Premier bénéfice : ça va plus vite. On dit souvent ça pour justifier une ré-écriture technique. Dans le cas présent, on passe de quelques secondes (c’est looooong), à une fraction de seconde. La différence est très appréciable.

Par la suite, il me sera plus facile d’ajouter de nouvelles fonctionnalités. Prochain objectif : la recherche de documents, que j’utilise beaucoup pour savoir ce qui est disponible, et dans quelle bibliothèque. Renouvellement d’un document, réservation... je n’ai pas l’intention de répliquer l’intégralité des fonctionnalités de l’interface web, mais j’ai de quoi m’amuser. Abandonner la web view permet aussi de proposer des Extensions, Widgets, et même une application Apple Watch. Le seul problème, c’est que ça me laisse moins de temps pour lire des livres.

En bonus, j’ai utilisé Swift Package Manager pour le code qui interagit directement avec l’API. [Le code (et le reste de l’application) est sur GitHub](https://github.com/vtourraine/bm-grenoble-ios), vous pouvez donc facilement développer votre propre client natif.
