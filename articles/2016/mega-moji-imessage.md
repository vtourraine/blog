Title:     Mega Moji  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      November 8, 2016  
Update:    
Keywords:  iOS, dev  
Summary:   Tous les ans c’est la même chose. Une nouvelle version d’iOS arrive, avec son SDK et ses API, et autant de nouvelles opportunités. Je voulais donc en profiter pour construire une nouvelle app, et essayer d’être présent dès le premier jour de disponibilité de l’OS.  
Image:     https://www.vtourraine.net/blog/img/2016/mega-moji-imessage/mega-moji-app-store.png  
Language:  fr  


Tous les ans c’est la même chose. Une nouvelle version d’iOS arrive, avec son SDK et ses API, et autant de nouvelles opportunités. Je voulais donc en profiter pour construire une nouvelle app, et essayer d’être présent dès le premier jour de disponibilité de l’OS.


## Idée

Développer une app pour iMessage m’a semblé le choix le plus évident. Elles fonctionnent globalement comme des Extensions iOS, mais sans avoir besoin d’une app hôte, et avec un App Store dédié (!). Xcode 8 permet de créer une app de stickers sans la moindre ligne de code, en fournissant simplement les fichiers des images. Mais je voulais quand même un minimum de complexité.

Mon idée était de combiner emojis et stickers. Plus exactement, proposer les emojis natifs sous la forme de stickers pour iMessage. De cette façon, les emojis sont (beaucoup) plus grands, et peuvent être collés sur des messages existants. Je voulais l’appeler « Mega Emoji », mais ce nom était déjà tronqué par iMessage pour tenir dans la grille d’icônes. Ce sera donc « Mega Moji ».


## Implémentation

Le code de l’application est très simple. Tout repose sur l’exemple fourni par Apple durant la WWDC, session [204](https://developer.apple.com/videos/play/wwdc2016/204/) (à ma connaissance, ce code n’est pas téléchargeable, seulement visible à l’écran pendant la session). Il met en place un `MSStickerBrowserViewController`, qui gère tout simplement une grille de stickers à la manière d’une collection view.

Il ne reste donc plus qu’à fournir les stickers eux-mêmes. Autrement dit, il suffit de transformer des caractères (`NSString`) en images (`UIImage`). Rien de bien compliqué, on crée un contexte graphique, on y dessine le caractère souhaité, et on en produit une image.

Afin de ne pas surcharger une interface aussi basique avec des centaines d’emojis, j’en retiens simplement une dizaine parmi les plus populaires (cf [source 1](http://fivethirtyeight.com/datalab/the-100-most-used-emojis/), [source 2](https://twitter.com/twitterdata/status/673905956909133824)). Et voici le résultat :

![Mega Moji v0](/blog/img/2016/mega-moji-imessage/screen-v0.png)

On note au passage que les emojis système ne sont pas vectoriels, ils produisent donc des images pixelisées sur des grandes dimensions. Ce n’est clairement pas idéal, mais je ne comptais pas gagner un Apple Design Award de toute façon.


## Rejet

Ma petite app était donc prête pour la sortie d’iOS 10. Seul problème : l’équipe de validation pour l’App Store décide de la rejeter. Ils estiment en effet que Mega Moji est trop proche d’une fonctionnalité système, et pourrait ainsi porter à confusion. C’est assez flatteur de s’entendre dire par Apple que l’app est trop bien intégrée à iOS. Mais dans cet état, pas de publication sur l’App Store possible.


## Seconde implémentation

Pour résoudre ce problème, j’ai modifié l’app pour utiliser des emojis alternatifs. Le site [EmojiOne](http://emojione.com) propose des images sous licence Creative Commons (CC-BY 4.0), il me suffit de faire correspondre les emojis déjà sélectionnés avec les fichiers `.png` correspondants. Et voilà le résultat :

![Mega Moji v1](/blog/img/2016/mega-moji-imessage/screen-v1.png)

C’est dommage parce que je reviens à un concept d’app qui pourrait fonctionner sans la moindre ligne de code (même si je continue à la construire programmatiquement), et parce que l’utilisation d’emojis ostensiblement différents dévalue l’idée de base. Apple prend des précautions pour qu’une app ne trompe pas l’utilisateur (pour lutter contre le phishing, notamment), c’est une bonne chose. Mais combler une fonctionnalité manquante au système, en restant clairement dans le rôle d’app tierce, ne devrait pas poser problème.

Bref, j’espère que cette règle évoluera un jour, pour permettre à Mega Moji de retrouver son implémentation initiale.


## App Store

Finalement, [Mega Moji](https://itunes.apple.com/app/mega-moji-emoji-stickers/id1152321201?ls=1&app=messages) était bien disponible pour la sortie d’iOS 10.

![Mega Moji sur l’App Store](/blog/img/2016/mega-moji-imessage/mega-moji-app-store.png)

Je n’étais pas le seul à avoir cette idée, puisqu’on peut trouver d’autres apps iMessage proposant la même chose, parfois avec exactement les mêmes emojis.

Deux mois plus tard, l’app a été listée environ 50,000 fois, pour un peu plus de 1,000 installations. Le plus intéressant concerne sans doute la distribution géographique. Le Japon arrive largement en tête, malgré une page App Store entièrement en anglais. Les États-Unis suivent, avec la Suède, la Chine et le Danemark. Je vais peut-être profiter d’une prochaine version pour localiser le nom de l’app. **メガ・モジ！**

![Statistiques iTunes Connect pour Mega Moji](/blog/img/2016/mega-moji-imessage/mega-moji-stats.png)
