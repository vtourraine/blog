Title:     Git, « one line » par défaut  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      October 31, 2017  
Update:    
Keywords:  git  
Summary:   Git est un outil formidable, mais souvent difficile à maîtriser à cause de sa complexité. Il y a notamment un exemple de commande, que j’utilise quotidiennement, qui pourrait être simplifiée sans perdre en utilité.  
Image:     https://www.vtourraine.net/blog/img/2017/git-one-line/git-lol.png  
Language:  fr  


Git est un outil formidable, mais souvent difficile à maîtriser à cause de sa complexité. Il y a notamment un exemple de commande, que j’utilise quotidiennement, qui pourrait être simplifiée sans perdre en utilité.

`git log` permet de lister les derniers commits. C’est très pratique pour savoir ce qui a été modifié récemment, ou tout simplement pour se souvenir de ses travaux de la veille.

![git log](/blog/img/2017/git-one-line/git-log.png)

Cette commande bien connue dispose d’une option sans doute peu utilisée, qui permet de condenser les résultats de façon à ce que chaque commit tienne sur une ligne de texte. Pour cela, il suffit de taper `git log --oneline`. Concrètement, vous obtenez uniquement la première ligne du commit, avec quelques informations très basiques. 

![git log --oneline (a.k.a. « git lol »)](/blog/img/2017/git-one-line/git-lol.png)

Dans la plupart des cas, ça me paraît amplement suffisant pour se situer dans l’historique des commits.

Voilà pourquoi j’utilise un alias me permettant d’invoquer cette option très simplement. `git lol`, pour « Log One Line ». Qui a dit qu’on ne pouvait pas s’amuser avec Git ?

Si vous voulez faire la même chose, éditez votre fichier `~/.gitconfig`, et ajoutez une section comme ceci :

```
[alias]
  lol = log --oneline
```

Je pense que `git log` devrait produire le résultat condensé par défaut, et utiliser une option pour obtenir plus de détails. Heureusement, les alias existent, et sont formidablement utiles. Tout est bon pour moins utiliser le clavier.
