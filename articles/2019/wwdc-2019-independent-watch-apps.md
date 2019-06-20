Title:     Notes WWDC 2019 : Creating Independent Watch Apps  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 20, 2019  
Update:    
Keywords:  dev, iOS, watchOS  
Summary:   Mes notes pour la session 208 de la WWDC 2019 : Creating Independent Watch Apps.  
Image:     
Language:  fr  


Référence : [Session 208 - Creating Independent Watch Apps](https://developer.apple.com/wwdc19/208)

**“Independent Watch Apps”: can ship a Watch app without an iPhone app**

“Dependent Apps”
- Watch app download will install iPhone app to iPhone
- watchOS app launch is blocked until iPhone app is installed

“Independent Apps”
- Watch app is installed independently from App Store servers
- Asset and variant thinning for Watch app
- Can now uninstall the iPhone app and Watch app can remain
- watchOS app with iOS app is backwards compatible
- Watch-only app is watchOS 6 or later

Enterprise Distribution
- Xcode support
- Variants
- New `platform-identifier` key

Debugging
- Simulator debugging is up to 10x faster
- Device debugging is up to 2x faster
- Proxied through iPhone

Sign In and Sign Up
- Sign up
- Terms & Conditions: use `WKAlertAction` API
- Sign In with Apple
- Your own password sign in (new text field)

Push Notifications
- Watch as a push target
- User-visible notifications and background notifications

Networking
- Migrate all `WatchConnectivity` usage to `URLSession`
- Use `WatchConnectivity` for companion app specific interactions (`open var isCompanionAppInstalled: Bool { get }`)
