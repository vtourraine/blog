Title:     Notes WWDC 2019 : What’s New in iOS and macOS Design  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 7, 2019  
Update:    
Keywords:  dev, iOS, macOS  
Summary:   Mes notes pour la session 801 de la WWDC 2019 : What’s New in iOS and macOS Design  
Image:     
Language:  fr  


Référence : [Session 801 - What’s New in iOS and macOS Design](https://developer.apple.com/videos/play/wwdc2019/801/)

## iOS

### Dark Mode
Full black background to blend in with the hardware, with variants

- Colors
    - Semantic color: describe purpose instead of what it looks like (`UIColor.labelColor`, etc), with variants to express information hierarchy (`UIColor.secondaryLabelColor`, etc), [documentation with list of colors](https://developer.apple.com/documentation/uikit/uicolor/ui_element_colors)
    - System tint colors (`UIColor.systemRedColor`, etc)
    - Base and elevated: automatic variations to express hierarchy (in Slide Over, modal, etc)
- Updated system controls
- SF Symbols: glyphs designed to adapt to current traits

### Modal presentation
- New card-like appearance by default
- Dismiss with gesture (good for one-hand manipulation)
- Can prevent automatic dismissal
- Apps still need to always include visible button

### Contextual menus
- Based on Peek and Pop, but works on all devices (tap and hold)
- Contextual menus shift focus to actions
- Display commands and visual preview
- Actions they contain should still be available somewhere else in your main interface

## iPad apps for Mac

Key features: resize, drag and drop, multi windows

- **Architecture** : Sometimes better to adapt basic structure directly, sometimes better to change to take advantage of larger screen (flatten hierarchy, etc)
- **Toolbars**
- **Layout** : readable layout constraints
- **Type** : iOS @ 77% scale
- **Colors** : Mac apps should be more neutral (many apps can be visible at the same time on screen)
- **Gestures** : iOS gestures adapted for Mac, sometimes not applicable; new hover state
- **Touch Bars**
- **App icons** : adapt iOS icon, or customized for Mac (preferred)
- **Contextual menus**
    - Don’t overwhelm 
    - Be succinct
    - Convey action
    - Order carefully
    - Group with separators
    - Manage complexity with submenus
- **Menu bar menus**
    - collect all actions for the app, organized
    - like contextual menus, but need to keep menus stable
