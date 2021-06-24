Title:     Notes WWDC 2021 : Use the camera for keyboard input in your app  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 24, 2021  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la session « Use the camera for keyboard input in your app » de la WWDC 2021.  
Image:     
Language:  fr  


Mes notes pour la session [Use the camera for keyboard input in your app](https://developer.apple.com/videos/play/wwdc2021/10276) de la WWDC 2021.


## Filtering content

For instance: only scan phone numbers

Based on `UITextContentType` and `UIKeyboardType` (for `UITextField` and `UITextView`)

New types in iOS 15:
- `.FlightNumber`
- `.ShipmentTrackingNumber`
- `.DateTime`

Disable autocorrect to get quick access button above keyboard

Can create explicit button to expose this feature:

```swift
let textFromCamera = UIAction.captureTextFromCamera(responder: self.notes, identifier: nil)
```

Check for availability first:
```swift
if !self.notes.canPerformAction(#selector(captureTextFromCamera(:)), withSender: self) {
  return
}
```

To support on non-textfield/non-textview, implement `UIKeyInput`:

```swift
class HeadlineImageView: UIImageView, UIKeyInput {
  var headlineLabel: UILabel = UILabel()
  var hasText: Bool = false

  override init(image: UIImage?) {
    super.init(image: image)
    initializeLabel()
  }
  
  func insertText(_ text: String) {
    headlineLabel.text = text
  }

  func deleteBackward() { }
}
```
