Title:    iOS 7 : background fetching pour tout le monde  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     October 11, 2013  
Update:   
Keywords: iOS, Xcode, Objective-C  
Summary:  Entre iOS et les applications qui veulent travailler en tâche de fond, c’est compliqué. Le système a de bonnes raisons pour économiser les cycles de son processeur, tandis que les développeurs en veulent toujours plus. Bonne nouvelle, tout change avec iOS 7, le “background fetching” est maintenant ouvert à tous.  
Image:    https://www.vtourraine.net/blog/img/ios-7-background-fetching/xcodeproj-back-fetch.png  
Language: fr  
Project:  

Entre iOS et les applications qui veulent travailler en tâche de fond, c’est compliqué. Le système a de bonnes raisons pour économiser les cycles de son processeur, tandis que les développeurs en veulent toujours plus. Bonne nouvelle, tout change avec iOS 7, le “background fetching” est maintenant ouvert à tous.

Note : je ne sais pas trop comment traduire “background fetching”, le terme utilisé par Apple, en français. Le but, c’est de récupérer des données lorsque l’application tourne en tâche de fond. Ceci dit, vous n’êtes pas non plus limités au téléchargement, même si ce mode d’exécution a ses limites. Bref, pour l’instant, je vais garder la version originale.


## Configuration du projet

La mise en place du background fetching est très simple.

Il faut d’abord activer la capacité dans les réglages du projet. Avec Xcode 5, vous allez dans « Capabilities », vous activez « Background Modes », et enfin « Background fetch ».

![Xcode : Edit Project][Edit Project]

Concrètement, cette activation correspond à l’ajout d’une valeur dans le `Info.plist` de votre projet :

``` xml
<key>UIBackgroundModes</key>
<array>
  <string>fetch</string>
</array>
```

Il est intéressant de noter que contrairement à la plupart des réglages à ce niveau, le background fetching ne demandera pas l’accord de l’utilisateur pour fonctionner. À la place d’un opt-in, Apple a opté pour un opt-out. Il suffit de faire un tour dans les réglages iOS (“Settings” > “General” > “Background App Refresh”) pour trouver la liste des applications qui utilisent déjà le background fetching sur votre appareil, et éventuellement désactiver les indésirables.

![iOS : Fetch Settings][Fetch Settings]


## Mise en place de la fréquence d’utilisation

Votre application peut maintenant demander à iOS à être sollicitée en tâche de fond. Pour cela, il ne manque qu’une seule information : la fréquence à laquelle l’app souhaite fonctionner.

Il suffit d’utiliser la méthode `setMinimumBackgroundFetchInterval:` sur votre `UIApplication`. La valeur par défaut est `UIApplicationBackgroundFetchIntervalNever`, il vous faudra donc spécifier un autre intervalle.

Comme vous pouvez le deviner, ce paramètre a seulement une valeur indicative. Donc ? Donc vous ne pouvez jamais savoir si et quand votre application sera lancée en tâche de fond. L’utilisateur pourrait simplement la désactiver, comme je l’évoquais ci-dessus.

iOS va plus loin : Apple a mis au point un algorithme qui détermine si une application doit être invoquée en fonction de l’utilisateur, ainsi que des précédentes sessions d’exécution. Tout ça est un peu abstrait, et Apple se garde bien d’expliciter l’algorithme en question, qui d’ailleurs évoluera sûrement avec les prochaines versions du système.

L’objectif est honnête : économiser intelligemment les ressources pour le background fetching. Inutile de rafraîchir les données entre minuit et 6h du matin si vous dormez. Si vous utilisez cette application une fois par jour à 12h, l’idéal est de fetcher les nouvelles données une fois par jour à 11h55. Vous voyez le principe. Le système prend aussi en compte les sessions  précédentes. Si les dernières exécutions en tâche de fond étaient rapides, c’est un plus ; si vous avez utilisé le processeur longtemps avec beaucoup de traitements, c’est un moins.

