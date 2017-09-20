Title:    Bien gérer mes rappels, tous mes rappels  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     July 05, 2013  
Update:   
Keywords: rappels, todo, GTD, app  
Summary:  S’il y a bien une chose que j’envie aux ordinateurs, c’est leur mémoire. Il m’arrive constamment d’oublier des choses, même les plus élémentaires. Pour palier à cette fâcheuse tendance, j’utilise donc une application de rappels. Ou plutôt deux applications. Sans compter la dizaine d’autres que je garde installées, au cas où. C’est grave, docteur ?  
Image:    https://www.vtourraine.net/blog/img/rappels-todo-gtd/things.jpg  
Language: fr  
Project:  1List  

S’il y a bien une chose que j’envie aux ordinateurs, c’est leur mémoire. Il m’arrive constamment d’oublier des choses, même les plus élémentaires. Pour palier à cette fâcheuse tendance, j’utilise donc une application de rappels. Ou plutôt deux applications. Sans compter la dizaine d’autres que je garde installées, au cas où. C’est grave, docteur ?


## Things pour l’organisation

« [Things](http://culturedcode.com) » est une famille d’applications pour OS X et iOS, qui reprend les concepts de la fameuse méthodologie « [GTD](http://en.wikipedia.org/wiki/Getting_Things_Done) » (getting things done). C’est mon principal outil de gestion de tâches.

![Things, Cultured Code][Things]

Je commence par ajouter un nouveau rappel, qui se place automatiquement dans l’“Inbox”. Dès que j’ai un peu plus de temps, je classe les éléments ainsi accumulés : “Next” pour les choses qui peuvent attendre, “Someday” pour les idées que je souhaite simplement garder de côté, mais surtout “Today” pour ce qui est prioritaire.

Ce qui me plaît beaucoup avec Things, c’est la possibilité d’organiser les rappels dans des projets. Je regrette parfois de ne pas pouvoir gérer des sous-tâches, mais la notion de projet, associée à des tags, reste satisfaisante. Bref, des fonctionnalités classiques mais parfaitement exécutées. Comme par exemple leur solution de synchronisation entre différents appareils, mise en place alors qu’Apple présentait iCloud. [Things Cloud](http://culturedcode.com/things/cloud/) est rapide et fiable, et c’est tout ce qu’on lui demande.

Une application qui évolue lentement, mais sûrement. Le design est soigné, et je suis curieux de voir comment leur interface va s’adapter à iOS 7.


## One List To Rule Them All

C’est bien beau de pouvoir organiser tous ces rappels, mais il reste une liste de tâches un peu spéciale, qui mérite une attention toute particulière : la liste des courses.

Bien sûr, rien ne m’empêche de gérer ça avec Things. Mais l’idée de créer un “projet” intitulé “courses” ne me satisfait pas. Ce n’est pas aussi pratique à accéder lorsque j’en ai besoin, et surtout ça ne me paraît pas à sa place. Et pas question de noter ça sur un carnet en papier. Il me faut donc une seconde app de gestion de rappels pour mes courses. 

Je pourrais utiliser [Clear](http://www.realmacsoftware.com/clear/), avec sa simplicité légendaire, mais je n’ai jamais vraiment accroché au concept. Son interface me paraît finalement trop distrayante, et elle n’apporte aucune fonctionnalité différenciante.

Ma solution par défaut, c’était donc “Rappels/Reminders”, l’application iOS standard. Très complète, avec en bonus une intégration de l’API de geofencing que j’adore. Ceci dit, toute cette interface (assez moche à mon goût) n’est vraiment pas optimisée pour le cas de la liste de courses. Il n’en fallait pas plus pour me pousser à développer ma propre application : « [1List](http://www.studioamanga.com/onelist/) ». Je ne vais pas m’étendre ici à son sujet, mais cette solution convient parfaitement à son cas d’utilisation. Simple et rapide à utiliser, avec une autocomplétion basée sur mon historique puisque j’achète constamment les mêmes choses. Une application vraiment sur mesure.

![1List, Studio AMANgA][1List]


## ToDo entre amis (et collègues)

Dans un monde numérique où tout est social, qu’en est-il de mes rappels ? Non, je n’ai pas besoin de partager ma liste de courses, mais on peut très facilement trouver des exemples de listes de tâches qui bénéficieraient à être mises en commun. Pour le boulot, bien sûr, mais aussi pour préparer un voyage entre amis, _etc_.

Aucun de mes deux outils de rappels ne gère vraiment cet aspect de partage des éléments ou de multiples utilisateurs. Je travaille parfois avec [Kickoff](http://kickoffapp.com), une plateforme qui est justement spécialisée sur le travail collaboratif sous forme de listes de tâches. L’application est déjà très intéressante, malheureusement le studio qui l’a conçue vient d’être racheté et ne prévoit pas de poursuivre activement son développement.

![Kickoff][Kickoff]

Dans une certaine mesure, GitHub est l’outil par excellence de travail collaboratif. Les « [issues](https://github.com/blog/831-issues-2-0-the-next-generation) » sont bel et bien des tâches, organisées, attribuées, détaillées. Je ne me sens pas prêt à gérer ma liste de courses avec un repository Git, mais on peut pourtant imaginer des utilisations de Git(Hub) dépassant le cadre de la production de code informatique.

![GitHub Issues, GitHub][Issues]

Mais je m’égare. Une chose est sûre, ce ne sont pas les outils qui manquent. Voilà, mon cerveau peut se reposer tranquillement, tous mes rappels sont gérés et organisés comme il convient. Et pendant ce temps-là, j’attends toujours les implants cérébraux permettant d’améliorer ma mémoire.


[Things]:  /blog/img/rappels-todo-gtd/things.jpg
[1List]:   /blog/img/rappels-todo-gtd/onelist.png
[Kickoff]: /blog/img/rappels-todo-gtd/kickoff.png
[Issues]:  /blog/img/rappels-todo-gtd/github.jpg
