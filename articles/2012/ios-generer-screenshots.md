Title:    iOS : des screenshots par milliers  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     December 10, 2012  
Update:   
Keywords: iOS, App Store, gestion de projets  
Summary:  Publier une application sur l’App Store, c’est à la fois très simple et très compliqué. Je vais donc m’attarder sur l’une de ces difficultés : les screenshots.  
Image:    
Language: fr  
Project:  1List  

Publier une application sur l’App Store, c’est à la fois très simple et très compliqué. Je vais donc m’attarder sur l’une de ces difficultés : les screenshots.

Je sais, ça paraît trivial. En fait, ça l’est, jusqu’au moment où vous voulez mettre à jour votre appli, ou qu’Apple décide d’ajouter une nouvelle résolution d’écran (bonjour Retina), ou un nouveau format (bonjour iPhone 5). Vous obtenez facilement une dizaine de screenshots par version. Oh, et bien sûr vous pouvez encore multiplier tout ça par le nombre de langues supportées.

C’est le genre de chose qui fait sourire la première fois, qu’on fait à la main parce que ça change du code, tout ça, mais qui rend fou assez rapidement.


## Mock Manager

Une application repose généralement sur des données saisies par l’utilisateur. Pour vos screenshots, vous aurez donc besoin de contenu, histoire de mettre en valeur l’application et son interface. Et puisque vous allez être amené à refaire ces screenshots une centaine de fois au cours de l’évolution de votre appli, il vous faut un moyen simple et efficace pour produire des screenshots avec ce précieux contenu.

Pour prendre exemple sur ma dernière [application](http://www.studioamanga.com/onelist), le controller principal affiche ses données sur la base d’un manager, qui s’occupe de fournir les informations issues du model. *MVC*, toujours là pour vous. Il me suffit donc de créer une classe fille pour mon manager, disons “DemoManager”, et de lui faire retourner invariablement mes données de démo. Côté controller, une petite condition à l’instaciation du manager permet de choisir entre le mode normal et le mode démo. 

Exemple d’implémentation du DemoManager (`DemoManager.m`) :

``` objc
- (NSArray *)suggestions {
  return @["Milk", @"Coffee", @"Tea", @"Black Tea", @"Green Tea", @"Oolong Tea", @"White Tea"];
}
```

Exemple d’instanciation du manager à partir du controller principal (`MainController.m`) :

``` objc
#ifdef DEMO
  self.manager = [DemoManager newManager];
#else
  self.manager = [RemindersManager newManager];
#endif
```

J’ai toujours un petit faible pour les constantes pré-processeur, mais vous pouvez adapter ces extraits selon vos préférences. L’objectif est simple : il faut gagner du temps pour plus tard. Votre application doit pouvoir basculer en mode démo avec une simple constante, peu importe comment.


## Conclusion

Autant que je sache, il n’est pas possible d’automatiser entièrement la production des screenshots, surtout lorsque vous devez gérer plusieurs types de devices, ou plusieurs langues. Ceci étant dit, entre UIAutomation et des outils comme [ios-sim](https://github.com/phonegap/ios-sim), la tâche est peut-être surmontable.

Ce qui est important, c’est de rationaliser autant que possible le processus de production de vos screenshots. Quelques lignes de code supplémentaires vous permettront de gagner du temps, beaucoup de temps, et vous aideront à mettre en valeur votre application.
