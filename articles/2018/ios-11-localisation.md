Title:     iOS : localisation plus cohérente  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      April 19, 2018  
Update:    
Keywords:  dev, iOS  
Summary:   Localiser une application est une tâche difficile, qui implique de nombreux aspects au-delà de la simple traduction de texte. iOS inclut des outils qui peuvent faciliter cette localisation, et l’adapter aux réglages de l’utilisateur.  
Image:     
Language:  fr  


Localiser une application est une tâche difficile, qui implique de nombreux aspects au-delà de la simple traduction de texte. iOS inclut des outils qui peuvent faciliter cette localisation, et l’adapter aux réglages de l’utilisateur. On trouve notamment les `NSFormatter` (`NSDateFormatter`, `NSNumberFormatter`, etc), et les méthodes localisées autour de `NSString` (`localizedCapitalizedString`, `localizedUppercaseString`, etc). Ces API existent depuis plusieurs années, et leur utilisation est vivement recommandée pour tous les éléments affichés à l’écran. iOS sait très bien localiser ces données. Un peu _trop_ bien, même.

En effet, jusqu’à récemment, toutes ces API localisaient indépendamment de l’application hôte. Concrètement, si une appli ne contenait que des textes en anglais mais était ouverte sur un iPhone configuré en français, un `NSDateFormatter` produisait une date en français, perdue donc au milieu d’une interface en anglais. Le résultat était incohérent, et potentiellement trompeur. On confond facilement des dates au format français `JJ/MM/AAAA` avec le format américain `MM/JJ/AAAA`, ou des nombres avec un `.` ou un `,` comme séparateur décimal et séparateur de milliers (et vice versa). Voilà pourquoi de nombreux développeurs choisissaient de ne pas utiliser ces API de localisation.

**Or, tout cela change avec iOS 11. Les API concernées sont maintenant limitées aux localisations explicitement supportées dans la configuration du projet.**

Pour reprendre l’exemple précédent, si votre application déclare supporter uniquement l’anglais, `NSDateFormatter` ne produira pas de dates en français, même sur un iPhone configuré en français. Le code ne change pas, mais les résultats sont différents. Cette évolution est une bonne nouvelle, car elle produit enfin les résultats attendus pour produire des interfaces cohérentes. Ceci dit, il faut aussi être conscient qu’un même code se comportera différemment selon la version d’iOS. On notera par ailleurs que ce changement n’est (à ma connaissance) pas documenté par Apple.

En réalité, tous ces objets et méthodes reposent sur `[NSLocale currentLocale]`. C’est cette méthode qui évolue avec iOS 11, et entraîne par conséquent tout un pan du SDK iOS qui dépend d’elle. Si vous souhaitez retrouver le comportement précédent, vous pouvez toujours utiliser `[NSLocale preferredLanguages]`, et spécifier la `locale` sur les objects `NSFormatter`, ou la passer en option des méthodes `NSString` (`capitalizedStringWithLocale:`, `uppercaseStringWithLocale:`, etc).

[Jaanus Kase explique sur son blog](https://jaanus.com/ios-11-changes-localized-date-handling/) que ce changement peut aussi avoir des répercutions significatives. Dans l’application Météo d’Apple, les noms des jours de la semaine (« lundi », « mardi », …) sont issus des méthodes de localisation. Jaanus est estonien. iOS n’est pas disponible en estonien, mais les dates localisées par iOS le sont. Jusqu’à iOS 10, l’application Météo proposait donc les jours de la semaine en estonien. Avec iOS 11, pas de chance, tout est affiché en anglais. Ce n’est pas vraiment un bug, mais dans ce cas précis, c’est un peu une régression. Comme on dit souvent en programmation, _dates are hard_.
