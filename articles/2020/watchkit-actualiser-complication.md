Title:     Actualiser une complication Apple Watch à intervalles réguliers  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      February 8, 2020  
Update:    
Keywords:  dev, watchOS  
Summary:   Une bonne complication Apple Watch doit être actualisée aussi souvent que nécessaire pour garder l’information toujours fraîche, mais aussi rarement que possible pour économiser la batterie.  
Image:     https://www.vtourraine.net/blog/img/2020/watchkit-actualiser-complication/air-grenoble-complications.jpg  
Language:  fr  


Une bonne complication Apple Watch doit être actualisée aussi souvent que nécessaire pour garder l’information toujours fraîche, mais aussi rarement que possible pour économiser la batterie.

Idéalement, un serveur peut envoyer une notification de type « complication » pour indiquer précisément quand actualiser les données. Mais lorsque cette option n’est pas applicable, il est possible de demander un rafraîchissement localement, avec un rythme prédéterminé. L’implémentation n’est pas évidente, voici donc mon code pour les complications pour [Air Grenoble](https://itunes.apple.com/app/air-grenoble/id1183533416?mt=8).

![Complications Air Grenoble sur Apple Watch](/blog/img/2020/watchkit-actualiser-complication/air-grenoble-complications.jpg)

D’abord, l’application Apple Watch doit programmer une tâche de fond. Comme exemple, on règle le rafraîchissement pour dans une heure.

``` swift
func applicationDidBecomeActive() {
  scheduleBackgroundRefresh()
}

func scheduleBackgroundRefresh() {
  let complicationServer = CLKComplicationServer.sharedInstance()
  if let activeComplications = complicationServer.activeComplications,
    activeComplications.isEmpty == false {
      let fireDate = Date.init(timeIntervalSinceNow: 60 * 60) // 1 hour
      WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: fireDate, userInfo: nil) { (error) in }
  }
}
```

Lorsque cette tâche est invoquée par le système, l’application est activée. La fonction `handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>)` du delegate permet d’identifier cette situation, selon la classe de la tâche. Il ne reste plus qu’à demander le rafraîchissement des complications (s’il y en a), et programmer la prochaine tâche de fond. 

``` swift
func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
  for task in backgroundTasks {
    switch task {
    case let backgroundTask as WKApplicationRefreshBackgroundTask:
      updateComplications()
      scheduleBackgroundRefresh()
      backgroundTask.setTaskCompleted()
    // ...
    }
  }
}

func updateComplications() {
  let complicationServer = CLKComplicationServer.sharedInstance()
  guard let activeComplications = complicationServer.activeComplications else {
    return
  }

  for complication in activeComplications {
    complicationServer.reloadTimeline(for: complication)
  }
}
```

Tout ce _boilerplate_ pour accomplir une tâche aussi essentielle n’est pas très élégant, mais c’est la seule solution que j’ai trouvée. Et le résultat n’est pas garanti. watchOS se réserve le droit d’invoquer les tâches de fond ou non.

> The system carefully budgets background refresh tasks. You can schedule only one refresh task at a time. If you have a complication on the active watch face, you can safely schedule four refresh tasks an hour.

[Apple documentation – Updating Your Timeline](https://developer.apple.com/documentation/clockkit/adding_a_complication_to_your_watchos_app/providing_data_for_your_complication/updating_your_timeline)
