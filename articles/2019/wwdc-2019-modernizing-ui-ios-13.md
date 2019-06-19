Title:     Notes WWDC 2019 : Modernizing Your UI for iOS 13  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 19, 2019  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la session 224 de la WWDC 2019 : Modernizing Your UI for iOS 13.  
Image:     
Language:  fr  


Référence : [Session 224 - Modernizing Your UI for iOS 13](https://developer.apple.com/wwdc19/224)

## Flexible UI
- Launch Storyboards will be required when building with iOS 13 SDK (April 2020)
- Support any size
- Support split screen multitasking

## Bars
- No navigation bar background when scrolled to the top
- New Appearance Customization API

``` swift
let appearance = UINavigationBarAppearance()
appearance.configureWithOpaqueBackground()

appearance.titleTextAttributes = [.foregroundColor: myAppLabelColor]
appearance.largeTitleTextAttributes = [.foregroundColor: myAppLabelColor]

navigationBar.standardAppearance = appearance
```

Different layout appearances:
- `.standardAppearance`
- `.compactAppearance` (small iPhone screens, landscape)
- `.scrollEdgeAppearance` (large titles)
- `.buttonAppearance`, `.doneButtonAppearance`

Same for toolbars and tab bars:
- `UIToolbar`: `UIToolbarAppearance`
- `UITabBar`: `UITabBarAppearance`
    - `.stackedLayoutAppearance`
    - `.inlineLayoutAppearance`
    - `.compactInlineLayoutAppearance`

Can be customized with view controller navigation item

## Presentations
- Sheets: new design for existing `UIModalPresentationStyle.pageSheet`/`.formSheet`
- Default: `.automatic`, resolved at time of presentation
- Set to `.fullScreen` for explicit fullscreen

Pull down to dismiss automatically. Can be customized (for instance, when the user has entered text in the modal, offer to discard or save new content):

``` swift
class EmailController: UIViewController, UIAdaptivePresentationControllerDelegate {
  func draftDidChange() {
    isModalInPresentation = draft.hasChanges
  }

  func presentationControllerDidAttemptToDismiss(_: UIPresentationController) {
    // Present action sheet
  }
}
```

Appearance callbacks: for page and form sheets with iOS 13 SDK, the presenting view controller is not removed from the view hierarchy, therefore the `viewWill/Did/Appear/Disappear` methods are not called. Use the new “attempt to dismiss” methods instead.

## Search
`UISearchController`: can now hide elements of the search bar (scope, cancel button), search text field exposed

``` swift
let searchController = UISearchController(searchResultsController: /*...*/)

// Don’t automatically show the cancel button or scope bar
searchController.automaticallyShowsCancelButton = false
searchController.automaticallyShowsScopeBar = false

// Customize appearance of the search text field
let searchField = searchController.searchBar.textField
searchField.textColor = UIColor(named: "MyPinkColor")
searchField.font = UIFont(name: "American Typewriter", size: 18)
```

The search results controller can now be displayed as soon as the search bar becomes active (for instance, to display a list of filters, like system Mail app)

``` swift
// Show the search results controller as soon as search is activated
searchController.showsSearchResultsController = true
```

New `UISearchTextField` API for tokens (copy, paste, drag and drop)
- Tokens always precede text
- Can be selected and deleted
- Mixed selections allowed

Creating tokens:
``` swift
let selectedText = field.textIn(field.selectedTextRange)
let token = UISearchToken(icon: nil, text: selectedText)
field.replaceTextualPortion(of: field.selectedTextRange, with: token, at: field.tokens.count)
```

## Gestures
### Selection gestures in custom text views

`UITextInteraction`: implement system text-related gestures in custom text view
- Three lines of code
- Editable and non-editable text interactions
- Use `UITextInput` protocol to control selection UI

``` swift
// Create selection interaction with type .editable or nonEditable
let selectionInteraction = UITextInteraction(for: .editable)
// Assign `textInput` property to your view that implements the UITextInput protocol
selectionInteraction.textInput = textView
// Add the interaction to the view
textView.addInteraction(selectionInteraction)

```

### Multiple selection gestures in tables and collections
- New gesture by placing 2 fingers down, and pan across on table view and collection view
- Also works with keyboard shift key
- Opt-in

``` swift
optional func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAtIndexPath indexPath: IndexPath) -> Bool
optional func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAtIndexPath indexPath: IndexPath)
```

### Editing gestures (undo/redo)
- Frees your app from adding additional UI
- Unified across the entire system
- Great for drawing apps
- Completely free if you use `UndoManager`

Can opt-out:
``` swift
public protocol UIResponder {
  public var editingInteractionConfiguration: UIEditingInteractionConfiguration
}

public enum UIEditingInteractionConfiguration {
  case `default` // System behavior, default
  case none // Disable
}
```

## Menus
### `UIContextMenuInteraction`

- Rich previews
- Complex hierarchies (nested sub-menus, in-line sections)

Consistent gestures, based on device capabilities:
- 3D Touch
- Haptic Touch
- Long press
- Secondary click

### `UIMenu` and `UIAction`
- Hierarchical menu construction system
- `UIMenu` are composable

``` swift
// Create a UIContextMenuInteraction with Some Delegate
let interaction = UIContextMenuInteraction(delegate: self)

// Attach It to Our View
menuSourceView.addInteraction(interaction)
```

### `UIContextMenuInteractionDelegate`

- One required method
- Return a `UIContextMenuConfiguration` to start
- Return `nil` to prevent interaction

``` swift
func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration?
```

``` swift
let actionProvider = (suggestedActions: [UIMenuElement]) -> UIMenu? {
  let editMenu = UIMenu(title: "Edit...", children: [
    UIAction(title: "Copy") { ... },
    UIAction(title: "Duplicate") { ... }
  ])

  return UIMenu(children: [
    UIAction(title: "Share") { ... },
    editMenu,
    UIAction(title: "Delete", style: .destructive) { ... }
  ])
}

return UIContextMenuConfiguration(identifier: "unique-ID" as NSCopying, previewProvider: nil, actionProvider: actionProvider)
```

### `UITableView` and `UICollectionView`
``` swift
// UITableViewDelegate
optional func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAtIndexPath indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration?
```

- Deprecates Peek and Pop
- Replace long-press driven menus
- Adopt it alongside Drag and Drop
