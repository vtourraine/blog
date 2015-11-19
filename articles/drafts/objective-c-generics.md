# Generics avec Objective-C


--

## Lightweight Generics

Objective-C declarations of NSArray, NSSet and NSDictionary types using lightweight generic parameterization are imported by Swift with information about the type of their contents preserved.

For example, consider the following Objective-C property declarations:

```` objc
@property NSArray<NSDate *> *dates;
@property NSSet<NSString *> *words;
@property NSDictionary<NSURL *, NSData *> *cachedData;
```

Here’s how Swift imports them:

``` swift
var dates: [NSDate]
var words: Set<String>
var cachedData: [NSURL: NSData]
```

NOTE: Aside from these Foundation collection classes, Objective-C lightweight generics are ignored by Swift. Any other types using lightweight generics are imported into Swift as if they were unparameterized.

--

- [What’s New in Xcode: New Features in Xcode 7, Apple](https://developer.apple.com/library/prerelease/ios/documentation/DeveloperTools/Conceptual/WhatsNewXcode/Articles/xcode_7_0.html)
- [Using Swift with Cocoa and Objective-C: Interacting with Objective-C APIs, Apple](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithObjective-CAPIs.html#//apple_ref/doc/uid/TP40014216-CH4-ID35)
