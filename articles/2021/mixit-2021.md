Title:     MiXiT 6 pour iOS et macOS  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      May 4, 2021  
Update:    
Keywords:  iOS, macOS, dev  
Summary:   La conférence MiXiT est de retour les 18, 19 et 20 mai. Le moment est donc venu de mettre à jour mon application. Il y a même quelques nouveautés cette année, avec le partage des sessions, la possibilité d’ajouter une session à votre calendrier, mais aussi une version Mac.  
Image:     https://www.vtourraine.net/blog/img/2021/mixit-2021/mixit-mac-iphone.jpg  
Language:  fr  


[La conférence MiXiT](https://mixitconf.org/) est de retour les 18, 19 et 20 mai. Le moment est donc venu de mettre à jour [mon application](https://apps.apple.com/app/mixit-conference/id982003173). Il y a même quelques nouveautés cette année, avec le partage des sessions, la possibilité d’ajouter une session à votre calendrier, mais aussi une version Mac.

![MiXiT 6 sur Mac et iPhone](/blog/img/2021/mixit-2021/mixit-mac-iphone.jpg)

Soyons clairs, avec une édition en ligne cette année et un nombre réduit de sessions, mon application n’est pas aussi utile qu’elle pouvait l’être originellement. Si c’était la première année, je n’aurais probablement pas créé une application pour l’occasion. Mais l’équipe de MiXiT fait bien les choses, et l’API pour récupérer les sessions fonctionne toujours. Aucun effort particulier pour être compatible avec cette édition 2021, je ne pouvais pas manquer l’occasion.

Pourquoi de nouvelles fonctionnalités, alors ? Tout est parti de la version Mac. Pour proposer une application universelle, il suffit de cocher une case dans Xcode (merci Catalyst), puis de remplir les métadonnées sur App Store Connect. Facile, je prépare donc cette version Mac, et la soumets à Apple. Réponse de l'équipe de validation : l’application n’est pas assez « utile » pour être acceptée sur le Mac App Store.

> We found that the usefulness of your app is limited by the minimal amount of content or features it includes. 
>
> The app only contains time table of the conference which does not meet the basic requirements for features/functionality. 

Une décision un peu étrange, puisque l’application offre strictement les mêmes fonctionnalités sur iOS, sans que cela pose problème. Je ne vais pas me lancer dans un grand débat sur la distinction entre plateformes mobiles et OS classiques, le rôle de la modération d’Apple, ou la valeur ajoutée d’une application native par rapport à une web app. J’étais juste déçu par ce rejet.

J’allais en rester là, et me contenter d’une version mobile, mais cette situation m’avait donné envie de tester les limites de cette notion « d’utilité », par exemple en proposant quelques fonctionnalités supplémentaires.

J’ai ajouté un bouton pour partager les sessions (`UIActivityViewController`), et un autre pour inscrire l’évènement à son calendrier (`EKEventEditViewController`). Il s’agit bien là d’une fonctionnalité native, dans le sens où elle dépasse ce qui est possible avec un site internet. Après tout, Catalyst a cet avantage de permettre d’améliorer simultanément une même application sur plusieurs plateformes, pourquoi ne pas en profiter ? Je soumets à nouveau l’application, et, bonne nouvelle : elle est rejetée… pour un motif différent. L’écran qui configure l’événement dans le calendrier plante sur macOS 11.3. Je n’ai pas de machine compatible pour débugger le problème, heureusement je peux contourner ça en omettant l’interface du calendrier sur le Mac, et en inscrivant l’évènement directement au calendrier. Voilà, l’application est enfin validée, elle est maintenant disponible sur le Mac App Store.

Pour rappel, [le code de l’application est sur GitHub](https://github.com/vtourraine/mixit). Prochains défis : ré-écrire avec Swift ? SwiftUI, peut-être ?
