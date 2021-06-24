Title:     Notes WWDC 2021 : SF Symbols in UIKit and AppKit  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 24, 2021  
Update:    
Keywords:  dev, iOS, macOS  
Summary:   Mes notes pour la session « SF Symbols in UIKit and AppKit » de la WWDC 2021.  
Image:     
Language:  fr  


Mes notes pour la session [SF Symbols in UIKit and AppKit](https://developer.apple.com/videos/play/wwdc2021/10251) de la WWDC 2021.

## Color rendering modes

Multicolor symbols available in macOS 11, now in UIKit starting with iOS 15.

Hierarchical:

```swift
var image = NSImage(systemSymbolName: "ipad.landscape", accessibilityDescription: "iPad")

let config = NSImage.SymbolConfiguration(hierarchicalColor: .label)

deviceView.image = image
deviceView.symbolConfiguration = config
```

Image variants (propagates down the view hierarchy, fallback to basic symbol if variant isn’t available):

```swift
actionsView.imageVariant = .circle.fill
```

Color:

```swift
let config = UIImage.SymbolConfiguration(paletteColors: [.tintColor, .systemGray2])

speakerConfig.preferredSymbolConfigurationForImage = config
speakerButton.configuration = speakerConfig
```

Multicolor symbol:

```swift
let image = UIImage(systemName: category.iconName)

let config = UIImage.SymbolConfiguration.preferringMultiColor

let tintColor = category.colorForIcon

cell.imageView.image = image
cell.imageView.preferredSymbolConfiguration = config
cell.imageView.tintColor = tintColor
```

## Combining configurations

```swift
let image = UIImage(systemImage: "ipad.and.iphone")
headerView.image = image

let fontConfig = UIImage.SymbolConfiguration(pointSize: 60, scale: .large)
let colorConfig = UIImage.SymbolConfiguration(hierarchicalColor: .systemBlue)
let config = fontConfig.applying(colorConfig)

headerView.preferredSymbolConfiguration = config
```

## Colors in attributed strings

```swift
let amenitiesString = NSMutableAttributedString(...)

if (room.amenities.contains(.tv)) {
  let config = UIImage.SymbolConfiguration(hierarchicalColor: .systemGreen)
  let tvImage = UIImage(systemImage: "tv", withConfiguration: config)

  let attachment = NSTextAttachment(image: tvImage)
  let attachmentString = NSAttributedString(attachment: attachment)
  let tvString = attachmentString.mutableCopy()
  tvString.append(NSAttributedString(" TV, ")

  amenitiesString.append(tvString)
}
```
