Title:     ThirdPartyMailer   
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      April 10, 2016  
Update:   
Keywords:  Swift, app, making-of  
Summary:   J’ai publié cette semaine une nouvelle bibliothèque Swift pour iOS, qui permet d’interagir avec les clients mails tiers. On peut faire beaucoup de choses avec iOS en 2016, mais on ne peut toujours pas choisir son client mail.  
Image:     http://www.vtourraine.net/blog/img/2016/third-party-mailer/contacts-settings.png  
Language:  fr  

J’ai publié cette semaine [une nouvelle bibliothèque Swift](https://github.com/vtourraine/ThirdPartyMailer) pour iOS, qui permet d’interagir avec les clients mails tiers.

On peut faire beaucoup de choses avec iOS en 2016, mais on ne peut toujours pas choisir son client mail. Il existe plusieurs apps pourtant très intéressantes, de Sparrow à Outlook, en passant par Gmail. Mais toutes ces alternatives sont bridées par l’absence de réglage système pour définir un client par défaut.


## Custom URL schemes

Pour contourner ce problème, j’utilise les _custom URL schemes_, qui permettent à la fois de tester la présence d’une app correspondante, et d’ouvrir cette app avec certains paramètres. Cette technique est parfois utilisée pour permettre à l’utilisateur d’une app de choisir un navigateur web (Chrome à place de Safari, typiquement). Dans le cas qui m’intéresse, la plupart des clients mails tiers proposent des URL schemes pour la rédaction d’un mail, avec la possibilité de préciser le destinataire, le sujet et le corps du message. Pour Gmail, par exemple, il suffit de saisir l’URL `googlegmail:///co?to=test@mail.com` pour déclencher l’ouverture de l’app dans le contexte souhaité. 

Ma bibliothèque, [ThirdPartyMailer](https://github.com/vtourraine/ThirdPartyMailer), est donc essentiellement une collection d’URL schemes accompagnés des paramètres correspondants, et un peu de code autour d’`UIApplication` pour en faciliter l’utilisation.


## Contact[s]

J’utilise en fait ce code depuis plusieurs années, pour [mon app de carnet d’adresses](http://www.studioamanga.com/contacts/) qui permet donc de sélectionner un client mail par défaut. Au départ, il s’agissait uniquement de proposer Sparrow comme client alternatif. On peut maintenant utiliser Gmail, Dispatch, Spark et Airmail.

![Sélection du client mail pour Contact[s]](http://www.vtourraine.net/blog/img/2016/third-party-mailer/contacts-settings.png)

L’utilisateur peut ainsi initier la rédaction d’un mail avec le client de son choix, directement depuis ce carnet d’adresses.


## Swift

Je reconnais que l’utilité de ce code assez limitée, mais c’est une bonne occasion pour isoler une fonctionnalité et la proposer comme bibliothèque. Le code était initialement écrit en Objective-C, j’en ai donc profité pour le transposer en Swift.

Je ne suis pas complètement satisfait de l’interface proposée par la bibliothèque, notamment en ce qui concerne `UIApplication`. Il serait plus simple de proposer une simple extension pour ajouter quelques méthodes, mais cette approche empêche de tester le code en question. 
