Title:     Notes WWDC 2019 : Introducing Multiple Windows on iPad  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 14, 2019  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la session 212 de la WWDC 2019 : Introducing Multiple Windows on iPad.  
Image:     
Language:  fr  


Référence : [Session 212 - Introducing Multiple Windows on iPad](https://developer.apple.com/wwdc19/212)

## Design intent
**Where should I add scenes to my app**?

The user should be allowed to do everything from just one window (apps cannot require multiple windows).

- Some apps have all features in each window (e.g. Safari, Maps, etc)
- Some apps only have some features in secondary windows “dedicated window” (e.g. Mail compose, etc)

**What interactions should create scenes**?

Provided by system:
- Plus button in Exposé (top right)
- Drag app icon to the edge of screen

Or provided by the app:
- Master-detail view (drag from master)
- Button

## App lifecycle changes
- `UIScene`
    - Contains UI
    - Created by the system on demand
    - Destroyed by the system when unused
- `UISceneSession`
    - Persisted interface state
    - Have defined system role
    - Created for new application representations
    - Scenes connect and disconnect from sessions

Migrating your code from:
``` swift
application(_:didFinishLaunchingWithOptions:)
applicationWillEnterForeground(_:)
applicationDidBecomeActive(_:)
applicationWillResignActive(_:)
applicationDidEnterBackground(_:)
...
application(_:open:options:)
...
application(_:continue:restorationHandler:)
```

to:
``` swift
scene(_:willConnectTo:options:)
sceneWillEnterForeground(_:)
sceneDidBecomeActive(_:)
sceneWillResignActive(_:)
sceneDidEnterBackground(_:)
...
scene(_:openURLContexts:)
...
scene(_:continue:)
```

`UIScene` state restoration:
- State restoration is now data in the form of `NSUserActivity`
- Requested from `UISceneDelegate`
- Accessible at any time via `UISceneSession.stateRestorationActivity`

Adding support to multiple windows:
- Main target deployment info: check the “support multiple windows” checkbox
- In `Info.plist`: declare what interfaces for what types of roles
- Edit scene delegate: implement state restoration

## Drag and drop
- `NSUserActivity` based
- Can add to existing `NSItemProvider` on `UIDragItem`

## Next steps
Difference between “scene” and “window”: a “scene” can be present in the multitasking interface, even if the window is not loaded

Create new scenes:
``` swift
requestSceneSessionActivation(_:userActivity:options:errorHandler:)
```

Update existing scenes:
``` swift
requestSceneSessionRefresh(_:)
```

Close scenes:
``` swift
requestSceneSessionDestruction(_:options:errorHandler:)
```

Examples:
``` swift
 // Open a new window

@IBAction func handleLongPress(forDocumentAt url: URL) {
  if let existingSession = findSession(for: url) {
    UIApplication.shared.requestSceneSessionActivation(existingSession, userActivity: nil, options: nil)
  } else {
    let activity = NSUserActivity(activityType: "com.example.MyApp.EditDocument")
    activity.userInfo["url"] = url

    UIApplication.shared.requestSceneSessionActivation(nil, userActivity: activity, options: nil)
  }
}
```

``` swift
// Close a window

func closeWindow(and action: DraftAction) {
  let options = UIWindowScene.DestructionRequestOptions()

  switch action {
  case .send: options.windowDismissalAnimation = .commit
  case .save: options.windowDismissalAnimation = .decline
  case .delete: options.windowDismissalAnimation = .standard
  }

  let session = view.window!.windowScene!.session
  UIApplication.shared.requestSceneSessionDestruction(session, options: options)
}
```

For state restoration:
- `var stateRestorationUserActivity: NSUserActivity`: preferred mechanism
- `var persistentIdentifier: String { get }`: ID that you can store to manually save/restore the scene state
- `var userInfo: [String:AnyHashable]`: additional info, for instance data in the `NSUserDefaults` that are not global to the app (e.g. a panel being displayed)

Debugging tips:
- Every app has unique challenges
- Expect to make changes
- Test, test, and test more
- Focus on multiple scenes
- Review system and custom singletons (`UIApplication.shared`, etc)
