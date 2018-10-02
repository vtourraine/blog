Title:     Passer des données avec Shortcuts  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      October 2, 2018  
Update:    
Keywords:  iOS, app, dev  
Summary:   L’application Raccourcis fonctionne comme la plupart des systèmes de programmation « visuelle » : avec des blocs, prenant des valeurs en entrée, et produisant d’autres valeurs en sortie. Input/output classique. Avec iOS 12, l’application Raccourcis gère un nouveau type de bloc, les... Raccourcis Siri, c’est-à-dire des actions spécifiques, proposées par une application.  
Image:     https://www.vtourraine.net/blog/img/2018/air-grenoble-2-shortcuts-pasteboard/shortcut-pasteboard.png  
Language:  fr  

L’application Raccourcis (Shortcuts en V.O., née Workflow) fonctionne comme la plupart des systèmes de programmation « visuelle » : avec des blocs, prenant des valeurs en entrée, et produisant d’autres valeurs en sortie. Input/output classique. Avec iOS 12, l’application Raccourcis gère un nouveau type de bloc, les... Raccourcis Siri (Siri Shortcuts, oui, cette terminologie peut donner des migraines), c’est-à-dire des actions spécifiques, proposées par une application. 

C’est formidable, mais avec une énorme limitation : les blocs Raccourcis Siri ne prennent pas d’entrées, et ne produisent pas de sorties. Ces blocs se contentent d’invoquer une application pour lui laisser exécuter la tâche associée, mais sans pouvoir affecter le déroulement global du raccourci.

C’est bien dommage, mais il existe heureusement une solution. Pas très éléguante, et personne n’est à l’abri d’une future mise à jour d’iOS bridant cette méthode. Mais cette astuce est déjà devenue _la_ solution officieuse pour permettre à Raccourcis de vraiment intégrer un raccourci Siri, comme le fait remarquer Federico Viticci dans [sa très complète revue d’iOS 12](https://www.macstories.net/stories/ios-12-the-macstories-review/7/#shortcuts). 

**Il s’agit tout simplement d’utiliser l’API de Presse-papiers (`UIPasteboard`), comme une variable globale du système.**

C’est par exemple ce que propose Air Grenoble avec la version 2.0.1. Le raccourci Siri obtient l’indice de qualité de l’air, copie cette valeur dans le Presse-papiers, et enfin retourne la valeur formattée à Siri pour le résultat classique du raccourci.

``` swift
func handle(intent: ViewAirQualityIntent, completion: @escaping (ViewAirQualityIntentResponse) -> Void) {
  Air.fetchQuality { (result, error) in
    guard let result = result else {
      completion(ViewAirQualityIntentResponse(code: .failure, userActivity: nil))
      return
    }

    let responseDetail = "" //...

    UIPasteboard.general.string = result.localizedMediumDescription()

    let response = ViewAirQualityIntentResponse.success(qualificatif: result.qualificatif().localizedLowercase, indice: NSNumber(value: result.indice), detail: responseDetail)
    completion(response)
  }
}
```

Avec cette ligne de code supplémentaire (`UIPasteboard.general.string = "..."`), on peut maintenant extraire cette valeur dans un raccourci.

Dans l’exemple suivant, je me contente d’afficher le résultat avec une alerte, mais on peut facilement imaginer des scénarios plus intéressants : envoyer automatiquement un email avec cette valeur, ou poster une alerte si l’indice dépasse un certain seuil.

![Configuration d’un raccourci avec le Presse-papiers](/blog/img/2018/air-grenoble-2-shortcuts-pasteboard/shortcut-pasteboard.png)

Selon le point de vue, cette solution peut paraître trop basique, ou trop complexe. Trop basique, car le résultat n’est pas formellement modélisé. (Comment séparer l’indice numérique de son qualificatif ? Comment gérer les échecs d’exécution ? _Etc._) Trop complexe, parce que le procédé n’est pas documenté, et nécessite une manipulation indirecte des valeurs avec le Presse-papiers, qui n’est pas franchement conçu pour ça.

Cette situation est évidemment frustrante, mais elle représente néanmoins un progrès considérable. Et bien sûr, on espère que la prochaine version d’iOS supportera officiellement ce type d’utilisation avec une API dédiée.

Qui sait, on finira peut-être avec une application Terminal pour iOS ?
