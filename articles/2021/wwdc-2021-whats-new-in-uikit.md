Title:     Notes WWDC 2021 : What’s new in UIKit  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 12, 2021  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la session « What’s new in UIKit » de la WWDC 2021.  
Image:     
Language:  fr  


Mes notes pour la session [What’s new in UIKit](https://developer.apple.com/videos/play/wwdc2021/10059) de la WWDC 2021.

## Productivity

iPad multitasking: “center scene” (long tap + “Open in New Window” to open as modal), can then be moved to different multitasking mode:

``` swift
let action = UIWindowScene.ActivationAction({ _ in
  let userActivity = NSUserActivity(activityType: "...")
  return UIWindowScene.ActivationConfiguration(userActivity: userActivity)
)}

// add action to menu
```

Pointer band selection enabled by default on `UICollectionView` that support multi-selection.

New keyboard shortcuts menu:

``` swift
class AppDelegate: UIResponder, UIApplicationDelegate {
  override fun buildMenu(with builder: UIMenuBuilder) {
    // ...
  }
}
```

Focus-based keyboard navigation (from tvOS) now on iPadOS: arrows to switch between focus items, tab to switch between focus groups.

Inter-apps drag-and-drop now available on iOS.

## UI refinements

- Refined `UIToolbar` and `UITabBar`; if new appearance doesn’t work, can be adjusted with `scrollEdgeAppearance` (was already available on `UINavigationBar`)
- New appearance for list headers (dynamic background, padding): `.prominentInsetGrouped` and `.extraProminentInsetGrouped`
- `UIListSeparatorConfiguration` (new in iOS 14.5) for advanced separator customization
- Sheet presentation: half height sheets, optionally non-modal
- Updated `UIDatePicker`

## API enhancements

- Enhanced `UIButton` API (new “gray”, “tinted”, “filled” styles)
- Submenus now collapsable
- SF Symbols enhancements: new symbols, new color options (monochrome, hierarchical, palette, multicolor); variants can now be selected without hard-coded strings
- Content size category limits
- `UIColor` enhancements: harmonised across platforms; new `UIColor.tintColor`; improved color picker
- TextKit 2: used for `UITextField`, no adoption required
- `UIScene` state restoration enhancements
- Cell configuration closures enhancements
- Improved diffable data source

## Performance

Cell prefetching improvements (optional).

`async` to configure with images:

``` swift
if let image = UIImage(contentsOfFile: ...) {
  async {
    let preparedImage = await image.byPreparingForDisplay()
    imageView.image = preparedImage
  }
}
```

## Security and privacy

Location Button: one-time access to location, flexible configuration API.

Pasteboard banner no longer shown when using system “Copy”/“Paste” menu items. New paste items (“Paste and Go”, “Paste and Search”, “Paste and Match Style”). New API for pasteboard data detectors.
