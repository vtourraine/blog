Title:    iOS 6 : quoi de nouveau pour les développeurs ?  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     September 18, 2012  
Update:   
Keywords: iOS, iPhone, iPad, Xcode, Objective-C  
Summary:  La dernière version d’iOS apporte son lot de nouveautés, pour la plupart déjà bien connues. Les développeurs ne sont pas en reste, avec de nombreuses API à (re)découvrir. J’en profite pour exposer les points qui me paraissent les plus intéressants.  
Image:    https://www.vtourraine.net/blog/img/ios-6-api-sdk/maps-reimagined.png  
Language: fr  
Project:  

La dernière version d’iOS apporte son lot de nouveautés, pour la plupart déjà bien connues. Les développeurs ne sont pas en reste, avec de nombreuses API à (re)découvrir. J’en profite pour exposer les points qui me paraissent les plus intéressants.


## Maps

*TL;DR : nouvelles cartes, même code*

C’est une des grandes nouveautés d’iOS 6. Apple est très fière de son nouveau service, et on peut le comprendre. Reste à savoir si l’utilisateur s’y retrouvera. Une chose est sûre : côté développeur, rien ne change. Le framework reste le même, et affichera simplement les nouvelles cartes Apple sur les appareils équipés d’iOS 6, tout en gardant les cartes Google Maps pour les versions précédentes de l’OS.

On trouve bien quelques nouveautés, notamment pour les applis de calcul d’itinéraire. Mais dans la plupart de cas, pas une seule ligne à changer.

[Location Awareness Programming Guide](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/LocationAwarenessPG/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009497)

![iOS Maps][Maps]


## Pass Kit

*TL;DR : intéressant mais compliqué à mettre en œuvre*

Le paiement par mobile, c’est l’avenir, mais comme Apple préfère prendre son temps, il faudra se contenter des tickets et des cartes de réduction pour l’instant avec l’application Passbook. La promesse est déjà énorme. Seulement voilà, la solution est relativement complexe à mettre en place, et surtout dépend entièrement de la bonne volonté des entreprises concernées.

Techniquement, le framework (Pass Kit) est comparable à celui des Push Notifications, ou à Newsstand (oui, c’est une comparaison assez vague, je le reconnais). Disons qu’il ne suffit pas d’avoir une appli, il faut surtout avoir le web service qui va avec. Techniquement, les solutions prêtes-à-l’emploi <a href="https://github.com/mattt/passbook_rails_example">existent déjà</a>. Mais quand on constate qu’aucun des grands quotidiens français n’est compatible Newsstand, entre contraintes économiques et techniques, on peut craindre un avenir similaire pour Passbook. Les États-Unis, c’est une chose, la France, c’est autre chose. Si la SNCF pouvait me donner tort, ce serait déjà magnifique.

