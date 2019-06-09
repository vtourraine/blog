Title:     Notes WWDC 2019 : Implementing Dark Mode on iOS  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 9, 2019  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la session 214 de la WWDC 2019 : Implementing Dark Mode on iOS  
Image:     
Language:  fr  


Référence : [Session 214 - Implementing Dark Mode on iOS](https://developer.apple.com/videos/play/wwdc2019/214/)


## Dark Mode is a new look
- Colors: now semantic colors, secondary/tertiary variants to structure the visual appearance
- Materials (blur effects)
- Built-in views and controls

## It’s easy to implement
- Dynamic colors: no need to update the view when style changes
- Can define custom dynamic colors and images in Assets Catalog

## Flexible and powerful
- `UITraitCollection.userInterfaceStyle` (`.dark`/`.light`) 
- Can programmatically resolve a dynamic color with a trait collection, and create custom dynamic color with a block to resolve based on a trait collection instance
- Might need manual update, for instance when using `CGColor`
- Keep in mind: not just one trait collection in your app
- Can override user interface style on a view controller or a view, or at app level in `Info.plist`
- New status bar styles (default, dark and light)
- New `UIActivityIndicatorView` styles
- For attributed string, need to specify foreground color
- Web content must opt-in to Dark Mode
