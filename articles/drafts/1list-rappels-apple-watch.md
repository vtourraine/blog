# Rappels pour l’Apple Watch

Parmi les premières apps Apple Watch disponibles, on trouve de nombreux gestionnaires de rappels, to-do, et autres GTD. Clear, Wunderlist, Things, tous ont répondu à l’appel de WatchKit. 

Tous ? Non ! Une application fait clairement défaut : Reminders, a.k.a. Rappels, l’application d’Apple. Vous pouvez demander à Siri de créer un nouveau rappel depuis votre montre, mais vous ne pouvez pas les consulter.


## Encore une application de to-do

Il se trouve que je développe depuis 2012 une application iPhone/iPad qui permet de gérer ses rappels iOS (je sais, ce n’est pas très original). Le SDK propose en effet une API complète pour y accéder, modifier les données existantes, et même créer de nouvelles entrées (cf. `EKReminder`, [documentation](https://developer.apple.com/library/prerelease/ios/documentation/EventKit/Reference/EKReminderClassRef/index.html)). 

« 1List », comme son nom l’indique, se concentre sur une liste à la fois. On peut en sélectionner une autre quand on le souhaite, mais cette application est vraiment conçue pour les personnes utilisant principalement une seule liste. Typiquement, il s’agit de la liste des courses. Je n’ai aucun chiffre, mais je suppose que c’est une situation assez courante. L’autre avantage de 1List est de proposer des suggestions basées sur l’historique des rappels déjà saisis. Encore une fois, adapté pour une liste de courses.


## Opportunité (manquée)

Pas d’application officielle Rappels sur Apple Watch, c’était donc l’opportunité rêvée pour 1List. 

Petit problème : j’ai complètement ignoré cette magnifique occasion pendant les six derniers mois où WatchKit était disponible en beta, pour me réveiller lorsque la montre est enfin arrivée, il y a seulement quinze jours. Voilà, c’est un peu embarrassant.

Ce n’est pas faute de ne pas y avoir pensé, mais parce qu’il me semblait évident qu’Apple allait proposer Rappels, comme sur iPhone et iPad. Cette hypothétique application n’a jamais été évoquée au cours des deux keynotes Apple Watch, et l’abscence d’icône sur les aperçus de l’interface auraient dû suffir à me convaincre de son absence. 

Le manque est évidement beaucoup plus remarquable lorsqu’on utilise enfin la montre. Plusieurs articles l’ont rapidement remarqué. À chaque fois, la même frustration : pourquoi n’ai-je pas préparé 1List en avance, pour pouvoir profiter de l’occasion ?

C’est d’autant plus regrettable que le développement de l’application pour WatchKit dans ce cas précis est trivial, avec une liste, et la réponse à un évènement pour marquer un rappel comme `completed`. Ce n’est pas pour rien que les applications to-do sont souvent utilisés comme des exemples basiques pour présenter un nouveau framework. Bien sûr, l’intéraction avec l’API `EKReminder` était déjà prise en charge par mon application iOS. Encore mieux, l’API WatchKit pour saisir un texte avec Siri propose directement l’affichage de suggestions, me permettant d’implémenter très facilement.

La dernière mise à jour, disponible depuis cette semaine, étend l’application à l’Apple Watch. 
