Title:     Notes WWDC 2022 : Desktop-class iPad apps  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 22, 2022  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour les sessions « Build a desktop-class iPad app » et « Adopt desktop-class editing interactions » de la WWDC 2022.  
Image:     
Language:  fr  


Mes notes pour les sessions [Build a desktop-class iPad app](https://developer.apple.com/videos/play/wwdc2022/10070/) et [Adopt desktop-class editing interactions](https://developer.apple.com/videos/play/wwdc2022/10071/) de la WWDC 2022.


## UI organization

``` swift
navigationItem.style = .editor
navigationItem.backAction = UIAction(...)
```

Title menu for actions affecting the whole document.

``` swift
let properties = UIDocumentProperties(url: document.fileURL)

if let itemProvider = NSItemProvider(contentsOf: document.fileURL) {
  properties.dragItemsProvider = { _ in
    [UIDragItem(itemProvider: itemProvider)]
  }
  properties.activityViewControllerProvider = {
    UIActivityViewController(activityItems: [itemProvider], applicationActivities: nil)
  }
}

navigationItem.documentProperties = properties
```

Add custom actions (not automatically included on Catalyst, need to explicitly add them to app menu):

``` swift
func didOpenDocument() {
  ...
  navigationItem.titleMenuProvider = { [unowned self] suggested in
    var children = suggested
    children += [
      UIMenu(title: "Export…", image: UIImage(systemName: "arrow.up.forward.square"), children: [
        UIAction(title: "HTML", image: UIImage(systemName: "safari")) { ... },
        UIAction(title: "PDF", image: UIImage(systemName: "doc")) { ... }
      ])
    ]
    return UIMenu(children: children)
  }
}
```

Customizable center items:

``` swift
navigationItem.customizationIdentifier = "editorView"
(...)
UIBarButtonItem(title: "Sync Scrolling", ...).creatingFixedGroup()
UIBarButtonItem(title: "Add Link", ...).creatingOptionalGroup(customizationIdentifier: "addLink")
UIBarButtonItemGroup.optionalGroup(customizationIdentifier: "textFormat", isInDefaultCustomization: false, representativeItem: UIBarButtonItem(title: "Format", ...), items: [
UIBarButtonItem(title: "Bold", ...),
UIBarButtonItem(title: "Italics", ...),
UIBarButtonItem(title: "Underline", ...)])
```

## Quick actions

Best with lightweight selection.

``` swift
collectionView.allowsMultipleSelection = true
collectionView.allowsFocus = true
collectionView.selectionFollowsFocus = true

(...)

func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {

  if indexPaths.count == 0 {
    // Construct an empty space menu
  } 
  else if indexPaths.count == 1 {
    // Construct a single item menu
  } 
  else {
    // Construct a multi-item menu
  }
}
```

## Text experience

``` swift
textView.isFindInteractionEnabled = true
```

Custom actions:

``` swift
func textView(_ textView: UITextView, editMenuForTextIn range: NSRange, suggestedActions: [UIMenuElement]) -> UIMenu? {

  if textView.selectedRange.length > 0 {
    let customActions = [ UIAction(title: "Hide", ... ) { ... } ]
    return UIMenu(children: customActions + suggestedActions)
  }

  return nil
}
```

Presenting programmatically (not supported on Mac idiom):

``` swift
let editMenuInteraction = UIEditMenuInteraction(delegate: self)
view.addInteraction(editMenuInteraction)

let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
tapRecognizer.allowedTouchTypes = [UITouch.TouchType.direct.rawValue as NSNumber]
view.addGestureRecognizer(tapRecognizer)

@objc func didTap(_ recognizer: UITapGestureRecognizer) {
  let location = recognizer.location(in: self.view)
  if self.hasSelectedObjectView(at: location) {
    let configuration = UIEditMenuConfiguration(identifier: nil, sourcePoint: location)
    editMenuInteraction.presentEditMenu(with: configuration)
  }
}

func editMenuInteraction(_ interaction: UIEditMenuInteraction, targetRectFor configuration: UIEditMenuConfiguration) -> CGRect {
  guard let selectedView = objectView(at: configuration.sourcePoint) else {
    return .null
  }

  return selectedView.frame
}

func editMenuInteraction(_ interaction: UIEditMenuInteraction, menuFor configuration: UIEditMenuConfiguration, suggestedActions: [UIMenuElement]) -> UIMenu? {
  let duplicateAction = UIAction(title: "Duplicate") { ... }
  return UIMenu(children: suggestedActions + [duplicateAction])
}
```

Can be kept presented:

``` swift
UIAction(title: "Increase", image: UIImage(systemName: "increase.indent"), attributes: .keepsMenuPresented) { ... }
```