Title:    Making-of MemO’clock GeO’clock : Projets parallèles
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     November 02, 2011  
Update:   
Keywords: iOS, Making-of, gestion de projets, Xcode
Summary:  Voici la première partie d’une série de billets présentant certains aspects de la création de mes dernières applications : ce qu’on pourrait donc appeler le making-of de MemO’clock et GeO’clock. Pour commencer, je vais justement aborder le problème d’avoir à gérer plusieurs applications similaires en parallèle.
Image:    https://www.vtourraine.net/blog/img/ios-xcode-projets-parallele/drag-file-to-project.jpg
Language: fr

Voici la première partie d’une série de billets présentant certains aspects de la création de mes dernières applications : ce qu’on pourrait donc appeler le making-of de MemO’clock et GeO’clock. Pour commencer, je vais justement aborder le problème d’avoir à gérer plusieurs applications similaires en parallèle.

Il existe différentes situations face auxquelles il est nécessaire de disposer de plusieurs versions d'une même application, par exemple pour proposer une version de démonstration. Dans le cas présent, il s'agissait de produire deux applications partageant de nombreuses fonctionnalités, avec une différenciation avancée sur le type des alarmes gérées (temporaires ou bien géographiques). 

Plusieurs solutions sont envisageables pour gérer ce problème, et il importe de choisir celle qui vous conviendra le mieux, car cette décision aura probablement un impact à long terme sur le projet.


## Partage de fichiers

D'une manière générale, il est bien sûr important de ne pas réécrire un code déjà existant. Heureusement, un projet Xcode gère ses fichiers par références, ce qui signifie que l'on peut facilement inclure un même fichier source dans plusieurs projets différents (donc sans recopier le fichier sur le disque). Il suffit pour cela de glisser le fichier dans l'arborescence du projet :

![Xcode : drag file][Drag file]

Parmi les options proposées, il faut bien décocher la fonction de copie (première ligne), pour garder une seule version du fichier manipulé :

![Xcode : add file by reference][Add file reference]

Si, pour une quelconque raison, ces références ont besoin d'être modifiées plus tard, vous pouvez toujours accéder aux valeurs en question avec l'inspecteur, lorsque le fichier est sélectionné :

![Xcode : inspect file][Inspect file]

Cette approche ne s'arrête pas au code source. Si vous en avez l'utilité, n'hésitez pas à partager des ressources graphiques entre les projets, ou tout autre fichier commun aux applications concernées.


## Constantes préprocesseur

Les projets ainsi couplés utilisent donc souvent des fichiers communs, mais qu'il faudra paramétrer au moment de vouloir les différencier selon le projet concerné. Il peut s'agir, par exemple, d'inclure des boutons différents à un même endroit de l'écran, ou simplement d'afficher un texte spécifique. 

La solution que j'ai retenue dans ce cas consiste à évaluer la présence d'une constante préprocesseur associée au projet en particulier. Il s'agit d'une vieille solution, dans la tradition du langage C qui constitue, on peut toujours le rappeler, la base des projets iOS. 

Il faut donc ajouter une constante au niveau de la configuration de chaque projet avec Xcode. Pour cela, allez dans les paramètres du projet/cible, à l'onglet « Build Setting », vous trouverez le paramètre « Preprocessing » - « Preprocessor Macros ». C'est ici que vous pouvez spécifier une constante qui vous servira à identifier le projet, pour tous les profils de compilation :

![Xcode : préprocesseur][Preprocessor]

À partir de là, la valeur de cette constante pourra donc être évaluée au moment de la compilation, en fonction du projet. Dans vos fichiers sources, il suffit d'utiliser les routines `#ifdef` et `#endif, de la manière suivante :

``` objc
#ifdef GEOCLOCK
  // faire quelque chose
#endif
	
#ifdef GEOCLOCK
  // faire quelque chose
#else
  // faire autre chose
#endif
```

Et voilà. La démarche est assez simple, et les commandes préprocesseur peuvent être utilisées partout dans le code, vous pouvez donc en contrôler facilement n'importe quelle partie. 


## Conclusion

Selon votre expérience des langages de programmation, cette solution pourra vous paraître surprenante, voire inappropriée. Elle permet en tout cas de maîtriser précisément votre code au moment de sa compilation. Libre à vous de l'utiliser selon votre besoin. Cette technique peut d'ailleurs trouver son utilité dans d'autres cas, rien ne vous empêche de vous en inspirer pour répondre à des problèmes différents. 


[Drag file]: /blog/img/ios-xcode-projets-parallele/drag-file-to-project.jpg
[Add file reference]: /blog/img/ios-xcode-projets-parallele/add-file-by-reference.jpg
[Inspect file]: /blog/img/ios-xcode-projets-parallele/inspect-file.jpg
[Preprocessor]: /blog/img/ios-xcode-projets-parallele/preprocessor.jpg
