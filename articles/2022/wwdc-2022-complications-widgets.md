Title:     Notes WWDC 2022 : Complications and widgets  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 24, 2022  
Update:    
Keywords:  dev, iOS, watchOS  
Summary:   Mes notes pour les sessions « Complications and widgets: Reloaded » et « Go further with Complications in WidgetKit » de la WWDC 2022.  
Image:     
Language:  fr  


Mes notes pour les sessions [Complications and widgets: Reloaded](https://developer.apple.com/videos/play/wwdc2022/10050/) et [Go further with Complications in WidgetKit](https://developer.apple.com/videos/play/wwdc2022/10051/) de la WWDC 2022.

---

New watchOS 9 complications are now widgets (based on iOS 14 `WidgetKit`), with new families (prefixed with “accessory”). These new families are also available on the new iOS 16 Lock Screen.

``` swift
case accessoryCircular
case accessoryRectangular // multiple lines
case accessoryInline // text-only, multiple sizes

// watchOS only
case accessoryCorner
```

## Colors

3 rendering modes:
- Full colour (watchOS)
- Accented (watchOS)
- Vibrant (iOS)

``` swift
@Environment(\.widgetRenderingMode) var renderingMode
```

For accented, use `widgetAccentable`:

``` swift
VStack(alignment: .leading) {
  Text("Headline")
    .font(.headline)
    .widgetAccentable()
  Text("Body 1")
  Text("Body 2")
}.frame(maxWidth: .infinity, alignment: .leading)
```

For vibrant, avoid transparent colors, use darker colors instead.

New consistent background view: `AccessoryWidgetBackground` 

``` swift
ZStack {
  AccessoryWidgetBackground()
  VStack {
    Text("MON")
    Text("6")
     .font(.title)
  }
}
```

## Project setup

For projects with existing widgets:
1. Duplicate widget extension target
2. Rename
3. Update bundle identifier with Watch app prefix
4. Target watchOS
5. Embed extension in Watch app
6. Add new supported families in widget configuration
7. Use `#if os(watchOS)` for new families and previews
8. For intents, override `recommandations()` on timeline provider

## Making glanceable views

Auto-updating view with live gauge:

``` swift
ProgressView(interval: entry.character.injuryDate...entry.character.fullHealthDate, countdown: false, label: { Text(entry.character.name) }, currentValueLabel: { Avatar(character: entry.character, includeBackground: false) })
.progressViewStyle(.circular)
```

For consistency, use text styles:
- `.headline`
- `.body`
- `.caption`
- `.title`

For inline family, use `ViewThatFits`:

``` swift
ViewThatFits {
  Text("\(entry.character.name) is resting, combat-ready in \(entry.character.fullHealthDate, style: .relative)")
  Text("\(entry.character.name) ready in \(entry.character.fullHealthDate, style: .timer)")
  Text("\(entry.character.avatar) \(entry.character.fullHealthDate, style: .timer)")
}
```

## Privacy

For always-on displays:

```
@Environment(\.isLuminanceReduced)
```

For sensitive content: `.privacySensitive()` modifier.

## Unique to watchOS

For `accessoryCorner`, the “auxiliary content” is typically the curved part in the corner, rendered by the watch face. Use new view modifier `widgetLabel`, with text, gauge, or progress view.

``` swift
struct CornerView: View {
  let value: Double

  var body: some View {
    ZStack {
      AccessoryWidgetBackground()
      Image(systemName: "cup.and.saucer.fill")
        .font(.title.bold())
        .widgetAccentable()
    }
    .widgetLabel {
      Gauge(value: value, in: 0...500) {
        Text("MG")
      } currentValueLabel: {
        Text("\(Int(value))")
      } minimumValueLabel: {
        Text("0")
      } maximumValueLabel: {
        Text("500")
      }
    }
  }
}
```

Can track if auxiliary content is shown:

```
@Environment(\.showsWidgetLabel) var showsWidgetLabel
```

## Migration

No longer need to support the legacy 12 families from `ClockKit`.

Add migrator:

``` swift
var widgetMigrator: CLKComplicationWidgetMigrator {
  self
}
```

With static or intent-based migration:

``` swift
func widgetConfiguration(from complicationDescriptor: CLKComplicationDescriptor) async -> CLKComplicationWidgetMigrationConfiguration? {
  CLKComplicationStaticWidgetMigrationConfiguration(kind: "CoffeeTracker", extensionBundleIdentifier: widgetBundle)
}

func widgetConfiguration(from complicationDescriptor: CLKComplicationDescriptor) async -> CLKComplicationWidgetMigrationConfiguration? {
  CLKComplicationIntentWidgetMigrationConfiguration(kind: "CoffeeTracker", extensionBundleIdentifier: widgetBundle, intent: intent, localizedDisplayName: "Coffee Tracker")
}
```
