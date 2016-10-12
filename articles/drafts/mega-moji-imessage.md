# Mega Moji

Tous les étés c'est la même chose. Une nouvelle version d'iOS arrive, avec son SDK et ses API, pleine de nouvelles opportunités. Je voulais donc en profiter pour construire une nouvelle app, et essayer d'etre present dès le premier jour de disponibilite de l'OS.

## Idée

Developper une app pour iMessage m'a semble le choix le plus evident. Elles fonctionnent globalement comme des Extensions iOS, mais sans avoir besoin d'une app hôte, et avec un App Store dédié. Xcode 8 permet de creer une app de stickers sans la moindre ligne de code, en fournissant simplement les fichiers des images. Mais je voulais quand meme un minimum de complexite.

Mon idee etait de combiner emojis et stickers. Plus exactement, proposer les emojis systeme sous la forme de stickers pour iMessage. De cette facon, les emojis sont (beaucoup) plus grands, et peuvent etre colles sur des message precedents.


## Choix des emojis




## Implémentation

Le code de l'application est tres simple. Tout repose sur le code d'exemple fourni par Apple durant la WWDC (a ma connaissance, ce code n'est pas telechargeable, seulement visible a l'ecran pendant la session). Ce code met en place un view controller ZZZ, qui gere tout simplement une grille de stickers.

Il ne restait donc plus qu'a fournir les stickers eux-memes. Autrement dit, il suffit de transformer des caractères (NSString) en images (UIImage). Rien de bien complique, on cree un contexte graphique, on y dessine le caractere souhaite, et on en produit une image.

On notera au passage que les emojis systeme ne sont pas vectoriels, ils produisent donc des images pixelisees sur des grandes dimensions. Ce n'est clairement pas ideal, mais je ne comptais pas gagner un Apple Design Award de toute facon.


## Rejet :-(


## Seconde implémentation

