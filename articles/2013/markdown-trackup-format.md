Title:    Trackup  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     September 06, 2013  
Update:   
Keywords: Markdown, Trackup  
Summary:  Après avoir parlé des gestionnaires de tâches, passons aux choses sérieuses : les gestionnaires de projets. Attention, je préfère clarifier les choses tout de suite : il s’agit uniquement de gérer les features d’une application; passées, en cours et à venir.  
Image:    
Language: fr  
Project:  

Après avoir parlé des gestionnaires de tâches, passons aux choses sérieuses : les gestionnaires de projets. Attention, je préfère clarifier les choses tout de suite : il s’agit uniquement de gérer les features d’une application; passées, en cours et à venir.

Comment gérer l’évolution d’une application, en traçant l’historique des versions, tout en planifiant une roadmap, mais également les fonctionnalités en cours de développement ?

Oh bien sûr, il existe des dizaines de façons d’aborder ce problème, mais aucune ne me convient vraiment. Le gestionnaire de tâches généraliste est pratique, mais peu adapté. Le bugtracker est pertinent pour les corrections, mais gère mal les features de haut niveau. GitHub, comme toujours, propose des outils intéressants. Mais entre les “issues”, les “milestones” et maintenant les “releases”, l’ensemble manque de cohérence à mon goût.

Permettez-moi de faire mon [Gruber](http://daringfireball.net/colophon/) le temps de cet article, pour proposer un format simple, qui permettrait de régler ce problème tout en encourageant le développement d’outils pour en faciliter l’utilisation dans divers contextes. Je vous présente “Trackup”.

Tout le monde aime [Markdown](http://daringfireball.net/projects/markdown/) (en tout cas, je n’ai jamais entendu quelqu’un s’en plaindre). Gardons donc les bonnes idées : un simple fichier texte, avec une syntaxe “naturelle” et lisible. Voilà ce que ça pourrait donner pour tracer des features :

``` md
# InstaMétéoVetica

Description générale facultative…

## Roadmap

- Mise à jour pour iOS 8
- Affichage de la température

## 1.2

- [X] Mise à jour pour iOS 7
- [ ] Re-nouvelle icône

## 1.1

_2013-02-01_

- Prévisions
    - Connexion à l’API
    - Stockage des données
    - Nouvelle vue
- Nouvelle icône
- Correction de bugs
    - Bug #1
    - Bug #2

## 1.0

_2013-01-01_

Description propre à la version, liens de téléchargement, toujours facultatifs…

- Calcul des données
- Jolie interface
```

L’ordre des versions est antéchronologique, comme souvent pour les changelogs. On peut facilement étendre les données en ajoutant des dates, des liens et des descriptions. Possibilité de créer des sous-listes, ça peut toujours être pratique.

Au final, c’est donc bien un fichier Markdown. C’est la beauté de la chose : tous les éditeurs correspondants sont directement compatibles. Mais alors pourquoi *encore* une nouvelle sur-syntaxe à Markdown ? Parce que celle-ci répond à un besoin bien particulier, en tout cas pour moi. 

Un tel fichier placé à la racine d’un repository hébergé sur GitHub bénéficiera d’une mise en forme et d’un moteur d’édition en ligne très poussés. Et ce n’est que le début. Si je trouve un peu de temps libre, ou si quelqu’un est intéressé, il serait possible de développer une (des) application(s) pour lire et écrire ce genre de fichiers. Pouvoir cocher les features lorsqu’elles sont prêtes, réorganiser les éléments par drag-n-drop, se connecter à l’API GitHub pour créer les releases automatiquement, etc. 

Dernière proposition : utiliser l’extension `.tu.md.` Oui, c’est un peu moche, mais ce serait dommage de se priver de la prise en charge Markdown, et ce serait triste sans une extension dédiée. N’hésitez surtout pas à partager vos commentaires, je serais ravi de mettre à jour cet article avec vos retours.
