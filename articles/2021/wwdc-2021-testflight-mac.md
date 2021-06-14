Title:     Notes WWDC 2021 : Meet TestFlight on Mac  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 14, 2021  
Update:    
Keywords:  dev, macOS  
Summary:   Mes notes pour la session « Meet TestFlight on Mac » de la WWDC 2021.  
Image:     
Language:  fr  


Mes notes pour la session [Meet TestFlight on Mac](https://developer.apple.com/videos/play/wwdc2021/10170/) de la WWDC 2021.

## TestFlight app on macOS

- Coming fall 2021
- Will be available on Mac App Store, require macOS 12
- Same capabilities as on iOS (install beta, auto updates, share feedback, invites/public links, tester groups)
- Supports native Mac apps and iOS apps running on Apple Silicon Mac
    - Native Mac app: require provisioning profile (included with “Automatically manage signing”)
    - iOS apps on Apple Silicon Mac: for each tester group, you can enable availability on Mac; stats count/feedback/screenshots categorized as “iOS”

## Improved internal group management
- Can create multiple internal groups (for instance, separate dev team and QA team with specific builds)
- configure distribution
- control feedback settings

## Built-in Xcode Cloud features
- Managed build distribution (grouped by workflow and branch)
- Build groups
