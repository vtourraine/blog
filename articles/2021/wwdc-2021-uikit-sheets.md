Title:     Notes WWDC 2021 : Customize and resize sheets in UIKit  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 21, 2021  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la session « Customize and resize sheets in UIKit » de la WWDC 2021.  
Image:     
Language:  fr  


Mes notes pour la session [Customize and resize sheets in UIKit](https://developer.apple.com/videos/play/wwdc2021/10063/) de la WWDC 2021.


## Getting a sheet

A sheet is an instance of a new `UIPresentationController` subclass called `UISheetPresentationController`. Accessed via `viewController.sheetPresentationController`, non-nil for “form sheet” and “page sheet” modal presentation style.

```swift
if let sheet = viewController.sheetPresentationController {
  // Customize the sheet
}
present(viewController, animated: true)
```

## Detents

Height where a sheet naturally rests, expressed as fraction of fully expanded sheet frame. “Medium” or “Large”.

```swift
// Just large by default
sheet.detents = [.medium(), .large()]

// `true` by default (auto expand)
sheet.prefersScrollingExpandsWhenScrolledToEdge = false 

// To keep parent view un-dimmed, `nil` by default
sheet.smallestUndimmedDetentIdentifier = .medium
```
 
 To animate detent changes:

```swift
sheet.animateChanges {
  sheet.selectedDetentIdentifier = .medium
}
```

## Other options

```swift
// Smaller sheets on compact height:
sheet.prefersEdgeAttachedInCompactHeight = true
sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true

// Alternative UI style:
sheet.prefersGrabberVisible = true
```

## Adaptation from popover

To present as a popover on iPad, adapted as sheet on iPhone/compact:

```swift
func showImagePicker(_ sender: UIBarButtonItem) {
  let picker = PHPickerViewController()
  picker.delegate = self
  picker.modalPresentationStyle = .popover

  if let popover = picker.popoverPresentationController {
    popover.barButtonItem = sender

    let sheet = popover.adaptiveSheetPresentationController
    sheet.detents = [.medium(), .large()]
    sheet.prefersScrollingExpandsWhenScrolledToEdge = false
    sheet.smallestUndimmedDetentIdentifier = .medium
  }

  present(picker, animated: true)
}
```
