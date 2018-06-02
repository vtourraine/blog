Title:     Contact[s] + ThirdPartyMailer  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 2, 2018  
Update:     
Keywords:  iOS, app, dev  
Summary:  Contact[s] est une application de gestion de carnet d’adresses, qui permet de configurer un client mail tiers. La dernière mise à jour apporte la prise en charge de Microsoft Outlook et Yahoo Mail. En coulisses, le changement est plus significatif : l’application utilise maintenant ThirdPartyMailer, un projet open source qui se concentre sur cette gestion des clients mail.  
Image:     https://www.vtourraine.net/blog/img/2018/contacts-thirdpartymailer/contacts-clients.png  
Language:  fr  

[Contact[s]](http://www.studioamanga.com/contacts/) est une application de gestion de carnet d’adresses, qui permet de configurer un client mail tiers. La dernière mise à jour apporte la prise en charge de Microsoft Outlook et Yahoo Mail. En coulisses, le changement est plus significatif : l’application utilise maintenant [ThirdPartyMailer](https://github.com/vtourraine/ThirdPartyMailer), un projet open source qui se concentre sur cette gestion des clients mail.

![Application Contact[s], sélection du client mail](/blog/img/2018/contacts-thirdpartymailer/contacts-clients.png)

Au départ, le support des clients mail tiers (par le biais des custom URL schemes) faisait simplement partie de l’application elle-même. Plus tard, je me suis rendu compte que cette fonctionnalité pouvait être utile au-delà de Contact[s], j’ai donc créé un projet open source dédié : ThirdPartyMailer. L’application est en Objective-C, la bibliothèque une réécriture en Swift. C’était aussi une bonne occasion pour me familiariser avec un nouveau langage sur un projet restreint. À ce moment, intégrer les deux me paraissait trop compliqué, notamment avec l’impossibilité d’importer les `struct` Swift dans une `class` Objective-C et certaines limitations d’Xcode et CocoaPods à l’époque. Les deux projets sont donc restés distincts.

Et puis, plus récemment, quelqu’un a posté [un commentaire](https://github.com/vtourraine/ThirdPartyMailer/issues/2) sur le repo GitHub de ThirdPartyMailer pour suggérer le support de Microsoft Outlook et Yahoo Mail. Ces applications disposent en effet de custom URL schemes, et sont donc compatibles. Après avoir implémenté leur prise en charge dans la bibliothèque, je me suis rendu compte que le moment était venu d’intégrer ThirdPartyMailer à Contact[s], pour bénéficier automatiquement de ces nouvelles fonctionnalités dans l’application.

Premièrement, [CocoaPods 1.5](http://blog.cocoapods.org/CocoaPods-1.5.0/) apporte la prise en charge des pods en Swift comme static libraries. L’intégration n’était pas impossible auparavant, mais elle se trouve ainsi simplifiée, et offre de meilleures performances au démarrage de l’application.

Ensuite, il s’agissait de régler le problème des `struct` Swift en Objective-C. Les clients mails de la bibliothèque sont représentés avec des `struct`, leur utilisation est donc incontournable. En y réfléchissant deux secondes, une solution consiste à ajouter une classe Swift dans le projet de l’application, pour exposer les fonctionnalités Swift dans une interface compatible avec Objective-C (`@objc`). Le code n’est pas aussi concis que je le souhaiterais, mais l’ensemble reste facile à maîtriser, et conserve une séparation nette entre l’application et la bibliothèque.

Au final, cette configuration est très appréciable. J’ai un projet open source, simple mais intéressant, qui génère un intérêt plus large. À côté, j’ai une application iOS classique, qui se base sur cette bibliothèque, mais l’interprète à sa façon, et offre cette fonctionnalité sur l’App Store.

À l’avenir, si une amélioration est apportée à ThirdPartyMailer, vous saurez que la mise à jour de Contact[s] ne sera pas loin.
