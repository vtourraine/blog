Title:     Trackup Editor  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      February 26, 2015  
Update:   
Keywords:  trackup  
Summary:   Je cherchais un moyen simple pour gérer à la fois l’historique et la roadmap d’un projet. C’est comme ça que s’est formé « Trackup », un format à base de Markdown que j’utilise maintenant depuis plusieurs mois pour toutes mes applications iOS. Bien sûr, le format fonctionne parfaitement avec un simple éditeur de texte. Mais pour proposer des choses plus intéressantes, il me fallait une application spécialisée.   
Image:     https://www.vtourraine.net/blog/img/2015/trackup-editor/trackup-editor-icon.jpg   
Language:  fr  

Je cherchais un moyen simple pour gérer à la fois l’historique et la roadmap d’un projet. C’est comme ça que s’est formé « [Trackup][Blog Trackup] », un format à base de Markdown que j’utilise maintenant depuis plusieurs mois pour toutes mes applications iOS.

Bien sûr, le format fonctionne parfaitement avec un simple éditeur de texte. Mais pour proposer des choses plus intéressantes, il me fallait une application dédiée.

![Icône Trackup Editor][Trackup Editor Icon]

## Release Notes

Voici donc _Trackup Editor_. Si vous voulez l’essayer, le code source est disponible sur [GitHub][GitHub], les tests tournent sur [Travis][Travis]. Comme en témoigne ce screenshot, c’est surtout un grand champs texte :

![Screenshot Trackup Editor][Trackup Editor Screenshot]

(Au passage, le projet Xcode par défaut pour une « document-based application » est fantastique, pour ouvrir ou sauvegarder des fichiers, gérer les fenêtres pour chaque document, _etc._ ; il suffit littéralement de 2 lignes de code pour faire un éditeur de texte.)

La toolbar ne contient pour l’instant qu’un unique bouton, qui représente donc le seul intérêt d’une telle application. Il s’agit de l’export HTML. On pourrait utiliser un script Markdown classique, mais ici mon objectif est de générer des pages « Release Notes », pour pouvoir les utiliser directement sur le site de l’application en question. Pour cette fonction, j’ignore donc les parties en cours ou à venir, et je produis une petite page HTML avec une section par version, et une liste pour les changements. 

Trivial, on est d’accord. Mais le résultat me plaît bien. Vous pouvez voir ce que ça donne sur les pages de [1List](http://www.studioamanga.com/onelist/releasenotes) ou [Comic Book Day](http://www.studioamanga.com/comicbookday/releasenotes), par exemple.


## Roadmap

Évidemment, ce ne sont pas les idées qui manquent pour améliorer ce modeste éditeur. Avoir une coloration syntaxique serait pratique, avec éventuellement une pré-visualisation de la structure du document. Il faudrait aussi ajouter quelques options à l’export HTML, avec un CSS particulier, ou des en-têtes et pieds de pages personnalisables.

Le plus pragmatique serait sans doute de proposer une version équivalente en ligne de commande, qui permettrait ainsi d’automatiser la génération des Release Notes, voire même leur mise en ligne. Pour l’écriture des billets de blog à leur sujet, ça restera en mode manuel.


[Trackup Editor Icon]: /blog/img/2015/trackup-editor/trackup-editor-icon.jpg  
[Trackup Editor Screenshot]: /blog/img/2015/trackup-editor/trackup-editor-screenshot.jpg  

[Blog Trackup]: /blog/2013/markdown-trackup-format  
[GitHub]: https://github.com/vtourraine/trackup  
[Travis]: https://travis-ci.org/vtourraine/trackup  
