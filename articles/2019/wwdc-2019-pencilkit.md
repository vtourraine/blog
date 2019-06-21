Title:     Notes WWDC 2019 : Introducing PencilKit  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 12, 2019  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la session 221 de la WWDC 2019 : Introducing PencilKit.  
Image:     
Language:  fr  

Référence : [Session 221 - Introducing PencilKit](https://developer.apple.com/wwdc19/221)

Pencil on iPad, new in iOS 13:
- Lower latency
- New tool palette
- PencilKit
- Markup everywhere

## Great pencil experiences
- Precision enables new user experiences
- Force, azimuth, and altitude allow expressive marks
- Pencil taps switch modes

### Support Pencil Taps
- `UIPencilInteraction` for listening to Pencil taps
- Respect the user’s `preferredTapAction`

``` swift
let interaction = UIPencilInteraction() interaction.delegate = self view.addInteraction(interaction)
func pencilInteractionDidTap(_ interaction: UIPencilInteraction) { 
  switch UIPencilInteraction.preferredTapAction {
    // ...
  }
}
```

## PencilKit

``` swift
let canvas = PKCanvasView(frame: bounds)
view.addSubview(canvas)
canvas.tool = PKInkingTool(.pen, color: .black, width: 30)
```

- `PKCanvasView`
    - `UIScrollView` for panning and zooming
    - Data model is available via `drawing`
    - Interaction mode is changed via `tool`
    - Delegate methods notify about changes
- `PKDrawing`
    - Serializable to data
    - Generates images
    - Can be appended or transformed
    - Available on macOS

### Thumbnail Generation
On background queue, take Dark Mode into account (via trait collection):

``` swift
func thumbnail(drawing: PKDrawing, thumbnailRect: CGRect, traitCollection: UITraitCollection) {
  thumbnailQueue.async {
    traitCollection.performAsCurrent {
      let image = drawing.image(from: thumbnailRect, scale: 2.0)
    }
  }
}
```

### Set a tool
``` swift
canvasView.tool = PKInkingTool(.pen, color: .blue, width: 10)
```


### PKToolPicker
- Similar to the keyboard
- Palette floats over everything
- Visibility based on first responders

``` swift
let toolPicker = PKToolPicker.shared(for: window)
toolPicker.addObserver(canvasView)
toolPicker.setVisible(true, forFirstResponder: canvasView) canvasView.becomeFirstResponder()
```

Compact style:
- Fixed and docked to the bottom
- Listen for changes: `optional func toolPickerFramesObscuredDidChange(_ toolPicker: PKToolPicker)`
- Can obscure content: `public func frameObscured(in view: UIView) -> CGRect`
- Undo/redo buttons hidden: need to display them somewhere else in the interface (e.g. navigation bar)

Customize content scrolling: `var allowsFingerDrawing: Bool { get set }` (`true` by default)

Drawing over content:
``` swift
canvasView.opaque = false
canvasView.backgroundColor = .clear
```

Force user interface style, for instance if writing over an image or a PDF:
``` swift
canvasView.overrideUserInterfaceStyle = .light
```

## Markup everywhere

Set a screenshot delegate on `UIWindowScene`

``` swift
class DrawingViewController: UIScreenshotServiceDelegate {
  override func viewWillAppear() {
    super.viewWillAppear()
    view.window.windowScene.screenshotService.delegate = self
  }
}
```

Deliver full content as PDF data, with 2 metadata info:
 - `indexOfCurrentPage`
 - `rectInCurrentPage` (expected in PDF coordinates)

``` swift
func screenshotService(
UIScreenshotService,
generatePDFRepresentationWithCompletion: (Data?, Int, CGRect) -> Void)
```
