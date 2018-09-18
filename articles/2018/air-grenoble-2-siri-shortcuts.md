Title:     Siri Shortcuts  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      September 17, 2018  
Update:    
Keywords:  iOS, app, dev  
Summary:   Les « Siri Shortcuts » sont une des principales nouveautés d’iOS 12. Une fonctionnalité très prometteuse, mais un peu difficile à résumer, et qui va au-delà de Siri l’assistant vocal. Plus généralement, il s’agit en fait de marquer certaines activités se déroulant au sein d’une application, pour ensuite laisser le système les exposer en dehors de l’application elle-même. Avec une commande Siri, donc, mais aussi sur l’écran d’accueil, l’écran de recherche, ou avec la nouvelle application « Raccourcis ».  
Image:     https://www.vtourraine.net/blog/img/2018/air-grenoble-2-siri-shortcuts/iphonex-siri-shortcuts.png  
Language:  fr  


Les « Siri Shortcuts » sont une des principales nouveautés d’iOS 12. Une fonctionnalité très prometteuse, mais un peu difficile à résumer, et qui va au-delà de Siri l’assistant vocal. Plus généralement, il s’agit en fait de marquer certaines activités se déroulant au sein d’une application, pour ensuite laisser le système les exposer en dehors de l’application elle-même. Avec une commande Siri, donc, mais aussi sur l’écran d’accueil, l’écran de recherche, ou avec la nouvelle application « Raccourcis ».

Air Grenoble 2 est une application tellement basique qu’elle peut se résumer à une seule activité, et donc, un unique Raccourci. En l’occurrence, consulter la qualité de l’air. 

L’API pour les Siri Shortcuts est bien pensée, et il suffit de quelques lignes de code pour supporter cette nouvelle fonctionnalité.

## User Activity

L’option la plus simple repose sur `NSUserActivity`, en y ajoutant une nouvelle propriété : `eligibleForPrediction`. Pour Air Grenoble, il me suffit de configurer une activité pour mon View Controller principal, de mettre cette propriété à `true`, et d’implémenter une méthode sur l’app delegate. Lorsque le Raccourci sera invoqué, l’application s’ouvrira tout simplement sur l’écran principal.

``` swift
// ViewController.swift

let UserActivityTypeView = "com.company.airgrenoble.view"

override func viewDidLoad() {
  super.viewDidLoad()

  let userActivity = NSUserActivity(activityType: UserActivityTypeView)
  userActivity.title = NSLocalizedString("Consulter la qualité de l’air", comment: "")
  userActivity.isEligibleForPrediction = true

  self.userActivity = userActivity
}
```

``` swift
// AppDelegate.swift

func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
  if (userActivity.activityType == UserActivityTypeView) {
    return true
  }
  else {
    return false
  }
}
```

On n’oublie pas d’ajouter l’activité dans le fichier `Info.plist`, et voilà, le tour est joué, prêt pour iOS 12. 

## Interaction

Il existe une seconde option pour exposer des Siri Shortcuts, plus complexe mais plus intéressante. On peut en effet créer une « Intents Extension », qui permet davantage d’options, et qui s’occupe de prendre en charge le Raccourci sans avoir besoin d’ouvrir l’application principale.

Je ne vais pas tout détailler ici, parce que ça demande pas mal d’explications, et je ne suis pas sûr d’avoir tout compris. Mon implémentation fonctionne... parfois. Et quand ça plante, Siri ne donne pas beaucoup d’explications pour comprendre d’où vient le problème. Deux invocations identiques successives mènent parfois à des résultats différents. Au fil des betas cet été, j’espérais que ces problèmes disparaissent, mais le fonctionnement me paraît toujours instable avec la GM. Au final, je préfère quand même inclure cette Extension dans la version 2.0, en espérant que les bugs seront bientôt résolus, parce que le résultat est vraiment sympathique (quand ça fonctionne).

Ces Extensions reposent sur deux fichiers. Le fichier « Intent Definition » établit les requêtes possibles et le format des réponses correspondantes. Xcode permet d’éditer tout ça très facilement. Voilà ce que ça donne pour Air Grenoble.

![Xcode 10, éditeur Intent Definition](/blog/img/2018/air-grenoble-2-siri-shortcuts/intentdefinition-intent.png)

Je définis un Intent (consulter la qualité de l’air) avec deux réponses : succès (avec des attributs et un format particulier) ou erreur.

![Xcode 10, éditeur Intent Definition, Response](/blog/img/2018/air-grenoble-2-siri-shortcuts/intentdefinition-response)

Le second fichier est la classe de l’Extension elle-même. Elle récupère les requêtes, tente d’obtenir la qualité de l’air, et formate la réponse correspondante. Cette partie dépend beaucoup du fonctionnement spécifique de l’application. Ici, je ré-utilise une méthode de mon framework, et en cas de succès, je renseigne simplement mes deux propriétés (indice et qualificatif).

``` swift
// IntentHandler.swift

import Intents
import AirCoreiOS

class IntentHandler: INExtension, ViewAirQualityIntentHandling {
    
  func handle(intent: ViewAirQualityIntent, completion: @escaping (ViewAirQualityIntentResponse) -> Void) {
    Air.fetchQuality { (result, error) in
      guard let result = result else {
        completion(ViewAirQualityIntentResponse(code: .failure, userActivity: nil))
        return
      }

      let response = ViewAirQualityIntentResponse.success(qualificatif: result.qualificatif().localizedLowercase, indice: NSNumber(value: result.indice))
      completion(response)
    }
  }
}
```

Résultat des courses : on peut notamment définir une phrase personnalisée, avec laquelle Siri ira chercher l’indice de qualité de l’air, en annonçant oralement l’information, sans ouvrir l’application.

![Siri Shortcut « qualité de l’air »](/blog/img/2018/air-grenoble-2-siri-shortcuts/iphonex-siri-shortcuts.png)

Ces Extensions permettent d’adapter Siri à des situations très variées. Il reste bien certaines limitations, mais cette nouvelle API représente un progrès considérable pour élargir les cas d’utilisation de l’assistant vocal. Et comme je le disais en introduction, ces Raccourcis vont bien plus loin, avec notamment la possibilité de combiner et d’automatiser leur utilisation avec l’application Raccourcis.
