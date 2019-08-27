Title:     Prendre en charge le mode sombre pour un site web  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      August 27, 2019  
Update:    
Keywords:  dev, web  
Summary:   Si vous consultez un site web avec le mode sombre d’iOS 13 ou de macOS Mojave activé, vous serez probablement gêné de découvrir un texte noir sur un fond de page éblouissant, tranchant avec le reste de vos applications. Par défaut, un contenu web ne s’adapte pas au mode sombre.  
Image:     https://www.vtourraine.net/blog/img/2019/web-dark-mode-sombre/vtourraine-web-light-dark-mode.png  
Language:  fr  


Si vous consultez un site web avec le mode sombre d’iOS 13 ou de macOS Mojave activé, vous serez probablement gêné de découvrir un texte noir sur un fond de page éblouissant, tranchant avec le reste de vos applications. Par défaut, un contenu web (page, web app, mail) ne s’adapte pas au mode sombre.

Pour mettre à jour votre site web et proposer un rendu adapté, il suffit de modifier le CSS de votre site. Le principe de base est très simple, son application dépendra évidemment de la complexité de votre CSS actuel.

![Blog en mode sombre et clair](/blog/img/2019/web-dark-mode-sombre/vtourraine-web-light-dark-mode.png)

Il s’agit d’utiliser des variables sémantiques pour les couleurs, avec des valeurs normales par défaut, et de définir des valeurs alternatives pour le mode sombre.

Typiquement, vous aurez besoin d’une couleur de fond de page, une autre pour le texte, probablement une autre pour les liens,  peut-être une couleur différente pour les titres, ou pour l’en-tête de la page, etc. Vous déclarez un bloc `:root`, valable par défaut et pour les deux modes (`color-scheme: light dark;`), avec chaque couleur et sa valeur normale (`--bg-color: white;`). Ensuite, vous utilisez une media query spécifique au mode sombre (`@media (prefers-color-scheme: dark)`), redéfinissant ces variables avec des valeurs adaptées (`--bg-color: black;`). Enfin, il ne reste plus qu’à utiliser ces couleurs dans vos règles de style habituelles (`background-color: var(--bg-color);`).

Voici un exemple, avec un texte noir sur fond blanc qui devient un texte blanc sur fond noir pour le mode sombre :

``` css
:root {
  color-scheme: light dark;
  
  --bg-color: white;
  --text-color: black;
}

@media (prefers-color-scheme: dark) {
  :root { 
    --bg-color: black;
    --text-color: white;
  }
}

body {
  background-color: var(--bg-color);
  color: var(--text-color);
}
```

Vous trouverez [sur le site de Mozilla](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme#Browser_compatibility) la liste des navigateurs supportant cette fonctionnalité. La promotion du mode sombre est largement assurée par Apple pour ses plateformes, et pour Safari en particulier, mais cette spécification CSS (actuallement à l’état de « draft ») n’est pas limitée à WebKit.

La prise en charge du mode sombre oblige à réviser toutes les couleurs d’un site web. C’est donc une excellente occasion d’améliorer la qualité du code CSS.
