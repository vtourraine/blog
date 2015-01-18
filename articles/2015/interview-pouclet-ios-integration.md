Title:     « Pro iOS Continuous Integration », de Romain Pouclet  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      January 18, 2015  
Update:    
Keywords:  interview, livre, iOS, CI  
Summary:   
Image:     http://www.vtourraine.net/blog/img/interview-pouclet-ios-integration/pouclet-ios-integration.jpg  
Thumbnail: http://www.vtourraine.net/blog/img/interview-pouclet-ios-integration/pouclet-ios-integration-thumbnail.jpg  
Language:  fr  


Avant même le lancement du premier SDK en 2008, les développeurs iPhone OS/iOS ont toujours eu un temps d’avance sur Apple. L’intégration continue fait partie de ces sujets trop longtemps ignorés, et reste encore aujourd’hui bien discrète lors des WWDC.

Il y a deux ans, lorsque nous avons installé Jenkins sur un Mac Mini pour l’intégration continue des projets chez Shazino, je me rappelle avoir passé des jours à chercher la moindre information pertinente sur le sujet. Depuis, Apple a présenté sa propre solution intégrée à OS X Server, les « bots » Xcode. Mais le sujet reste encore largement sous-documenté.

Bonne nouvelle, voici *Pro iOS Continuous Integration*, un livre publié par Apress l’année dernière, et qui aborde enfin le sujet en couvrant les différentes solutions et en détaillant leur fonctionnement.

Lorsqu’on connaît bien le développement iOS, et qu’on suit déjà attentivement chaque WWDC, les livres qui apportent autant d’informations nouvelles sont rares. J’en ai donc profité pour poser quelques questions à l’auteur du livre, Romain Pouclet.


![_Pro iOS Continuous Integration_, photo Vincent Tourraine, CC BY-NC 4.0][Cover]


**Romain, pourrais-tu te présenter, nous dire un peu ce que tu fais, et comment tu en es venu à écrire un livre sur l’intégration continue pour iOS ?**

Effectivement moi c’est Romain, j’ai 27 ans et je vis et travail à Montréal depuis bientôt trois ans en tant que développeur iOS. J’ai toujours aimé l’automatisation et l’intégration continue, peu importe la technologie. Quand je vivais en France, j’ai eu l’occasion de travailler plusieurs fois avec la maison d’édition Eyrolles comme relecteur technique. J’ai contribué à différents ouvrages traitant de Flex, Symfony, Windows 8... et cette experience a fait que j’ai toujours eu l’envie d’écrire un livre dans un coin de ma tête. 

Du coup quand Apress m’a proposé d’écrire quelque chose sur l’intégration continue pour iOS, c’était une bonne opportunité de sortir de ma zone de confort et de tenter l’experience.


**L’intégration continue semble être un sujet souvent un peu obscur pour des projets iOS, rarement mise en œuvre. C’est juste une impression, ou y a-t-il un vrai problème sur le sujet ?**

Il faut savoir que je venais du backend où les outils d’automatisation et de qualité de code sont légions, du coup c’est effectivement quelque chose qui m’a tout de suite sauté aux yeux quand j’ai commencé à faire du développement iOS à temps plein. Je pense que les gens ont plus tendance à se concentrer sur l’aspect visuel d’une application et ne voient pas l’intérêt d’une suite de tests unitaires. 

La bonne nouvelle, c’est que c’est quand même en train de changer. Apple fait des efforts à niveau là (nouveau framework de test, Xcode bots, sample apps avec des tests...) et de nouvelles plateformes d’intégration continue font leur apparition ([Ship.io](https://ship.io), [CircleCI](https://circleci.com)...).


**C’est effectivement quelque chose qui ressort bien avec ton livre : l’apparent désintérêt d’Apple a laissé de la place et de nombreux acteurs très différents (Facebook, Atlassian, _etc_) sont arrivés pour occuper le terrain. Dans ce contexte, l’arrivée des bots Xcode est-elle vraiment une bonne nouvelle ?**

Je pense que oui, c’est toujours bon d’avoir un peu de concurrence et plusieurs acteurs qui se tirent vers le haut. C’est surtout une bonne nouvelle pour les utilisateurs parce que la mise en place d’un bot qui va compiler l’application, lancer les éventuels tests et analyser le code prend littéralement 5 minutes. 

Quand j’écrivais mon premier chapitre à propos des bots, il faut savoir que réussir à construire une application utilisant [CocoaPods](http://cocoapods.org) était vraiment chaotique et instable. J’avais vraiment des scrupules à livrer un chapitre qui demandait autant de hacks et sans garantie pour le lecteur. J’ai été vraiment content de voir Apple annoncer des améliorations majeures lors de la WWDC même si ça impliquait que je réécrive mon chapitre.


**Pour finir, si tu devais choisir une fonctionnalité à ajouter à Xcode pour les bots, ce serait quoi ?**

Je crois que si je devais souhaiter quelque chose ce serait plus d’ouverture sur le fonctionnement interne des bots et pourquoi pas pouvoir aller plus loin et brancher des outils tiers. Je pense à [OCLint](http://oclint.org) dont je parle rapidement dans mon livre, mais pas seulement. J’ai hâte de voir ce que Apple va annoncer lors de la prochaine WWDC.

***

_Je remercie Romain pour avoir pris le temps de répondre à mes questions, mais surtout pour ce livre rempli d’informations pratiques sur un sujet qui, encore une fois, en avait bien besoin.  Vous trouverez le livre sur Amazon ou directement chez l’éditeur, en format papier ou numérique._


### « Pro iOS Continuous Integration »

- [Amazon.fr](http://www.amazon.fr/dp/B00K6N4K2A)
- [Apress.com](http://www.apress.com/9781484201251)


### Romain Pouclet sur le web

- [Blog](http://palleas.github.io)
- [Twitter (@Palleas)](https://twitter.com/palleas)
- [GitHub (Palleas)](https://github.com/Palleas)

![Romain Pouclet (à droite), photo Romain Pouclet, DR][Avatar]


[Cover]:  http://www.vtourraine.net/blog/img/interview-pouclet-ios-integration/pouclet-ios-integration.jpg
[Avatar]: http://www.vtourraine.net/blog/img/interview-pouclet-ios-integration/pouclet-github-avatar.jpg
