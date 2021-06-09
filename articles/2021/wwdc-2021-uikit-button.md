Title:     Notes WWDC 2021 : Meet the UIKit button system  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 9, 2021  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la session « Meet the UIKit button system » de la WWDC 2021.  
Image:     
Language:  fr  

Mes notes pour la session [Meet the UIKit button system](https://developer.apple.com/videos/play/wwdc2021/10064) de la WWDC 2021.

## Buttons

4 basic styles:

- `plain` (already existing)
- `gray`
- `tinted`
- `filled`

## Button configuration

Simple example:

``` swift
let button = UIButton(type: .system)
button.configuration = .filled()
```

Complex example:

``` swift
var config = UIButton.Configuration.tinted()
config.title = "abc"
config.image = UIImage(...)
config.imagePlacement = .trailing
button = UIButton(configuration: config, primaryAction: ...)

button.configurationUpdateHandler = {
  [unowned self] button in
  
  var config = button.configuration
  config?.image = button.isHighlighted ? UIImage(...) : UIImage(...)
  config?.subtitle = self.stuff
  button.configuration = config
}

// ...

private var stuff: String? {
  didSet {
    button.setNeedsUpdateConfiguration()
  }
}
```

Any button can show activity indicator `showsActivityIndicator = true` (replacing the image if necessary).

Layout: `contentInsets`, `titlePadding`, `imagePadding`.

Semantic styling: `baseBackgroundColor`, `baseForegroundColor`, `cornerStyle`, `buttonSize`.

## Toggle buttons

Preserve a `selected` state:

``` swift
button.changesSelectionAsPrimaryAction = true
```

## Pop-up buttons

Similar to pull-down buttons, enforce a single selected item.

Can be created in Interface Builder or in code:

``` swift
let button = UIButton(primaryAction: nil)
button.menu = UIMenu(children: [
  UIAction(title: "", handler: ...),
  UIAction(title: "", state: .on, handler: ...)
])
button.showsMenuAsPrimaryAction = true
button.changesSelectionAsPrimaryAction = true
```

Automatically updated to their Mac version with Catalyst. This can be disabled with `button.preferredBehavioralStyle = .pad`
