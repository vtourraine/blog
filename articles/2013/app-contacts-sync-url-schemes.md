Title:    Making-of Contact[s], le retour  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     May 17, 2013  
Update:   
Keywords: iOS, making-of, sync, Contacts, iPhone  
Summary:  Inscrire un projet dans la durée, c’est bien. On aimerait pouvoir rester en état de refactoring permanent, construisant ligne après ligne le soft parfait. Seulement voilà, parfois, la meilleure solution est de tout supprimer, et de repartir de zéro.  
Image:    https://www.vtourraine.net/blog/img/app-contacts-sync-url-schemes/contacts-coffee.jpg  
Language: fr  
Project:  Contacts

Inscrire un projet dans la durée, c’est bien. On aimerait pouvoir rester en état de refactoring permanent, construisant ligne après ligne le soft parfait. Seulement voilà, parfois, la meilleure solution est de tout supprimer, et de repartir de zéro.

“Contact[s]” est une application très simple : il s’agit de proposer une alternative au carnet d'adresses standard iOS, en se concentrant sur les personnes qui importent le plus. Les favoris, les V.I.P., peu importe la façon de les appeler, il est très probable que 90% de vos interactions concernent moins de 10% de votre liste de contacts (chiffres sortis de nulle part, vous voyez le principe).

Mettre en valeur les favoris, et faciliter la mise en contact. C’est un peu le “people first” à la Facebook, ou Windows Phone (on ne sait plus très bien). Voici donc “Contact[s]”, sortie en 2011.

Après un début relativement prometteur, le nombre de téléchargements a rapidement diminué, mais surtout les retours se sont fait plutôt négatifs. En commentaires sur l’App Store ou directement par emails, les utilisateurs étaient visiblement intéressés mais déçus.

La meilleure solution me semble donc de proposer [« Contact[s] 2 »][Contacts], une refonte totale de l’application.

![Contact[s], Studio AMANgA][Contacts Wood]


## Synchronisation (iCloud ?)

Difficile d’imaginer une application personnelle sans un processus de synchronisation, aussi bien pour la sauvegarde que pour l’accès aux informations. Pour Contact[s] premier du nom, c’était justement l’année du lancement d’iCloud, une appellation fourre-tout qui comprend notamment la synchro de données gérées avec Core Data, comme c’	était le cas avec Contact[s]. La solution était donc toute trouvée. L’idée était attractive, notamment en sachant qu’Apple aime mettre en valeur les applications utilisant ses nouvelles technologies. Cette réflexion ira jusqu’à inspirer [l’icône de l’application][Tweet icone], avec son métal brossé circulaire très identifiable.

Pas de chance, [comme beaucoup le reconnaissent maintenant][The Verge iCloud], c’est précisément la fonctionnalité d’iCloud la plus problématique. Ce qui ressemblait au départ à un simple manque de documentation s’apparente maintenant à un problème systémique digne des plus gros ratés d’Apple en matière de services en ligne. Il faut dire que le problème de la synchronisation d’une base de données entre plusieurs appareils, avec gestion du mode offline, des migrations, et de tous les conflits de conciliation qui peuvent surgir est un problème complexe (le mot est faible). La solution proposée par Apple n’est pas à la hauteur de ses promesses, tout simplement.

Ce reboot de Contact[s], c’est donc l’opportunité de se débarrasser de ce choix technologique devenu embarrassant. Pour utiliser quoi ? On peut bien sûr créer son propre web service, mais dans un cas aussi commun qu’un carnet d'adresses, cette solution ne me paraît pas la plus intéressante (sans parler de la charge de travail qu’elle impliquerait).

Pourquoi reconstruire ce qui existe déjà ? Le SDK iOS propose une API relativement complète pour interagir avec le carnet d’adresses système.

La seule limitation dans le cas de Contact[s], c’est qu’il est impossible de connaître la liste des favoris déjà établie avec l’application standard. Dommage. L’utilisateur est donc obligé de recréer une liste de favoris à l’intérieur de Contact[s], mais sur la base d’un carnet d’adresses déjà existant. Les identifiants des favoris sont simplement stockés sous la forme d’un tableau de `NSString` dans le `NSUserDefault`. Basique, je sais, mais suffisant, et avec une efficacité prouvée. Pour une future mise-à-jour, on pourrait d’ailleurs imaginer stocker ce tableau avec le mécanisme de clés-valeurs iCloud, qui contrairement à son penchant à base de Core Data, fonctionne correctement.

