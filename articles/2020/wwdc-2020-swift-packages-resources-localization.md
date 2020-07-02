Title:     Notes WWDC 2020 : Swift packages - Resources and localization  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      July 2, 2020  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la sessions WWDC 2020 « Swift packages: Resources and localization ».  
Image:     
Language:  fr  


Voici mes notes pour la session [Swift packages: Resources and localization](https://developer.apple.com/wwdc20/10169).

Works with existing API, so does not affect iOS version requirements of the package, but needs Xcode 12.

## Adding resources to a package

In package manifest, need Swift 5.3

``` swift
// swift-tools-version:5.3
```

Files in a package are processed according to their type (extension):

- Clear purpose, just add the file: `.xcassets`, `.storyboard`, `.xib`, `.nib`, `.xcdatamodel`, `.xcmappingmodel`, etc
- Ambiguous purpose, need to declare intent in manifest (include or exclude): directories, images, text files, shell scripts, JSON files, etc

Exclude: can list directory, will apply to the directory and everything it contains.

``` swift
excludes: ["Internal Notes.txt", "Artwork Creation"]
```

Include: list resources, and mark them to be processed. Exact processing rules depends on the platform, falls back to copy if type unknown. Copy: no processing, copy whole directory (keep its structure).

``` swift
resources: [.process("Logo.png"), .copy("Game Data")]
```

## Accessing resources from code

On Apple platforms, resources are used with the existing Foundation Bundle API.

Xcode synthesizes a bundle accessor:
- Swift: `Bundle.module`
- ObjC: `SWIFTPM_MODULE_BUNDLE`

``` swift
Image(dice.dots.name, bundle: .module)
```

If package needs to expose its resources to other modules, best to provide public accessors for individual resources, not the whole bundle.

## Localizing resources

Add default localisation to manifest (needed for any package that contains resources):

``` swift
defaultLocalization: "en"
```

Add localized folders (`.lproj`). No need to list them in manifest.
