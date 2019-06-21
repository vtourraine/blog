Title:     Notes WWDC 2019 : Introducing SF Symbols  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 8, 2019  
Update:    
Keywords:  dev, iOS, macOS  
Summary:   Mes notes pour la session 206 de la WWDC 2019 : Introducing SF Symbols.  
Image:     
Language:  fr  


Référence : [Session 206 - Introducing SF Symbols](https://developer.apple.com/wwdc19/206)

- Vector (scalable)
- Weights (very thin to very bold)
- Scales (small, medium, large): select scale depending on container size
- Designed to work with text
- Browse with new SF Symbols app ([download](https://developer.apple.com/design/))

## How to create a custom symbol

1. Export base symbol as SVG file from SF Symbols app
2. Use editor (e.g. Sketch), keep layers hierarchy
3. Export SVG
4. Import SVG to Xcode in Assets Catalog

## Use in code

For system symbol:

``` swift
UIImage(systemName: "")
```

For custom symbol:

``` swift
UIImage(named: "")
```

You can have a symbol and non-symbol image with the same name in an Assets Catalog. Useful for backward compatibility: with same code, iOS 13 loads the symbol, older iOS load the image.

Specify scale for `UIImageView`:

``` swift
let configuration = UIImage.SymbolConfiguration(scale: .large)
imageView.preferredSymbolConfiguration = configuration
```

To align symbol with text: use center align, or baseline align.

### Buttons

Button initializer for glyphs:

``` swift
let image = UIImage(systemName: "")
let button = UIButton.system(image: image, target: self, action: #selector(action))
```

Similar method to set a preferred configuration:

``` swift
let config = UIImage.SymbolConfiguration(textStyle: .caption, scale: .small)
button.setPreferredSymbolConfiguration(config, forState: .normal)
```

### Text

Can embed symbol in attributed string with `NSTextAttachment`:

``` swift
let string = NSMutableAttributedString(string: "I just symbol images!", attributes: [.foregroundColor: UIColor.label])

let heartImage = UIImage(systemName: "heart.fill")
let heartAttachment = NSTextAttachment(image: heartImage)
let heartString = NSAttributedString(attachment: heartAttachment)
string.insert(heartString, at: 7)
```

### Image

New API to apply a tint to a `UIImage`

``` swift
let redImage = baseImage.withTintColor(.redColor) 
```

## Tips

- Prefer horizontal and vertical centering
- Build layouts smallest to largest
- Be flexible: image sizes can change
- Caching images rarely helps performance
- Avoid rasterizing
