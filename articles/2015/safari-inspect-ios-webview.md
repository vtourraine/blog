Title:    Comment inspecter une page web (ou une web view) avec iOS
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     June 28, 2015  
Update:   
Keywords: iOS, web, dev
Summary:  Safari n’est pas exactement le navigateur favori des développeurs web. Il dispose cependant d’une fonctionnalité, un peu cachée et donc relativement méconnue, qui vaut vraiment le détour lorsqu’il s’agit de concevoir un site (ou une app) mobile. Je n’ai probablement pas à vous convaincre de l’intérêt du Web Inspector. Depuis Firebug jusqu’aux _DevTools_ de Chrome, la possibilité d’explorer le DOM avec une interface graphique est devenue incontournable. Mais comment faire pour un smartphone ou une tablette, quand le navigateur mobile ne dispose pas d’une telle fonctionnalité ? Dans le cas d’iOS, Safari s’en occupe très bien, encore faut-il savoir l’activer.  
Image:    https://www.vtourraine.net/blog/img/2015/safari-inspect-ios-webview/safari-develop-menu.png  
Language: fr  


Safari n’est pas exactement le navigateur favori des développeurs web. Il dispose cependant d’une fonctionnalité, un peu cachée et donc relativement méconnue, qui vaut vraiment le détour lorsqu’il s’agit de concevoir un site (ou une app) mobile. 

Je n’ai probablement pas à vous convaincre de l’intérêt du Web Inspector. Depuis Firebug jusqu’aux _DevTools_ de Chrome, la possibilité d’explorer le DOM avec une interface graphique est devenue incontournable. Mais comment faire pour un smartphone ou une tablette, quand le navigateur mobile ne dispose pas d’une telle fonctionnalité ? 

Dans le cas d’iOS, Safari s’en occupe très bien. Encore faut-il savoir l’activer.


## Inspection à distance

**Activez l’inspection à distance sur l’iPhone/iPad :**

1. `Settings`
2. `Safari`
3. `Advanced`
4. `Web Inspector`

![iOS Settings](/blog/img/2015/safari-inspect-ios-webview/ios-safari-settings.png)

**Activez le menu développeur dans Safari sur Mac :**

1. `Preferences…`
2. `Advanced`
3. `Show Develop menu in menu bar`

![Safari Settings](/blog/img/2015/safari-inspect-ios-webview/osx-safari-preferences.png)

Vous pouvez maintenant ouvrir ce menu `Develop` sur votre ordinateur, et vous y trouverez une liste de tous les appareils branchés ayant activé cette fonctionnalité. Si Safari est ouvert sur iOS, il y apparaîtra, et il ne vous restera plus qu’à inspecter la page mobile, directement depuis votre Mac.

![Safari Develop menu](/blog/img/2015/safari-inspect-ios-webview/safari-develop-menu.png)


## Bonus : inspecter une web view à l’intérieur d’une app

Cette fonctionnalité ne s’arrête pas là. Vous pouvez également inspecter en temps réel les `UIWebView`/`WKWebView` à l’intérieur de vos applications natives iOS. 

Il n’y a aucun réglage supplémentaire pour l’application. Vous pouvez inspecter une app s’exécutant dans le Simulateur, ou directement sur un appareil iOS branché.

> _« If you have a development provisioning profile installed on your device, you can even inspect the web content of any UIWebView object in your app. The name of your app will appear as a submenu under the name of your device. When debugging web content in a web view, Web Inspector behaves in the same manner as debugging web content in Safari. »_  
> Apple Documentation, [Safari Web Inspector Guide](https://developer.apple.com/library/iad/documentation/AppleApplications/Conceptual/Safari_Developer_Guide/GettingStarted/GettingStarted.html)

Certaines app natives ont de bonnes raisons pour intégrer une web view, et il convient alors d’utiliser des outils adaptés. Quand Xcode et Instruments ne sont pas suffisants, Safari peut se montrer utile.