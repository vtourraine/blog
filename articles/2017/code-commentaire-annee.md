Title:     Commentaire en-tête  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      January 26, 2017  
Update:    
Keywords:  dev
Summary:   À la création d’un nouveau fichier, Xcode insère systématiquement un en-tête contenant des renseignements de base : nom du fichier et du projet, le créateur, la date de création, et le nom de l’organisation attachée au projet.  
Image:     http://www.vtourraine.net/blog/img/2017/code-commentaire-annee/comment-header.png  
Language:  fr  


À la création d’un nouveau fichier, Xcode insère systématiquement un en-tête contenant des renseignements de base : nom du fichier et du projet, le créateur, la date de création, et le nom de l’organisation attachée au projet.

![Commentaire Xcode](http://www.vtourraine.net/blog/img/2017/code-commentaire-annee/comment-header.png)

Vous avez alors trois options. **Ignorer** complètement cette partie du fichier, et la laisser telle quelle. La **supprimer**, tout simplement. Ou encore la **remplacer** avec un autre format spécifique à votre entreprise ou à votre projet. Le choix le plus raisonnable consiste probablement à se débarrasser de cet en-tête. Il ne remplit aucune fonction particulière, et ces métadonnées sont déjà systématiquement gérées par votre logiciel de gestion de versions (`git log/diff/blame`, etc).

Un peu par paresse, j’ai tendance à laisser ce bloc dans mes codes sources. Mais je lui apporte une modification significative, une fois par an : j’actualise l’année du copyright.

![Commentaire Xcode mis à jour](http://www.vtourraine.net/blog/img/2017/code-commentaire-annee/comment-header-updated.png)

De cette manière, à chaque fois que j’ouvre un fichier, je peux me faire une idée de son historique en un clin œil. Par exemple : « 2017 » ? Voilà une classe toute récente. « 2014 » ? Ça fait longtemps que je n’y ai pas touché, ça mérite peut-être une mise-à-jour de certaines APIs. « 2008-2016 » ? Woooow, ce fichier est probablement là depuis le début de ce projet, mais il est toujours d’actualité. Et donc, si j’édite un fichier pour la première fois cette année, je peux très simplement modifier l’en-tête pour suivre son évolution.

Comme je le disais juste avant, cette information est parfaitement superflue (et potentiellement erronée, si j’oublie de la mettre à jour), puisque tous mes fichiers sont tracés avec git. Mais je tiens tout de même à cette pratique. D’abord parce qu’elle demande très peu d’efforts de mise en place. Mais surtout parce qu’elle permet de mettre en perspective chaque fichier. C’est difficile à décrire concrètement, mais le simple fait de savoir quand un fichier a été modifié permet de l’aborder plus consciencieusement. C’est un moyen très rapide pour se remettre en situation. Pour une relecture ou pour y apporter de nouvelles modifications, ou encore pour s’amuser à retrouver des antiquités.
