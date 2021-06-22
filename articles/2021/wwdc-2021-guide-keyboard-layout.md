Title:     Notes WWDC 2021 : Your guide to keyboard layout  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 22, 2021  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la session « Your guide to keyboard layout » de la WWDC 2021.  
Image:     
Language:  fr  


Mes notes pour la session [Your guide to keyboard layout](https://developer.apple.com/videos/play/wwdc2021/10259/) de la WWDC 2021.


## Layout guide

Notification-based keyboard layout remains available.

New: `UIKeyboardLayoutGuide`

- Basic use case: update to use `.topAnchor`
- Matches animations
- Follows height changes
- Bottom of safe area when undocked

```swift
view.keyboardLayoutGuide.topAnchor.constraint(equalToSystemSpacingBelow: textView.bottomAnchor, multiplier: 1.0).isActive = true
```

## Integrating the keyboard

Not just a layout guide:

- `.followsUndockedKeyboard` (`false` by default)
- Subclass of `UITrackingLayoutGuide`, can specify constraints `near`/`away` specific edge

```swift
let awayFromTopConstraints = [
  view.keyboardLayoutGuide.topAnchor.constraint(equalTo: editView.bottomAnchor),
]
view.keyboardLayoutGuide.setConstraints(awayFromTopConstraints, activeWhenAwayFrom: .top)

let nearTopConstraints = [
  view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: editView.bottomAnchor)
]
view.keyboardLayoutGuide.setConstraints(nearTopConstraints, activeWhenNearEdge: .top)
```

## Types of keyboards

- Text input via camera: same as docked keyboard, but can be fullscreen
- Shortcuts bar: width is adaptive, can be collapsed
