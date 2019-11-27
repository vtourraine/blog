Title:     Notifications avec autorisation provisoire  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      November 27, 2019  
Update:    
Keywords:  dev, iOS  
Summary:   Les notifications ont une importance particulière. iOS offre aux utilisateurs de nombreuses options pour les contrôler, mais tout repose sur la fameuse question : « Autorisez-vous cette application à vous envoyer des notifications ? »  
Image:     https://www.vtourraine.net/blog/img/2019/ios-notifications-autorisation-provisoire/silent-notification.jpg  
Language:  fr  


Les notifications ont une importance particulière. iOS offre aux utilisateurs de nombreuses options pour les contrôler, mais tout repose sur la fameuse question : « Autorisez-vous cette application à vous envoyer des notifications ? » 

![Demande classique d’autorisation d’envoi de notifications](/blog/img/2019/ios-notifications-autorisation-provisoire/request-authorization.jpg)

Les concepteurs d’applications rivalisent d’ingéniosité pour augmenter le taux de réponses positives. Or, depuis iOS 12, il est possible de contourner complètement cette question, en poussant une notification sans l’accord préalable de l’utilisateur. C’est le concept d’autorisation « provisoire » (_provisional authorization_).

En contrepartie, ces notifications sont d’abord distribuées « en silence », c’est-à-dire qu’elles apparaissent uniquement dans le Centre de notifications. Sans bannière, ni son, ni badge, ni sur l’écran d’accueil. Les notifications sont accompagnées de boutons demandant à l’utilisateur s’il souhaite continuer à les recevoir, ou s’il souhaite les bloquer. S’il accepte, les notifications pourront alors apparaître de façon normale (bannière, badge, etc.)

![Demande « en silence » d’autorisation d’envoi de notifications](/blog/img/2019/ios-notifications-autorisation-provisoire/silent-notification.jpg)

Ce changement bénéficie à l’utilisateur autant qu’au développeur. La décision est ainsi prise à la réception d’une notification, permettant de se faire une idée plus concrète de leur intérêt potentiel, avec une interface non-bloquante qui laisse le temps de la réflexion. On notera tout de même que certaines applications décident d’envoyer dans un premier temps une notification spéciale, plus attrayante mais moins représentative, pour augmenter le taux de réponses positives. N’importe quel système finit toujours par être manipulé, mais dans l’ensemble, celui-ci me paraît plus juste.

Côté développeur, on ne peut pas faire plus simple. Il suffit d’ajouter une option, `UNAuthorizationOptionProvisional`, lors de la demande d’autorisation. Aucune alerte ne vient interrompre l’exécution de l’application, et l’autorisation est immédiatement donnée à titre provisoire. Rien ne change pour l’envoi ou la réception des notifications, à distance ou locales.

``` objc
UNAuthorizationOptions options = (UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound);
if (@available(iOS 12.0, *)) {
  options = (options | UNAuthorizationOptionProvisional);
}

[[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
  // …
}];
```

À chaque fois qu’une application me demande d’autoriser l’envoi de notifications, je refuse. Je n’ai aucune envie d’être interrompu continuellement par des messages sans intérêt poussés pour gonfler les statistiques d’engagement de tel ou tel service.

Pour une application, l’autorisation provisoire est une occasion de prouver la valeur de ses notifications. Comme développeur et comme utilisateur, ça me semble une excellente opportunité.
