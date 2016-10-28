# Mega Moji

Tous les étés c’est la même chose. Une nouvelle version d’iOS arrive, avec son SDK et ses API, et autant de nouvelles opportunités. Je voulais donc en profiter pour construire une nouvelle app, et essayer d’être présent dès le premier jour de disponibilité de l’OS.

## Idée

Développer une app pour iMessage m’a semblé le choix le plus évident. Elles fonctionnent globalement comme des Extensions iOS, mais sans avoir besoin d’une app hôte, et avec un App Store dédié. Xcode 8 permet de créer une app de stickers sans la moindre ligne de code, en fournissant simplement les fichiers des images. Mais je voulais quand même un minimum de complexité.

Mon idée était de combiner emojis et stickers. Plus exactement, proposer les emojis système sous la forme de stickers pour iMessage. De cette façon, les emojis sont (beaucoup) plus grands, et peuvent être collés sur des message précédents.


## Choix des emojis




## Implémentation

Le code de l’application est très simple. Tout repose sur l’exemple fourni par Apple durant la WWDC (à ma connaissance, ce code n’est pas téléchargeable, seulement visible à l’écran pendant la session). Il met en place un view controller ZZZ, qui gère tout simplement une grille de stickers.

Il ne restait donc plus qu’à fournir les stickers eux-mêmes. Autrement dit, il suffit de transformer des caractères (`NSString`) en images (`UIImage`). Rien de bien compliqué, on crée un contexte graphique, on y dessine le caractère souhaité, et on en produit une image.

On notera au passage que les emojis système ne sont pas vectoriels, ils produisent donc des images pixelisées sur des grandes dimensions. Ce n’est clairement pas idéal, mais je ne comptais pas gagner un Apple Design Award de toute façon.


## Rejet :-(


## Seconde implémentation

