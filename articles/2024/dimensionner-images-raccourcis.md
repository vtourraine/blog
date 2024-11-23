Title:    Dimensionner les captures d’écran sur GitHub avec Raccourcis  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     November 23, 2024  
Update:   
Keywords: dev  
Summary:  J’aime ajouter des captures d’écran à mes tickets GitHub. Une image vaut mille mots, c’est aussi vrai pour décrire un bug. Donc je partage souvent des screenshots.  
Image:    https://www.vtourraine.net/blog/img/2024/dimensionner-images-raccourcis/raccourci.jpg  
Language: fr  


J’aime ajouter des captures d’écran à mes tickets GitHub. Une image vaut mille mots, c’est aussi vrai pour décrire un bug. Donc je partage souvent des screenshots. Avec GitHub, c’est très simple : il suffit de glisser-déposer l’image dans la description de l’issue, le fichier est uploadé et le code Markdown est inséré automatiquement.

Mais il semble que GitHub traite différemment les captures d’un écran d’ordinateur et celles du simulateur iOS. Peut-être qu’il reconnaît le format des noms de fichiers, ou bien les dimensions des écrans. En tout cas, il utilise une balise `<img>` avec une largeur fixée pour les captures d’écran d’ordinateur, alors qu’il garde la notation Markdown `‌![]()` pour celles du simulateur. Résultat : un écran d’iPhone prend toute la largeur de la page et déborde en hauteur. La lisibilité du ticket est nulle.

![Capture d’écran d’un iPhone avec les dimensions par défaut](/blog/img/2024/dimensionner-images-raccourcis/issue-image-full-size.jpg)

Ma solution consiste à transformer le Markdown en HTML, et à ajouter une largeur fixe raisonnable. Concrètement, je passe de ça :

```
![Simulator Screenshot - iPhone 16 Pro - 2024-11-16 at 22 08 33](https://github.com/user-attachments/assets/8ecca551-82af-435d-8416-4b363ec60f11)
```

à ça :

```
<img width="300" alt="Simulator Screenshot - iPhone 16 Pro - 2024-11-16 at 22 08 33" src="https://github.com/user-attachments/assets/8ecca551-82af-435d-8416-4b363ec60f11">
```

Le ticket est immédiatement plus agréable à consulter :

![Capture d’écran d’un iPhone redimensionnée](/blog/img/2024/dimensionner-images-raccourcis/issue-image-set-size.jpg)


À la main, ça fonctionne, mais ça devient vite lassant. J’ai mis biiieeeen trop longtemps à automatiser cette petite manip’, mais maintenant que c’est fait, j’en suis ravi.

J’utilise Raccourcis (« Shortcuts »), puisqu’il s’agit de la solution officielle/moderne pour automatiser sur les plateformes Apple. Trois remplacements de texte, et le tour est joué. Pas besoin d’un LLM pour ça.

![Raccourci pour dimensionner une capture d’écran](/blog/img/2024/dimensionner-images-raccourcis/raccourci.jpg)

Raccourcis a l’avantage d’être bien intégré. Je peux donc invoquer cet outil avec un clic droit, dans le menu « Services », et avoir la transformation appliquée sur place.

![Menu contextuel pour invoquer le raccourci](/blog/img/2024/dimensionner-images-raccourcis/contextual-menu-services.jpg)

Si ça vous intéresse, vous pouvez importer ce raccourci [« Format GitHub image upload URL »](https://www.icloud.com/shortcuts/f0809a9fc68743349dd525739b285121).