Avec un code optimisé, vos utilisateurs les plus assidus bénéficieront donc en théorie d’un résultat optimal. Pour le reste, c’est iOS qui décide.

Si vous souhaitez être activé aussi souvent que possible, il est conseillé d’utiliser la constante `UIApplicationBackgroundFetchIntervalMinimum`, qui porte bien son nom. Dans la pratique, vous pouvez donc attribuer cette valeur dans votre AppDelegate, en fin de lancement :

``` objc
- (BOOL)application:(UIApplication *)application
 didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // ...
  [application setMinimumBackgroundFetchInterval: UIApplicationBackgroundFetchIntervalMinimum];
  // ... 
}
```

Tout est prêt, il ne reste plus qu’à attendre que le système nous donne la main.


## À toi de fetcher

Le moment tant attendu est enfin arrivé : iOS décide de lancer votre application pour le background fetching. Ce qui compte, c’est d’implémenter la méthode `application:performFetchWithCompletionHandler:` de votre AppDelegate.

En recevant cet appel, votre application dispose de 30 secondes pour effectuer ses téléchargements et autres traitements. Dès que vous avez terminé le fetching, vous devez appeler le block passé en paramètre de cette méthode, en lui transmettant le résultat de l’opération : nouvelles données, pas  nouvelles données, ou échec. Si ce block n’est pas exécuté dans les 30 secondes imparties, votre application sera immédiatement interrompue, et l’icône de votre application portera un bonnet d’âne pour la semaine à venir (il paraît).

Apple recommande d’utiliser les `NSURLSession` pour faciliter la gestion des téléchargements. Vous pouvez également utiliser [AFNetworking][], qui est parfaitement adapté pour ce genre d’opérations, comme le montre cet exemple d’implémentation :

``` objc
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

  [manager GET:@"http://example.com/resources.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

    // ...
    if (completionHandler)
      completionHandler(UIBackgroundFetchResultNewData);

  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    // ...
    if (completionHandler)
      completionHandler(UIBackgroundFetchResultFailed);

  }];
}
```

## Debug

Pour tester le comportement de votre application lors d’un appel en tâche de fond, Xcode 5 dispose d’une option permettant de simuler directement un lancement dans ces conditions.

Ce réglage un peu particulier se situe au niveau du « scheme », vous pouvez éventuellement dupliquer le scheme de base, ou simplement en modifier la valeur ponctuellement. Dans la section « Run », onglet « Options », vous trouverez « Launch due to a background fetch event ». Une fois activé, le lancement de votre application depuis Xcode provoquera donc l’appel idoine sur votre AppDelegate.

![Xcode : Edit Scheme][Edit Scheme]


## Conclusion

À mes yeux, cette fonctionnalité (propre à iOS 7, rappelons-le) est peut-être la nouveauté la plus marquante, et surtout la plus utile, du nouveau SDK.

Toutes les applications connectées à un web service (souvent les apps les plus utilisées) peuvent en profiter pour améliorer l’expérience utilisateur de façon invisible. Et je ne dis pas ça pour collectionner les buzzwords.

Enlevez les textures et ajouter le background fetching : voilà une vraie application « optimisée » pour iOS 7.


### Références

- <a href="https://developer.apple.com/library/ios/documentation/uikit/reference/UIApplication_Class/Reference/Reference.html">UIApplication Class Reference</a>
- <a href="https://developer.apple.com/library/ios/documentation/uikit/reference/UIApplicationDelegate_Protocol/Reference/Reference.html">UIApplicationDelegate Protocol Reference</a>


[Edit Project]:   /blog/img/ios-7-background-fetching/xcodeproj-back-fetch-annotated.png
[Fetch Settings]: /blog/img/ios-7-background-fetching/back-fetch-settings-scaled.png
[Edit Scheme]:    /blog/img/ios-7-background-fetching/xcodeproj-back-fetch-scheme-annotated.png

[AFNetworking]: https://github.com/AFNetworking/AFNetworking
