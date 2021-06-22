Title:     Notes WWDC 2021 : What’s new in Mac Catalyst  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 21, 2021  
Update:    
Keywords:  dev, macOS  
Summary:   Mes notes pour la session « What’s new in Mac Catalyst » de la WWDC 2021.  
Image:     
Language:  fr  


Mes notes pour la session [What’s new in Mac Catalyst](https://developer.apple.com/videos/play/wwdc2021/10052/) de la WWDC 2021.

## Overview of new APIs

Pop-up/toggle button support

ToolTips now available:

```swift
let toolTip = UIToolTipInteraction(defaultToolTip: "")
view.addInteraction(toolTip)

// or using convenience property on `UIControl`
control.toolTip = ""
```

Expansion ToolTips for `UILabel`: `label.showsExpansionTextWhenTruncated = true`

Declare support for Printing APIs in `Info.plist`, with `printContent(_ sender: Any?)` on `UIResponder`

Window subtitle: `scene.subtitle = ""`

Intents extensions support

## Overview of enhanced APIs

- `UIBehavioralStyle` to select controls rendering mode
- Window tab opt-out in `Info.plist`
- Cursor changes
