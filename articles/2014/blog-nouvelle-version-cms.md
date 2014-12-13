Title:    Nouvelle version du blog  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     December 13, 2014  
Update:   
Keywords: blog, cms  
Summary:  Ce n’est pas le printemps, mais ce blog vient de faire peau neuve. Je ne parle pas d’un petit sélecteur CSS légèrement modifié, non, c’est un reboot complet de l’interface et du moteur. Et ce ne serait pas vraiment un blog si je n’en profitais pas pour décrire ces changements sous la forme d’un billet. Dont acte.  
Image:    http://www.vtourraine.net/blog/img/2014/blog-nouvelle-version-cms/article-new.png  
Language: fr  
Project:  

Ce n’est pas le printemps, mais ce blog vient de faire peau neuve. Je ne parle pas d’un petit sélecteur CSS légèrement modifié, non, c’est un reboot complet de l’interface et du moteur. Et ce ne serait pas vraiment un blog si je n’en profitais pas pour décrire ces changements sous la forme d’un billet. Dont acte.

Pour commencer, rien de mieux qu’un comparatif « avant/après » pour voir ce que ça donne en images :

![Page d’accueil v1, Vincent Tourraine][Home old]

![Page d’accueil v2, Vincent Tourraine][Home new]

![Article v1, Vincent Tourraine][Article old]

![Article v2, Vincent Tourraine][Article new]


## Rappel de la version précédente

Le premier billet de ce blog date du 30 septembre 2011. Je n’utilisais pas de CMS classique (WordPress, Drupal, ou autre) car je trouve toujours ça plus intéressant et plus gratifiant de faire les choses soi-même (dans la limite du possible). Il s’agissait donc d’un ensemble de pages PHP qui généraient les fichiers HTML du blog. Le corps des billets étaient stockés dans des fichiers séparés directement au format HTML, mais les métadonnées venaient d’un fichier PHP capable de créer et de manipuler les informations nécessaires.

Rien d’extraordinaire, mais le système fonctionnait correctement. Pourquoi tout reconstruire, alors ?  

Au départ, écrire les articles en code HTML ne me posait pas de problème. C’était même très puissant, puisque je pouvais contrôler exactement le code produit, avec toutes les subtilités sémantiques et formelles disponibles.

Progressivement, je me suis mis à écrire en Markdown, notamment avec l’arrivée d’iA Writer (mon éditeur de choix). La fonction d’export en HTML est très pratique, mais à sens unique : impossible de conserver le Markdown d’origine pour des modifications ultérieures sans perdre la conversion précédente.

Autre problème, stocker les métadonnées (titre, date, tags, _etc._) séparément n’est pas vraiment une bonne idée.

Après avoir découvert des moteurs plus modernes, comme [nanoc][] que nous utilisons pour le [blog de Shazino][blog Shazino], la route à prendre pour améliorer mon blog paraissait donc toute tracée.


## (Multi)Markdown

C’est simple, je ne me vois pas écrire autrement qu’avec [Markdown][]. 

À mes yeux, il s’agit de la seule solution qui permet de garder un contenu lisible et inter-opérable, tout en offrant une mise en forme satisfaisante. Ça n’a pas la richesse du code HTML, mais le compromis me convient.

Pour palier aux limitations les plus contraignantes, [MultiMarkdown][] prend le relai. En particulier, il permet de gérer un entête à l’intérieur du fichier pour stocker les métadonnées sus-citées. Exactement ce qu’il me fallait.


## Haml + Sass

Mais un blog, ce n’est pas seulement des articles, il faut aussi un moteur de rendu pour les afficher correctement, et générer au moins une page d’accueil et un flux RSS.

Pour les templates des différentes pages, j’adore utiliser [Haml][]. C’est un peu comme passer du XML au JSON : on fait globalement la même chose, mais de façon plus raisonnable.

Même chose pour la mise en forme, avec [Sass][] qui s’occupe de générer le CSS. Écrire moins pour écrire mieux.


## Un moteur Ruby

Mes compétences en Ruby sont limitées, pour dire le moins, mais ça ne m’empêche pas de gérer l’ensemble de la génération du blog dans un fichier de 150 lignes.

Globalement, il s’agit d’extraire les articles disponibles et leurs métadonnées avec MultiMarkdown, pour ensuite générer les pages nécessaires à coups de Haml, sans oublier un appel à Sass pour le style.


## Open Source (GitHub FTW)

L’intégralité du code et des articles sont disponibles sur GitHub : [https://github.com/vtourraine/blog][GitHub].

Si l’envie vous prend, vous pouvez donc m’aider à améliorer le moteur de génération des pages. Vous maîtrisez Ruby et vous trouvez mon code lamentable ? Excellente nouvelle : vous pouvez proposer vos améliorations. Les suggestions et autres _pull-requests_ sont grandement appréciées. Vous pouvez aussi corriger des erreurs d’orthographe ou grammaticales dans le contenu des articles.

Pour un projet encore balbutiant, j’hésite à vous encourager à le forker pour votre propre site, mais rien ne vous en empêche.


## Bonus features

Avec cette transition, le blog a perdu quelques fonctionnalités, mais il a aussi gagné de nouvelles possibilités.

- **Articles organisés par années** : j’ai tendance à éviter les dates dans les URLs, contrairement à la plupart des CMS, mais je dois reconnaître qu’avec le nombre grandissant d’articles, il fallait bien commencer à trier tout ça. Comme vous pouvez le voir, tout est maintenant rangé par année.

- **Version texte disponible** : à l’image de Daring Fireball où il suffit d’ajouter `.text` à un billet pour retrouver le fichier original ([exemple][Daring Fireball]), vous pouvez ajouter `.md` à mes articles pour visionner la version Markdown ([exemple][Source MD]).

- **Coloration syntaxique pour les extraits de code source** : ce n’est pas encore Xcode, mais avec [Highlight.js][] je peux enfin afficher mes bouts de code source convenablement.


WordPress peut continuer à dormir tranquille, ce modeste CMS a pour seule ambition de satisfaire mes propres besoins. Voilà qui devrait suffire au moins pour les 3 prochaines années.


[Home old]:    http://www.vtourraine.net/blog/img/2014/blog-nouvelle-version-cms/home-old.png
[Home new]:    http://www.vtourraine.net/blog/img/2014/blog-nouvelle-version-cms/home-new.png
[Article old]: http://www.vtourraine.net/blog/img/2014/blog-nouvelle-version-cms/article-old.png
[Article new]: http://www.vtourraine.net/blog/img/2014/blog-nouvelle-version-cms/article-new.png

[GitHub]:          https://github.com/vtourraine/blog
[nanoc]:           http://nanoc.ws
[blog Shazino]:    http://blog.shazino.com
[Markdown]:        http://daringfireball.net/projects/markdown/
[MultiMarkdown]:   http://fletcherpenney.net/multimarkdown/
[Haml]:            http://haml.info
[Sass]:            http://sass-lang.com
[Daring Fireball]: http://daringfireball.net/linked/2014/12/11/overcast-reviews.text
[Source MD]:       http://www.vtourraine.net/blog/2014/ios-boutons-couleurs.md
[Highlight.js]:    https://highlightjs.org
