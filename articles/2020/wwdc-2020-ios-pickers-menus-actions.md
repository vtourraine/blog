Title:     Notes WWDC 2020 : iOS pickers, menus and actions  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      July 9, 2020  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour les sessions dédiées aux « iOS pickers, menus and actions » de la WWDC 2020.  
Image:     
Language:  fr  

Mes notes pour les sessions dédiées aux « iOS pickers, menus and actions » de la WWDC 2020.

- [Design with iOS pickers, menus and actions](https://developer.apple.com/wwdc20/10205)
- [Build with iOS pickers, menus and actions](https://developer.apple.com/wwdc20/10052)

## Menu
- Can now show menu from any button
- Unify iOS 13 action sheet on iPhone, popover on iPad
- Menu appear next to the button itself
- No need to add Cancel button

Menus can be used for:
- Disambiguation
- Navigation
- Selection
- Collect secondary actions

``` swift
// UIButton, UIBarButtonItem
button.menu = UIMenu(…) // displayed on long press

// UIButton
button.showsMenuAsPrimaryAction = true
// UIBarButtonItem
// Don’t provide a primary action.
```

- `UIDeferredMenuElement` to load menu items asynchronously, with standard loading UI
- `updateVisibleMenu()` to update a presented menu

## Date and time picker
`UIDatePicker`: not new, but significantly improved, new “Compact” mode

- Date
- Time
- Date and time

## Color picker
`UIColorPickerViewController`

- Eyedropper
- Saved colors

## Updated controls

Other existing controls have received minor updates:

- Tweaked appearance
- Closer to Mac versions
- More customization
