# ThirdPartyMailer 

J’ai publié cette semaine une nouvelle bibliothèque Swift qui permet d’interagir avec les clients mails tiers.

On peut faire beaucoup de choses avec iOS en 2016, mais on ne peut toujours pas choisir son client mail. Pour contourner ce problème, j’utilise les _custom URL schemes_, qui permettent à la fois de tester la présence d’une app correspondante, et d’ouvrir cette app avec certains paramètres. Cette technique est parfois utilisée pour permettre à l’utilisateur d’une app de choisir un navigateur web (Safari ou Chrome, typiquement). Dans le cas qui m’intéresse, la plupart des clients mails tiers proposent des URL schemes pour la rédaction d’un mail, avec la possibilité de préciser le destinataire, le sujet et le corps du message. Pour Gmail, par exemple, il suffit de saisir l’URL `googlegmail:///co?to=test@mail.com` (avec Safari ou toute autre application), pour déclencher l’ouverture de l’app Gmail. 

Ma bibliothèque, `ThirdPartyMailer`, est donc essentiellement une collection d’URL schemes accompagnés des paramètres correspondants, et un peu de code autour d’`UIApplication` pour faciliter leur utilisation dans ce contexte.


## Contact[s]

J’utilise en fait ce code depuis plusieurs années, pour [mon app de carnet d’adresses](http://www.studioamanga.com/contacts/) qui permet de sélectionner un client mail par défaut. Au départ, il s’agissait uniquement de proposer Sparrow comme client alternatif. On peut maintenant utiliser Gmail, Dispatch, Spark et Airmail.

Je reconnais que ce code a une utilité assez limitée, mais c’est une bonne occasion d’isoler une fonctionnalité pour la proposer comme bibliothèque. Le code était initialement écrit en Objective-C, j’en ai donc profité pour le transposer en Swift.


https://github.com/vtourraine/ThirdPartyMailer