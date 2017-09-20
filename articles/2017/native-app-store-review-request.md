Title:     Notations App Store, nouvelle génération  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 28, 2017  
Update:   
Keywords:  dev, iOS  
Summary:   L’importance des notations sur l’App Store a généralisé le concept du « Please rate this app ». Ces alertes encouragent, de façon plus ou moins insistante, l’utilisateur à laisser un avis sur l’App Store. Tout ça pour obtenir le plus de ★★★★★.  
Image:     https://www.vtourraine.net/blog/img/2017/native-app-store-review-request/requestreview.png  
Language:  fr  


L’importance des notations sur l’App Store a généralisé le concept du _« Please rate this app »_. Ces alertes encouragent, de façon plus ou moins insistante, l’utilisateur à laisser un avis sur l’App Store. Tout ça pour obtenir le plus de ★★★★★.

Voilà pourquoi Apple fournit depuis iOS 10.3 une API pour standardiser cette démarche, et a très récemment modifié les règles de validation pour interdire les alertes non-officielles.

![Demande d’avis (requestReview) avec iOS 10.3](/blog/img/2017/native-app-store-review-request/requestreview.png)

> **1.1.7 App Store Reviews:**  
> Use the provided API to prompt users to review your app; this functionality allows customers to provide an App Store rating and review without the inconvenience of leaving your app, and we will disallow custom review prompts.

Source : [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)

Je suis ravi de cette nouvelle approche, comme utilisateur et développeur, mais le fonctionnement très particulier de cette API m’a laissé perplexe.

## requestReview()

> **SKStoreReviewController**  
> Controls the process of requesting App Store ratings and reviews from users.  
> Use the `requestReview()` method to indicate when it makes sense to ask the user for ratings and review within your app.
 
Source : [SKStoreReviewController documentation](https://developer.apple.com/documentation/storekit/skstorereviewcontroller)

La méthode principale est une sorte de trou noir. En demandant l’affichage d’une requête, impossible d’en connaître le résultat. L’OS décidera s’il présente effectivement le dialogue à l’utilisateur, sur la base des réglages de l’appareil et du nombre de fois que cette méthode a été invoquée précédemment.

Ce qui nous amène au problème central : **quel est le bon moment pour (essayer de) présenter la demande d’avis ?**

## Demander au bon moment

La réponse dépend forcément du mode de fonctionnement de votre application. Globalement, il convient de ne pas demander trop tôt (pour ne pas embêter un utilisateur en phase de découverte), mais ne pas trop attendre non plus (pour espérer obtenir un nombre significatif d’évaluations). Cette estimation était déjà problématique initialement, mais cette nouvelle API accentue cette difficulté.

À mes yeux, la solution réside dans une bibliothèque comme [iRate](https://github.com/nicklockwood/iRate), qui devient quasiment indispensable pour cette tâche.

Il suffit d’intégrer la bibliothèque à votre projet (par exemple avec CocoaPods) pour en bénéficier, sans la moindre ligne de code. iRate enregistre le nombre de lancements de l’application et les changements de version, pour proposer la notation au moment qui semblera le plus opportun. Ces réglages peuvent être personnalisés, et il est également possible de désactiver l’affichage automatique, pour contrôler entièrement sa présentation. Surtout, la bibliothèque détecte si l’API native est disponible, et l’utilise le cas échéant.

Petit bémol avec la nouvelle API : cette approche a tendance à produire des faux positifs. Parfois le système refusera de présenter la demande, ce qui conduira donc iRate à complètement ignorer cette version de l’application. Ça me paraît une limitation raisonnable, surtout si vous avez l’habitude de publier régulièrement des mises à jour.

## Demande explicite

> Although you should call this method when it makes sense in the user experience flow of your app, the actual display of a rating/review request view is governed by App Store policy. Because this method may or may not present an alert, it's not appropriate to call it in response to a button tap or other user action.

Source : [requestReview() documentation](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/2851536-requestreview)

Autre conséquence du fonctionnement à l’aveugle de cette nouvelle API : **il est impossible de l’utiliser avec un bouton dédié**. Un peu caché dans les réglages ou dans un écran d’information, ou trouve parfois un bouton pour proposer explicitement à l’utilisateur d’écrire un avis. On ne peut pas sérieusement proposer un bouton dont l’action n’est pas garantie, sans pouvoir en connaître le résultat. La documentation évoque donc ce cas de figure, et conseille de rediriger alors l’utilisateur directement vers l’App Store par le biais d’une URL, en sortant complètement de l’app. Dommage de devoir se priver de l’API native. Mais là aussi, iRate est très utile, puisqu’elle peut gérer cette navigation tout simplement, avec la méthode `openRatingsPageInAppStore`.

## Conclusion

Cette nouvelle API adresse un véritable problème, et constitue un compromis raisonnable pour les utilisateurs et les développeurs. Je préfèrerais qu’Apple retire complètement le système de notation de l’App Store et améliore significativement son moteur de recherche. Mais comme les étoiles restent aujourd’hui un facteur décisif dans le succès ou l’échec d’une application, il convient de gérer ce système avec rigueur.

Malheureusement, j’ai bien peur que l’interdiction des alertes non-officielles soit difficile à appliquer. Le fonctionnement volontairement restrictif de l’API native risque de limiter son adoption. Ce serait dommage, il n’a jamais été aussi facile de laisser une note.

★★★★★ ?
