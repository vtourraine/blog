Title:    La magie des caractères spéciaux  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     February 21, 2016  
Update:   
Keywords: général  
Summary:  Quand on passe ses journées à saisir des caractères avec un clavier (physique ou virtuel), on néglige trop souvent la diversité mise à notre disposition par l’écriture numérique. La préhistoire ASCII est derrière nous, il est grand temps de profiter des richesses d’UTF-8.  
Image:    http://www.vtourraine.net/blog/img/2016/caracteres-speciaux-utf8/espace-guillemets.png  
Language: fr  


Quand on passe ses journées à saisir des caractères avec un clavier (physique ou virtuel), on néglige trop souvent la diversité mise à notre disposition par l’écriture numérique. La préhistoire ASCII est derrière nous, il est grand temps de profiter des richesses d’UTF-8.

En particulier, je voudrais mentionner avec ce billet quelques caractères spéciaux souvent ignorés. Pas la peine d’être un expert en typographie. Vous maîtrisez parfaitement l’orthographe et la grammaire ? Félicitations. Il ne vous reste plus qu’à savoir utiliser un clavier comme il faut.


##  ⎵

Je vais commencer par mon préféré : [l’espace insécable](https://fr.wikipedia.org/wiki/Espace_insécable).

La barre d’espace prend beaucoup de place sur un clavier, mais elle ne suffit pas vraiment à couvrir tous les espaces possibles. Oui, il existe plusieurs types d’espaces. Je ne les maîtrise pas tous, ma passion pour les caractères spéciaux a des limites. Mais l’espace insécable est vraiment un cas intéressant. Je l’utilise tous les jours, avec deux cas d’utilisation.

![_OS… X_, extrait du blog [swift.org](https://swift.org/blog/swift-ci/)](http://www.vtourraine.net/blog/img/2016/caracteres-speciaux-utf8/espace-os-x.png)

Pour certains mots, et en particulier certaines marques, il convient d’utiliser un espace insécable. Les exemples autour d’Apple ne manquent pas (OS X, iPad Air, App Store, etc), mais ça peut évidemment servir dans bien d’autres domaines.

![_« … guerrier »_, extrait app [La Matinale du Monde](https://itunes.apple.com/app/la-matinale-du-monde/id973857028?mt=8)](http://www.vtourraine.net/blog/img/2016/caracteres-speciaux-utf8/espace-guillemets.png)

Le deuxième cas, encore plus fréquent, concerne les signes de ponctuation en français. Avant les points-virgules, les points d’interrogation, les points d’exclamation et les deux-points, ou encore à l’intérieur des guillemets doubles. Petit rappel au passage : en anglais on ne place aucun espace devant les signes de ponctuation doubles (astuce pour repérer les français qui écrivent en anglais sur internet : cherchez les espaces). Pour être vraiment précis, il faudrait en fait utiliser une espace *fine* insécable dans la plupart des cas, mais l’espace classique insécable permet déjà d’éviter les cassures indésirables.

| Caractère        | Raccourci OS X (🇫🇷) |
| ---------------- | --------------------- |
| espace insécable | `⌥` + `Espace`        |


## « »

Parlons un peu des [guillemets](https://fr.wikipedia.org/wiki/Guillemet). Sur un clavier traditionnel, vous trouvez les guillemets droits. C’est pratique, mais c’est un peu pauvre. Ça revient plus ou moins à utiliser | à la place de parenthèses ouvrantes et fermantes.

Les systèmes d’exploitation proposent d’ailleurs généralement une option pour remplacer automatiquement les guillemets droits lors de la saisie de texte. Au passage, n’oubliez pas l’apostrophe, qui se courbe elle aussi.

| Caractère | Raccourci OS X (🇫🇷) |
| --------- | --------------------- |
| «         | `⌥` + `è/7`           |
| »         | `⌥` + `shift` + `è/7` |
| ‘         | `⌥` + `'/4`           |
| ’         | `⌥` + `shift` + `'/4` |
| “         | `⌥` + `"/3`           |
| ”         | `⌥` + `shift` + `"/3` |


## —

Le [tiret](https://fr.wikipedia.org/wiki/Tiret) est un autre exemple de caractère pour lequel il existe de nombreuses variantes. Les différences sont plus subtiles que pour les guillemets, mais elles peuvent en valoir la peine.

Il existe le tiret court (qu’on trouve directement sur le clavier), moyen et long. Ça fait beaucoup de règles à connaître pour savoir lequel s’utilise quand. En ce qui me concerne, je préfère retenir quelques cas qui reviennent souvent, et utiliser le tiret court par défaut autrement. Par exemple, on utilise plutôt le tiret moyen pour les intervalles (e.g. 2011–2016).

Dernière subtilité, si vous cherchez le signe « moins », il convient d’utiliser encore un autre caractère. Ses dimensions sont généralement proches du tiret moyen, mais son alignement est légèrement différent. Si vous développez un site web ou une app avec des boutons +/− pour ajuster une valeur, pensez-y, c’est le genre de finitions qui donnent de l’allure à une interface. 

| Caractère | Raccourci OS X (🇫🇷) |
| --------- | --------------------- |
| — (long)  | `⌥` + `-/_`           |
| – (moyen) | `⌥` + `shift` + `-/_` |


# UTF–∞

À partir de là, il ne vous reste plus qu’à partir explorer les richesses d’UTF-8.

Bien-sûr, il faudra essentiellement se limiter à ASCII pour la syntaxe d’un code source. Mais on pourrait très bien faire évoluer Swift, par exemple, pour accepter un code typographiquement plus expressif.

``` swift
let message = “Hello”
let 🤖 = true
let number = 50 + 8 − 16
```

Aujourd’hui, une seule de ces trois expressions est correcte. Ce n’est pas forcément celle qu’on croit. ¯\\_(ツ)_/¯ 
