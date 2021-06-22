Title:     Notes WWDC 2021 : Focus on iPad keyboard navigation  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 22, 2021  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la session « Focus on iPad keyboard navigation » de la WWDC 2021.  
Image:     
Language:  fr  


Mes notes pour la session [Focus on iPad keyboard navigation](https://developer.apple.com/videos/play/wwdc2021/10260/) de la WWDC 2021.


With iOS 15 SDK, keyboard navigation enabled by default for:

- Text fields
- Text views
- Sidebars

Opt-in for:

- Collection views
- Table views
- Custom views

Focus system: same as tvOS, with additional features

## Focusability

```swift
override var canBecomeFocused: Bool { true }
```

```swift
class MyViewController: UICollectionViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.allowsFocus = true
  }
}

class MyCollectionViewDelegate: NSObject, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
    return true
  }
}
```

## Appearance

“Halo” as the default effect, customizable

```swift
let focusEffect = UIFocusHaloEffect(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius, curve: .continuous)

// make sure the effect is added right above the image view
focusEffect.referenceView = self.imageView

// make sure the effect is added to our scroll view
focusEffect.containerView = self.scrollView

self.focusEffect = focusEffect
```

## Sidebars

`selectionFollowsFocus`, available on collection views and table views. Can also be customized cell by cell.

## Focus groups

- Tab key to switch groups, arrows to switch items within current group
- By default, environments inherit their parent environment’s group
- Can define item priority within its group

## Responder chain

Focus and first responder synchronized.
