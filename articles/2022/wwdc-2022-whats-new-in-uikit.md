Title:     Notes WWDC 2022 : What’s new in UIKit  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 8, 2022  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la session « What’s new in UIKit » de la WWDC 2022.  
Image:     
Language:  fr  


Mes notes pour la session [What’s new in UIKit](https://developer.apple.com/videos/play/wwdc2022-10068) de la WWDC 2022.

## Productivity improvements

### Improved navigation bars
- 2 new navigation styles (`browser` and `editor`)
- Customisable items
- Title menu
- Optimised with Catalyst

### Find and replace
- Need opt-in
- For `UITextView`, `WKWebView`, `PDFView` 

### Edit menu
- Customisable
- New `UIEditMenuInteraction` API

### Materials in Sidebar
On by default in overlay sidebar mode
 
## Control enhancements

- New `UICalendarView`, represents dates as `DateComponent`
- `UIPageControl` improvements
- Pasteboard access displays alert the first time, new `UIPasteControl`

## API refinements
- Custom detents to show sheets of any size
- SFSymbol
    - New inherent rendering mode (can be not monochrome by default)
    - Variable symbols `UIImage(systemName:, variableValue:, configuration)`
- Swift concurrency, Sendable: `UIImage`, `UIColor`, `UIFont`, `UITraitCollection`
- State Manager: no code required, deprecate `UIScreen.main`, `UIScreen` lifecycle notifications
- Self-resizing cells for `UICollectionView` and `UITableView` by default: `selfSizingInvalidation`
    - Automatic when using `UIListContentConfiguration`
    - Manually with `invalidateIntrinsicContentSize()`
    - With Auto Layout, can use `.enabledIncludingConstraints`

## UIKit and SwiftUI
Build cells with SwiftUI:

``` swift
cell.contentConfiguration = UIHostingConfiguration {
  VStack {
   Image(systemName: "wand.and.stars")
     . font(.title)
    Text("Like magic!")
      .font(.title2).bold()
  }
  .foregroundStyle(Color.purple)
}
```

- `UIDevice.name` reports model name (to avoid fingerprinting)
- `UIDevice.orientation` not supported
	- Use `PreferredInterfaceOrientation` instead
