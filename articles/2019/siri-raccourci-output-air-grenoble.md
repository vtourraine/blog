Title:     Raccourcis Siri « output » en action  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      November 8, 2019  
Update:    
Keywords:  dev, iOS  
Summary:   J’ai récemment mis à jour Air Grenoble pour que son Extension Siri émette un « output ». Mais à quoi ça sert ? Voici un exemple : un utilisateur peut ajouter une notification personnalisée à une application qui n’en propose pas. Plus concrètement, je souhaite recevoir une notification tous les matins quand la qualité de l’air pour la journée s’annonce mauvaise.  
Image:     https://www.vtourraine.net/blog/img/2019/siri-raccourci-output-air-grenoble/airgrenoble-shortcut-notifications-device.png  
Language:  fr  


J’ai récemment mis à jour [Air Grenoble](https://itunes.apple.com/app/air-grenoble/id1183533416?mt=8) pour que son Extension Siri émette un « output ».

Mais à quoi ça sert ? Voici un exemple : un utilisateur peut ajouter une notification personnalisée à une application qui n’en propose pas. Plus concrètement, je souhaite recevoir une notification tous les matins quand la qualité de l’air pour la journée s’annonce mauvaise.

![Notifications qualité de l’air](/blog/img/2019/siri-raccourci-output-air-grenoble/airgrenoble-shortcut-notifications-device.png)

Première étape : il faut récupérer l’information souhaitée. C’est le fameux « output ». L’Extension peut définir un format spécifique pour chaque réponse. Ici, Air Grenoble définit un type « Qualité de l’air », avec plusieurs propriétés : un entier pour l’indice, et des `String` pour la description textuelle avec plus ou moins de détails.

![Format de sortie qualité de l’air](/blog/img/2019/siri-raccourci-output-air-grenoble/airgrenoble-shortcut-output-device.png)

On peut maintenant écrire le raccourci Siri qui exploite cette information. En pseudo-code : si l’indice est supérieur à N (seuil de mauvaise qualité de l’air), alors on poste une notification avec le descriptif complet. Ça paraît trivial, malheureusement Raccourci ne propose pas d’opérateur « inférieur/supérieur à ». Pour contourner ce problème, on peut définir un dictionnaire avec une unique paire clé-valeur `0 : True`, diviser l’indice du jour par la constante de seuil, arrondir le résultat, et obtenir la valeur du dictionnaire correspondant à cette clé. Si l’indice est inférieur au seuil, la valeur sera `True`, sinon le résultat est indéfini. Et on peut justement tester l’absence de valeur pour une variable. Tout ça pour obtenir un `if (x < N)`. C’est extraordinairement contre-intuitif, mais je n’ai pas trouvé de meilleure solution pour ce genre de test. En tout cas, il ne reste plus qu’à émettre la notification avec le format souhaité.

![Raccourci qualité de l’air](/blog/img/2019/siri-raccourci-output-air-grenoble/airgrenoble-shortcut.png)

Pouvoir lancer un raccourci manuellement, c’est bien, mais recevoir la notification automatiquement chaque matin, c’est encore mieux. iOS 13 permet justement de programmer des raccourcis avec différents critères. On peut choisir une fréquence quotidienne (« tous les jours à 8 heures », par exemple), mais avec une limitation majeure : le raccourci ne s’exécute pas directement. À la place, on reçoit une notification qui propose de lancer le raccourci. Pas vraiment automatique. Heureusement, certains déclencheurs peuvent se passer de la confirmation, notamment le lancement du raccourci à l’arrêt d’une alarme de réveil.

Même dans ce cas, il existe une petite inconvenance. iOS émet une notification, purement informative, pour prévenir de l’exécution du raccourci. Dans notre exemple, cela se traduit par une notification tous les matins pour dire que le raccourci a été exécuté, et éventuellement une seconde notification quand la qualité de l’air est mauvaise. Je comprends qu’Apple veut éviter les abus et les failles de sécurité, mais je ne peux qu’espérer qu’une future mise à jour permette la programmation des raccourcis en autonomie totale.

Au final, tout ça paraît bien compliqué pour une fonctionnalité plutôt basique. À première vue, sans doute. Mais ce genre d’automatisation ouvre des possibilités infinies. Si toutes les applications proposaient des Extensions Siri aussi détaillées, on pourrait les faire communiquer. Si Raccourci proposait une syntaxe plus complète, on pourrait écrire des séquences plus abouties. Et si iOS était un peu moins frileux avec les déclencheurs, Siri deviendrait un assistant vraiment indépendant.

Il ne s’agit ni plus ni moins que de réinventer la ligne de commande. Pourvu qu’Apple poursuive sur sa lancée, et vivement les prochaines mises à jour de Raccourcis.
