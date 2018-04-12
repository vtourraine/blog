Title:    Application iOS pour Mix-IT  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     April 4, 2015  
Update:   April 19, 2015  
Keywords: mixit, iOS, dev  
Summary:  Mix-IT, c’est un peu la WWDC lyonnaise. L’année dernière, la conférence avait vendu tous les billets en 48 heures ; cette année il aura suffit de 3 heures.  
Image:    https://www.vtourraine.net/blog/img/2015/app-mixit/iphone-views.jpg  
Language: fr  


[Mix-IT](http://www.mix-it.fr), c’est un peu la WWDC lyonnaise. L’année dernière, la conférence avait vendu tous les billets en 48 heures ; cette année il aura suffit de 3 heures. 

Les organisateurs proposent depuis quelques années une [API](http://www.mix-it.fr/article/40/wanna-hack-mix-it-) permettant d’accéder au programme, avec le détail des sessions et des intervenants. Vous pouvez donc trouver des applications Android basées sur cette API, pour récupérer toutes ces informations sur votre téléphone. Mais depuis tout ce temps, rien pour iOS. Il me semble que Mix-IT était historiquement centrée sur Java, ce qui explique peut-être cette situation. 

J’avais donc envie de proposer quelque chose pour les utilisateurs d’iPhones. 

Après [mon passage](http://www.mix-it.fr/session/378/looking-at-the-future-of-user-interfaces-in-sci-fi) en 2014, j’avais commencé un projet avec la récupération des données et l’affichage d’une simple liste de l’ensemble des sessions. Les choses en sont restées là, jusqu’au mois dernier et l’approche de l’édition 2015. Quelques soucis d’API plus tard (et avec l’aide des super organisateurs), il était grand temps de reprendre ce projet pour en faire une application qui puisse être utile. Il fallait aussi faire vite, à quelques semaines de la conférence, compte-tenu du temps de validation pour l’App Store. En plein boom WatchKit, il faut tabler sur [environ 8 jours](http://appreviewtimes.com). Heureusement qu’il existe l’« expedited review », qui permet justement d’accélérer le processus dans ce genre de situation, mais dépend entièrement de la bonne volonté d’Apple. 

Tout ça pour dire que l’application est maintenant [disponible sur l’App Store](https://itunes.apple.com/app/mix-it/id982003173?ls=1&mt=8).

![Application sur iPhone][iPhone views]

Dans ces conditions, le résultat est très basique, mais devrait rendre service aux heureux détenteurs d’un billet Mix-IT. La vue principale liste l’ensemble des sessions des deux journées, avec les détails en vue secondaire. Vous trouverez aussi un vue “à propos”, avec notamment une carte pour localiser CPE Lyon sur le campus de la Doua (merci le GPS). L’application supporte l’iPhone, l’iPod touch et l’iPad, mais ne vous attendez pas à une interface optimisée pour les tablettes. Enfin, à l’image de Mix-IT, l’application est traduite en français et en anglais.

Le code est disponible sur [GitHub](https://github.com/vtourraine/mixit). 

Si vous avez des suggestions et que vous êtes très rapides, on peut encore espérer une petite mise-à-jour avant le 16 avril, autrement je garderai ça pour l’année prochaine. 

![Bonus : retrouvez le CPE Lyon… en 3D][iPhone 3D map]

   
   

> _Mise à jour du 19 avril 2015_  
>  
> Mix-IT 2015, c’est maintenant terminé (et tout le monde confirme que, cette année encore, c’était vraiment bien). Au cas où ça intéresserait quelqu’un, voici les statistiques de téléchargement de l’application.  
>  
> Pour faire simple, premier pic dès la publication sur l’App Store, notamment grâce à [un tweet](https://twitter.com/mixIT_lyon/status/584272226410725376) par le compte officiel @mixit_lyon. La seconde vague arrive, assez logiquement, la veille de la conférence. 55 téléchargements au total. Pour environ 500 participants, j’imagine environ la moitié avec un iPhone, donc j’avoue être un peu déçu par ce nombre. Peu importe, je suis content de l’avoir développée, même dans la précipitation.  
>  
> Enfin, n’hésitez-pas à me faire signe si vous avez des suggestions pour l’améliorer avant 2016. Ça vous laisse même pas mal de temps pour envoyer vos [pull-requests](https://github.com/vtourraine/mixit).  
>  
> ![Nombres de téléchargements de l’application][downloads]


[iPhone views]: /blog/img/2015/app-mixit/iphone-views.jpg
[iPhone 3D map]: /blog/img/2015/app-mixit/maps-3d.png
[downloads]: /blog/img/2015/app-mixit/downloads.jpg