C’est d’ailleurs la solution que j’ai retenue pour ma précédente application, le gestionnaire de tâches [1List][]. Situation similaire : l’API système existe, pourquoi réinventer la roue ? Cette approche a de plus l’avantage de bénéficier d’une intégration complète à l’OS. Synchronisation automatique avec tous les services déjà gérés, intégration à Siri, et applications tierces compatibles. Tout le monde est gagnant.


## Communication entre applications

On le reproche souvent à iOS : il y a un vrai problème de communication entre les applis. Beaucoup de bonnes raisons, ne l’oublions pas, mais aussi une frustration constante dès qu’il s’agit de partager une ressource, aussi élémentaire soit-elle. Pourtant, des solutions ponctuelles existent déjà.

C’est le cas des [« URL schemes »][URL Scheme]. Le fonctionnement est simple : une application peut se déclarer compatible avec un ensemble d’URLs sur la base d’un protocole identifié. Quelle qu’en soit l’origine, l’invocation d’URL correspondante (via Safari mobile, ou bien programmatiquement via une autre application, `UIApplication::openURL:`) déclenche l’ouverture de l’application déclarée compatible, en lui passant éventuellement les paramètres de la requête.

Ce mécanisme, invisible pour l’utilisateur, est déjà pris en charge par de nombreuses applications. Ce qui m’intéresse en particulier avec Contact[s], c’est de permettre l’utilisation d’un client mail alternatif. Vous utilisez Sparrow ou Gmail ? Ça tombe bien, elles disposent justement d’URL schemes permettant la rédaction directe d’un email avec le ou les destinataires souhaité(s). Juste ce qu’il faut à Contact[s] pour vous permettre de passer directement à votre client mail préféré lorsque vous appuyez sur l’icône en forme d’enveloppe.

Il reste juste un petit détail : on peut détecter si l’utilisateur a installé un client mail alternatif, mais ça ne signifie par forcément qu’il souhaite l’utiliser. Tant que ce paramètre n’existe pas au niveau système, il faut donc ajouter un réglage dans l’application pour lui permettre de faire son choix. Pour autant, inutile d’encombrer le panneau de réglages : si aucun client tiers n’est détecté, l’option n’apparaît pas, et c’est Apple Mail qui s’occupera de tout. Un appel à `UIApplication::canOpenURL:` suffit pour déterminer si une application est disponible ou non (d’accord, on ne teste pas vraiment la présence de l’application elle-même, mais d’une application répondant au protocole concerné, ce qui fonctionne parfaitement dans notre cas).

Nous verrons si la situation évolue avec iOS 7. En attendant on peut imaginer pour une future mise à jour de Contact[s] la prise en charge d’autres clients mail, voire même de clients Twitter. Facebook, on attend toujours un scheme pour les messages, c’est quand tu veux.

![Contact[s], Studio AMANgA, PlaceIt][Contacts Coffee]


## Contact[s], et ça repart

Voilà pour les points les plus importants. Pour le reste, je vous laisse [découvrir l’application][Contacts]. Je pense que personne ne regrettera la version précédente, reste à voir comment ce reboot va évoluer.


### Licence photo

[PlaceIt](http://placeit.breezi.com/)

[Contacts Wood]:   /blog/img/app-contacts-sync-url-schemes/contacts-wood.png
[Contacts Coffee]: /blog/img/app-contacts-sync-url-schemes/contacts-coffee.jpg

[Contacts]:         http://www.studioamanga.com/contacts
[Tweet icone]:      https://twitter.com/StudioAMANgA/status/130426884843507713
[The Verge iCloud]: http://www.theverge.com/2013/3/26/4148628/why-doesnt-icloud-just-work
[1List]:            http://www.studioamanga.com/onelist
[URL Scheme]:       http://developer.apple.com/library/ios/#featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html
