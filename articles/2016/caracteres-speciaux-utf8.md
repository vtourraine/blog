Title:    Les joies de l’écriture avec des caractères spéciaux  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     February 21, 2016  
Update:   
Keywords: général  
Summary:    
Image:    http://www.vtourraine.net/blog/img/2016/dotswift-2/dotswift-header.jpg  
Language: fr  


Quand on passe ses journées à saisir des caractères avec un clavier, physique ou virtuel, on néglige souvent la richesse offerte par l’écriture numérique. La préhistoire ASCII est derrière nous, il est grand temps de profiter d’UTF-8.

En particulier, je voudrais mentionner quelques caractères spéciaux trop souvent oubliés. Vous maîtriser parfaitement l’orthographe et la grammaire ? Félicitation. Il ne vous reste plus qu’à savoir utiliser un clavier comme il faut.


##  ⎵

Je vais commencer par mon préféré : l’espace insécable. 

La barre d’espace prend beaucoup de place, mais elle ne suffit pas vraiment à couvrir tous les espaces possibles. Oui, il existe plusieurs types d’espaces. Je ne les connais pas tous, ma passion pour les caractères spéciaux a des limites. Mais l’espace insécable est vraiment un cas intéressant. Pour la (en typographie on parle d’**une** espace) saisir avec OS X, c’est généralement `⌥` + `Espace`. Je l’utilise quotidiennement, avec deux cas d’utilisation.

![OS… X, extrait blog [swift.org](https://swift.org/blog/swift-ci/)](http://www.vtourraine.net/blog/img/2016/caracteres-speciaux-utf8/espace-os-x.png)

Pour certains mots, et en particulier certaines marques, il convient d’utiliser un espace insécable. Les exemples autour d’Apple ne manquent pas (OS X, iPad Air, App Store, etc), mais ça peut évidemment servir dans bien d’autres domaines.

![« … guerrier », extrait app [La Matinale du Monde](https://itunes.apple.com/app/la-matinale-du-monde/id973857028?mt=8)](http://www.vtourraine.net/blog/img/2016/caracteres-speciaux-utf8/espace-guillemets.png)

Le deuxième cas, encore plus fréquent, concerne les signes de ponctuation en français. Avant les points-virgules, les points d’interrogation, les points d’exclamation et les deux-points, ou encore à l’intérieur des guillemets doubles. Petit rappel au passage : en anglais on ne place aucun espace devant les signes de ponctuation doubles (pour repérer les français qui écrivent en anglais sur un blog ou ailleurs, cherchez les espaces). Et pour être précis, il faudrait en fait utiliser une espace *fine* insécable dans la plupart des cas, mais l’espace classique insécable permet déjà d’éviter les cassures indésirables.


## « »

Parlons un peu des guillemets. Sur un clavier traditionnel, vous trouvez les guillemets droits. C’est pratique, mais c’est un peu pauvre. Ça revient plus ou moins à utiliser | à la place de parenthèses ouvrantes et fermantes.

Les systèmes d’exploitation proposent d’ailleurs généralement une option pour remplacer automatiquement les guillemets droits lors de la saisie. Pour les saisir manuellement, avec OS X ce sera `⌥` + `7` pour `«` et `⌥` + `shift` +`7` pour `»`. Pour les équivalents anglais, “”, c’est plus simple avec `⌥` + `3` et `⌥` + `shift` + `3`.

Au passage, n’oubliez pas l’apostrophe, qui se courbe elle aussi avec `⌥` + `shift` + `4`.


## Tirets

Le tiret est un autre exemple de caractère pour lequel il existe de nombreuses variantes. Les différences sont plus subtiles que pour les guillemets, mais elles peuvent en valoir la peine.

Il existe le tiret court (qu’on trouve directement sur le clavier), moyen et long. Avec OS X, c’est `⌥` + `-` pour le long, et `⌥` + `shift` + `-` pour le moyen. 

Ça fait beaucoup de règles à connaître pour savoir lequel s’utilise quand. En ce qui me concerne, je préfère retenir quelques cas qui reviennent souvent, et utiliser le tiret court par défaut autrement. Par exemple, on utilise plutôt le tiret moyen pour les intervalles (2011–2016).

Dernière subtilité, si vous cherchez le signe « moins », il convient d’utiliser un caractère différent. Ses dimensions sont généralement proches du tiret moyen, mais son alignement est légèrement différent. Si vous développez un site web ou une app avec des boutons +/− pour ajuster une valeur, pensez-y, c’est le genre de finitions qui donnent de l’allure à une interface. 


# UTF-∞

À partir de là, il ne vous reste plus qu’à partir explorer les richesses d’UTF-8.

Bien-sûr, il faudra se limiter à ASCII pour la syntaxe d’un code source. Mais on pourrait très bien faire évoluer Swift, par exemple, pour accepter un code typographiquement plus expressif.

``` swift
let message = “Hello”
let 🤖 = true
let number = 50 + 8 − 16
```

Aujourd’hui, une seule de ces trois expression est correcte. ¯\\_(ツ)_/¯ 