[Passbook Programming Guide](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/PassKit_PG/Chapters/Introduction.html#//apple_ref/doc/uid/TP40012195)

![iOS Passbook][Passbook]


## Reminders

*TL;DR : une API pour les rappels*

Tout simplement une API pour consulter et modifier la liste des rappels gérés par l’application officielle du même nom. Date, heure, position géographique, tout y est.

Idéalement, les très nombreuses applications tierces proposant la même chose pourraient ainsi en profiter pour mettre en commun leurs données (plus simple et plus adapté que de gérer une synchro iCloud, c’est appréciable). Ceci dit, il est peu probable que les applis les plus populaires renoncent ainsi à leurs données. Cela fait plusieurs mois que je jongle entre <a href="http://culturedcode.com/things/">Things</a> et Reminders, aussi bien sur iOS que sur OS X, et je pense que ma vie serait plus simple avec un seul gestionnaire de tâches.

Ce n’est pas grand chose, mais on peut imaginer de nombreux usages plus ou moins détournés. Une appli de cuisine pourrait regarder votre liste de courses (~~et afficher des publicités ciblées~~ très mauvaise idée) et vous proposer des recettes adaptées. Sans oublier l’interaction, même indirecte, avec Siri. Une commande vocale pour créer un rappel, une appli tierce pour le consulter et en faire quelque chose.

[Event Kit Framework Reference](https://developer.apple.com/library/ios/documentation/EventKit/Reference/EventKitFrameworkRef/_index.html#//apple_ref/doc/uid/TP40009662)

![iOS Reminders][Reminders]


## Vue « collection »

*TL;DR : enfin une UITableView bi-directionnelle*

L’affichage des listes avec UITableView, c’est bien, c’est même incontournable. Et ça permet de s’adapter à un écran 4 pouces sans trop toucher au code existant. Mais pour certains éléments, et en particulier sur l’iPad, une vue en “grille” est beaucoup plus adaptée.

Bonne nouvelle, donc, Apple propose enfin une vue dédiée, la UICollectionView, et son copain le UICollectionViewController. Seconde bonne nouvelle, le fonctionnement est strictement identique à celui d’une UITableView, à savoir utilisation d’un data source et d’un delegate. Facile à maîtriser, très utile : vous allez adorer.

[Collection View Programming Guide for iOS](https://developer.apple.com/library/ios/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40012334)

![iOS UICollectionView][UICollectionView]


## Auto layout

*TL;DR : autoresizemask, en plus complet*

Pour adapter une même vue à plusieurs tailles d’écran (c’est-à-dire portrait/paysage, iPhone/iPad), il convenait jusqu’ici d’utiliser le champs autoresizeMask. Cette simple variable ne permettant pas de s’adapter à toutes les configurations possibles, iOS 6 apporte donc un mode de positionnement alternatif, baptisé “auto layout”.

L’idée est de pouvoir fixer un ensemble de contraintes de différentes natures à chacune des vues, ou à partager des caractéristiques communes. Il est donc désormais possible de fixer des dispositions plus complexes, pour mieux s’adapter à chaque écran. On peut par exemple fixer un alignement en fonction d’une autre vue (et pas seulement de la vue parente), ou coordonner plusieurs vues avec une même largeur.

Si vous utilisiez déjà du code spécifique pour le dimensionnement de vos et/ou si l’arrivée d’un écran 4 pouces vous fait peur, auto layout est fait pour vous.

[Cocoa Auto Layout Guide](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/Articles/Introduction.html#//apple_ref/doc/uid/TP40010853)


## Xcode 4.4+

*TL;DR : moins de code*

Je profite de l’article pour rappeler que les dernières versions d’Xcode embarquent quelques nouveautés très intéressantes pour les développeurs, à savoir l’extension des literals à la plupart des types Foundation. Adieu `NSNumber numberWithInt:]`, adieu `[NSDictionary dictionaryWithKeysAndObjects:]`, etc, bonjour `@`. Vous pourrez également vous passer des `@synthesize` pour vos propriétés.

Moins de code (déjà illisible) pour faire la même chose, c’est toujours une excellente nouvelle. Et ces nouveautés ne concernant pas iOS 6 en particulier, vous pouvez en profiter sur tous vos projets.

![Icône Xcode, Apple][Icone Xcode]


## Conclusion

Encore une fois, Apple continue à étendre les capacités de son OS et des API qui l’accompagnent. Rien de bouleversant, comme pour l’iPhone lui-même, mais beaucoup de nouveautés appréciables qui s’intégreront progressivement à l’écosystème déjà présent.


### Références

- [What’s New in iOS 6](https://developer.apple.com/library/ios/#releasenotes/General/WhatsNewIniPhoneOS/Articles/iOS6.html#//apple_ref/doc/uid/TP40011812-SW1)
- [iOS 5.1 to iOS 6.0 API Differences](https://developer.apple.com/library/prerelease/ios/#releasenotes/General/iOS60APIDiffs/)


[Maps]:             /blog/img/ios-6-api-sdk/maps-reimagined.png
[Passbook]:         /blog/img/ios-6-api-sdk/passbook-syd-lax.png
[Reminders]:        /blog/img/ios-6-api-sdk/reminders.png
[UICollectionView]: /blog/img/ios-6-api-sdk/uicollectionview.png
[Icone Xcode]:      /blog/img/xcode-4-workspaces/xcode-icon.png
