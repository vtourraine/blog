Title:     Nano Notes, un peu de lecture sur Apple Watch  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      April 25, 2019  
Update:    
Keywords:  iOS, app, dev  
Summary:   Parfois, je veux lire sur mon Apple Watch. Oui, l’écran a la taille d’un timbre. Apple a sûrement une bonne raison pour ne pas proposer son application Notes sur watchOS. Mais, parfois, je veux lire sur mon Apple Watch. J’ai donc décidé de développer une application pour remplir ce rôle. Elle s’appelle Nano Notes, et vous pouvez la télécharger gratuitement sur l’App Store.  
Image:     https://www.vtourraine.net/blog/img/2019/nano-notes/nano-notes-app-store-en.jpg  
Language:  fr  


Parfois, je veux lire sur mon Apple Watch. Oui, l’écran a la taille d’un timbre. Apple a sûrement une bonne raison pour ne pas proposer son application _Notes_ sur watchOS. Mais, parfois, je veux lire sur mon Apple Watch. J’ai donc décidé de développer une application pour remplir ce rôle. Elle s’appelle [Nano Notes](https://www.studioamanga.com/nanonotes/), et [vous pouvez la télécharger gratuitement sur l’App Store](https://itunes.apple.com/app/id1445942906?mt=8).

![Nano Notes (anglais)](/blog/img/2019/nano-notes/nano-notes-app-store-en.jpg)

## Synchronisation avec l’iPhone

L’application sur la montre fonctionne en lecture seule. Pour y ajouter un texte, il faut donc passer par l’application sur l’iPhone qui lui est associé. 

Ceci dit, j’envisage également l’édition des notes depuis l’Apple Watch avec une prochaine mise à jour. Dans ce contexte, l’application remplirait un rôle de dictaphone. Pour l’instant, je veux me concentrer sur la lecture.

## Interface par défaut

Comme vous pouvez le constater avec le screenshot ci-dessus, l’interface de l’application est aussi basique que possible. Minimaliste, non-existante, épurée, bâclée, c’est à vous de voir. Il s’agit donc exclusivement d’éléments fournis par UIKit, sans modification. Le seul texte propre à l’application est le titre « Nano Notes » en haut de l’écran principal.

L’utilisation d’éléments d’interface standardisés permet avant tout de simplifier son utilisation. Lorsqu’il ouvre l’application pour la première fois, l’utilisateur reconnaît ces éléments familiers, et comprend instinctivement leur fonctionnement. Par exemple, le bouton pour rédiger une nouvelle note est identique au bouton pour rédiger un nouvel email dans l’application _Mail_.

Dans la pratique, rien n’est jamais aussi simple, mais il s’agit d’un excellent principe directeur pour la conception d’une interface.

## i18n

Par ailleurs, cette approche me permet de proposer l’application dans d’autres langues, sans avoir à traduire quoi que ce soit. Les boutons _Edit_, _Done_ et _Delete_ sont traduits automatiquement, et le reste utilise des icônes (_Compose_, _Share_).

Cette situation est un peu exceptionnelle, et s’adapte difficilement à la gestion des langues avec iOS. Afin d’éviter des interfaces partiellement traduites, une application doit explicitement déclarer les localisations qu’elle supporte. Au niveau de l’App Store, il faut là-aussi déclarer les localisations prises en charge, et fournir les descriptions et screenshots correspondant. Pas de traduction automatique possible de ce côté. Enfin pas vraiment.

J’ai limité les métadonnées de l’App Store à un minimum, avec notamment une unique phrase de description. J’ai ensuite fait appel à Google Translate pour adapter ça à quelques langues différentes (anglais, français, japonais, chinois). Je n’en suis pas particulièrement fier, mais il faut parfois savoir être pragmatique.

Pour pousser le travail de traduction un peu plus loin, j’ai tenté d’adapter le titre de l’application. J’ai pris comme référence le titre localisé de l’application _Notes_ d’Apple, en y ajoutant le préfix _nano_, lui aussi adapté. Ça ne garantit pas un résultat impeccable, mais après tout, puisqu’il s’agit d’un nom propre, la validité de cette traduction est forcément relative.  Une petite touche artisanale, en quelque sorte.

![Nano Notes (français, japonais, chinois)](/blog/img/2019/nano-notes/nano-notes-app-store-int.jpg)

## Nano Notes

Vous l’avez compris, l’application est simplissime, et la plupart des utilisateurs d’Apple Watch n’ont pas besoin de lire sur un écran de quelques centimètres. Mais si jamais c’est votre cas, [Nano Notes](https://itunes.apple.com/app/id1445942906?mt=8) est là pour vous. 
