Title:     Notes WWDC 2019 : Targeting Content with Multiple Windows  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 15, 2019  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la session 259 de la WWDC 2019 : Targeting Content with Multiple Windows.  
Image:     
Language:  fr  

Référence : [Session 259 - Targeting Content with Multiple Windows](https://developer.apple.com/wwdc19/259)

If your app receives a notification, which scene should it activate in response?

`UISceneActivationConditions`: predicates to describe what a scene can do.

``` swift
class UISceneActivationConditions : NSObject {
  var canActivateForTargetContentIdentifierPredicate : NSPredicate
  var prefersToActivateForTargetContentIdentifierPredicate : NSPredicate
}
```

### Target content identifiers

Can be specified on different objects interacting with your apps:
- `UNNotificationContent` (APNS `target-content-id` key)
- `UIApplicationShortcutItem`
- `NSUserActivity`
