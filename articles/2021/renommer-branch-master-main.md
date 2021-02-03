Title:     Renommer « master » en « main »   
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      February 3, 2021  
Update:    
Keywords:  dev  
Summary:   Cette semaine, j’ai renommé les branches principales de tous mes repos, remplaçant les « master » par des « main ».  
Image:     https://www.vtourraine.net/blog/img/2021/renommer-branch-master-main/github-rename-branch-1.jpg  
Language:  fr  


Cette semaine, j’ai renommé les branches principales de tous mes repos, remplaçant les `master` par des `main`. 

GitHub a récemment ajouté une option pour [renommer une branche existante](https://github.blog/changelog/2021-01-19-support-for-renaming-an-existing-branch/). L’opération en elle-même est triviale, puisqu’il s’agit d’une simple commande Git. Mais la fonctionnalité proposée par GitHub est intéressante car elle établit une redirection pour toutes les requêtes d’API avec le nom d’origine, ce qui signifie que les personnes et les services qui utilisent déjà ce repo pourront continuer à s’y connecter sans discontinuité. Les pull requests sont également mises à jour en conséquence, et, pour bonne mesure, l’interface web informe les visiteurs du changement. Dans l’immense majorité des cas, la transition sera donc vraiment automatique.

![Renommer une branche avec GitHub](/blog/img/2021/renommer-branch-master-main/github-rename-branch-1.jpg)

**Je vous encourage vivement à faire la même chose pour vos repos.** Même si vous êtes seul à l’utiliser, ou s’il s’agit d’un repo privé. Dans votre entreprise, idem, demandez ce changement. Pour les projets open source, n’hésitez-pas à créer un ticket pour en faire la demande (cordialement, comme toujours).

Il y aura une réticence. Pourquoi changer quelque chose qui fonctionne ? Quelle difference entre `master` et `main` ? Tout d’abord, il me semble que le terme « main » décrit plus précisément le rôle de la branche... principale d’un repo. C’est un meilleur nom. Bien sûr, il s’agit aussi de se débarrasser d’un terme affreusement connoté, puisqu’il impliquait par association « master/slave ».

Je ne prétends pas qu’on peut résoudre les problèmes du monde en changeant le nom d’une branche de repo. Mais chaque geste a son importance. À vous de faire un geste.
