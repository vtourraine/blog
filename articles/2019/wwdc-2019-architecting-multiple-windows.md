Title:     Notes WWDC 2019 : Architecting Your App for Multiple Windows  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 15, 2019  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la session 258 de la WWDC 2019 : Architecting Your App for Multiple Windows.  
Image:     
Language:  fr  

Référence : [Session 258 - Architecting Your App for Multiple Windows](https://developer.apple.com/wwdc19/258)

## Changes to app lifecycle
App delegate responsibilities:
- iOS 12 and before: process lifecycle and UI lifecycle
- iOS 13: process lifecycle and new scene session lifecycle; the UI lifecycle is handled by the scene delegate

## Using the scene delegate

### Configuring new sessions
``` swift
func application(_ application: UIApplication,
configurationForConnecting connectingSceneSession: UISceneSession,
options: UIScene.ConnectionOptions) -> UISceneConfiguration
```

- Select a scene configuration
- Provides user activities, URLs
- Static and dynamic definition

### Scene disconnection
``` swift
func sceneDidDisconnect(_ scene: UIScene)
```

- System is releasing the scene
- May be called any time
- Release associated resources
- The scene may return

### Cleaning up discarded sessions
``` swift
func application(_ application: UIApplication,
didDiscardSceneSessions sceneSessions: Set<UISceneSession>)
```

- For permanently discarded sessions
- Delete associated data
- May be called after next launch

## Architecture
### Per-scene state restoration
``` swift  
func stateRestorationActivity(for scene: UIScene) -> NSUserActivity?
```

- Called on scene background
- Encode state via `NSUserActivity`
- Data protection

### Keeping scenes in sync
Different methods to update interface across scenes:
- Delegates
- Notifications
- Combine framework
