Title:     Comment gérer un projet, de la feuille de route aux notes de version, avec un seul fichier  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      March 24, 2022  
Update:    
Keywords:  dev  
Summary:   Pour tous mes projets perso, j’utilise un système simple pour gérer les développements passés, présents et futurs. En d’autres termes : feuille de route, suivi de progression et notes de version. Tout ça, avec un seul fichier texte.  
Image:     https://www.vtourraine.net/blog/img/2022/gestion-projet-todo-release-notes/memorii-trackup.jpg  
Language:  fr  


Pour tous mes projets perso, j’utilise un système simple pour gérer les développements passés, présents et futurs. En d’autres termes : feuille de route (roadmap), suivi de progression (to-do, issue/bug tracking) et notes de version (release notes). Tout ça, avec un seul fichier texte.

[J’en ai déjà parlé sur ce blog](https://www.vtourraine.net/blog/2013/markdown-trackup-format), quand j’ai commencé à utiliser ce système en… 2013. Et ça n’a pas beaucoup changé depuis ! Mais je continue de l’utiliser, signe d’une réelle utilité, en tout cas pour moi. Voilà qui mérite donc une petite actualisation.

J’appelle ça le fichier « Trackup », et il s’agit essentiellement d’un fichier Markdown (ha ha), avec des listes organisées par versions. En voici un exemple :

![Fichier Trackup pour Memorii](/blog/img/2022/gestion-projet-todo-release-notes/memorii-trackup.jpg)

Quelques métadonnées, une roadmap, puis la version en cours de développement avec des cases à cocher pour suivre où j’en suis, et enfin la liste des versions passées, avec leur date de publication.

OK, un simple fichier texte. Et alors ?

Oui, c’est un fichier texte, on peut donc l’ouvrir avec n’importe quel éditeur. C’est surtout un fichier Markdown, qui bénéficie donc d’un écosystème d’applications adaptées (y compris Xcode). La mise en forme automatique est appréciable, et certains éditeurs proposent même de cocher les cases avec un clic. Pas mal, pour un simple fichier texte.

Je place le fichier dans le repo de l’application. Il est donc versionné, pull-requestable, et tout ce qui va avec.

Pour aller plus loin, [j’ai développé un projet](https://github.com/vtourraine/trackup) accessible en ligne de commande, qui charge un fichier Trackup et l’exporte sous forme de notes de version au format HTML, avec un minimum de CSS pour la mise en forme. Mieux, j’ai intégré cet outil à mes projets Xcode, avec une « build phase » qui tient le fichier à jour après chaque compilation.

![Projet Xcode pour Memorii](/blog/img/2022/gestion-projet-todo-release-notes/memorii-build-phases.jpg)

Le fichier est ensuite uploadé sur [le site de l’application](https://www.studioamanga.com/memorii/releasenotes), permettant la publications de notes de version détaillées, comme je les aime.

![Notes de version pour Memorii](/blog/img/2022/gestion-projet-todo-release-notes/memorii-release-notes.jpg)

Bien sûr, cette approche ne fonctionne que pour des projets modestes, avec une petite équipe. Trackup ne va pas remplacer Jira. Mais je suis content de l’utiliser, et je pense qu’il pourrait bénéficier à d’autres développeurs.

Sa première qualité est d’être simple. Sa deuxième qualité est d’être extensible. J’envisage par exemple d’ajouter un export au format JSON, pour obtenir une sorte d’API des versions. Ce qui ouvrirait la porte à d’autres utilisations : une application pourrait ainsi présenter ses notes de version avec une interface native. Etc, etc. Les suggestions sont les [bienvenues](https://github.com/vtourraine/trackup/pulls).
