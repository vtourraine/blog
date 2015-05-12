# Rappels pour l’Apple Watch

Parmi les premières apps Apple Watch disponibles, on trouve de nombreux gestionnaires de rappels, to-do, et autres GTD. Clear, Wunderlist, Things, tous ont répondu à l’appel de WatchKit. 

Tous ? Non ! Une application fait clairement défaut : Reminders, a.k.a. Rappels, l’application d’Apple. Vous pouvez demander à Siri de créer un nouveau rappel depuis votre montre, mais vous ne pouvez pas les consulter.

Il se trouve que je développe depuis 2012 une application iPhone/iPad qui permet de gérer ses rappels iOS. Le SDK propose en effet une API complète pour y accéder, modifier les données existantes, et même créer de nouvelles entrées (cf. `EKReminder`, [documentation](https://developer.apple.com/library/prerelease/ios/documentation/EventKit/Reference/EKReminderClassRef/index.html)). 
