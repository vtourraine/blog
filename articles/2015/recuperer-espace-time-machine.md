Title:    Comment récupérer de l’espace disque occupé par Time Machine ?  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     January 31, 2015  
Update:   
Keywords: Mac, OS X  
Summary:    
Image:    
Language: fr  


C’est une banalité sur laquelle il convient d’insister : tout le monde devrait utiliser un système de sauvegarde et restauration de données (« backup software »). 

Si vous avez un Mac, le plus simple est d’utiliser le logiciel intégré à OS X : le bien-nommé *Time Machine*. Je l’utilise avec une Time Capsule (on remarque que l’équipe marketing s’amusait bien), mais je pense que cet article s’applique de la même façon pour n’importe quel support de sauvegarde.

Le problème, c’est que j’utilise aussi cette même Time Capsule comme disque externe pour stocker des données volumineuses, sur une même partition. Time Machine fonctionne comme un gaz : il prend toute la place qu’on lui donne. Résultat, le disque est souvent plein, alors que j’aimerais pouvoir y copier un nouveau fichier.

![Time Machine avec OS X 10.10, image Wikimedia Foundation][Time Machine]

Voici donc comme je récupère de la place.

**1.** Avec Terminal, saisissez la commande `tmutil listbackups`. Vous obtiendrez alors une liste de toutes les versions de sauvegardes gérées par Time Machine. Ça devrait ressembler à ça :

``` bash
$ tmutil listbackups  
/Volumes/Time Machine Backups/Backups.backupdb/macbook/2014-10-12-112546  
/Volumes/Time Machine Backups/Backups.backupdb/macbook/2014-10-26-103028  
/Volumes/Time Machine Backups/Backups.backupdb/macbook/2014-11-02-114503  
/Volumes/Time Machine Backups/Backups.backupdb/macbook/2014-11-09-101145  
...  
```

**2.** Pour supprimer une version qui vous semble dispensable, utilisez  `sudo tmutil delete '/Volumes/Time Machine Backups/Backups.backupdb/macbook/2014-11-16-123418'`, avec le chemin tel que retourné par la commande précédente. Cette opération peut prendre un temps conséquent, souvent plusieurs minutes. Lorsque c’est terminé, la commande affiche l’espace ainsi récupéré :

``` bash
$ sudo tmutil delete '/Volumes/Time Machine Backups/Backups.backupdb/macbook/2014-11-16-123418'  
Deleting: /Volumes/Time Machine Backups/Backups.backupdb/macbook/2014-11-16-123418  
Deleted (1.6G): /Volumes/Time Machine Backups/Backups.backupdb/macbook/2014-11-16-123418  
Total deleted: 1.6G  
```

Vous pouvez répéter cette étape pour supprimer autant de versions de sauvegardes que vous le souhaitez.

**3.** Enfin, il faut demander à Time Machine de recomposer ses données pour réellement récupérer l’espace disque. Passez en mode administrateur : `sudo su - root`, puis saisissez `hdiutil compact '/Volumes/Data/macbook.sparsebundle'`, avec le chemin du `.sparsebundle` associé à Time Machine (vous le trouverez quelque part dans `/Volumes`). Là encore, un peu de patience, et le tour est joué.

``` bash
$ sudo su - root  
$ hdiutil compact '/Volumes/Data/macbook.sparsebundle'  
Starting to compact…  
Reclaiming free space…  
..............................  
Finishing compaction…  
Reclaimed 2.2 GB out of 523.5 GB possible.  
```

Pour éviter ce genre d’acrobaties, il serait préférable d’établir des partitions distinctes sur le disque avant la première mise en place. Ce n’est sans doute pas une configuration idéale, mais ça peut vous rendre service si vous êtes dans la même situation.  

*Note : ce billet est directement adapté des informations trouvées sur [Reclaiming a TimeMachine Volume’s Disk Space](http://blog.hawkimedia.com/2012/08/reclaiming-a-timemachine-volumes-disk-space/) (en anglais).*


[Time Machine]: http://www.vtourraine.net/blog/img/2015/recuperer-espace-time-machine/time-machine.jpg  