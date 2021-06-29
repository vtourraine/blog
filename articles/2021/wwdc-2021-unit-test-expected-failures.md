Title:     Notes WWDC 2021 : Embrace Expected Failures in XCTest  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 28, 2021  
Update:    
Keywords:  dev, Xcode  
Summary:   Mes notes pour la session « Embrace Expected Failures in XCTest » de la WWDC 2021.  
Image:     
Language:  fr  


Mes notes pour la session [Embrace Expected Failures in XCTest](https://developer.apple.com/videos/play/wwdc2021/10207) de la WWDC 2021.


Up until now, 2 solutions to handle known failures:

- Disabling: reduce visibility
- `XCTSkip`: can miss changes

```swift
try XCTSkipUnless(UIDevice.current.userInterfaceIdiom == .pad, "Only supported on iPad")
```

## New: `XCTExpectFailure`

Called at beginning of test. Test failures reported as expected failures, suite reported as passed.

Can embed URL:

```swift
XCTExpectFailure("<https://dev.myco.com/bugs/4923> myValidationFunction is returning false")
```

Stateful or scoped:

```swift
XCTExpectFailure("<https://dev.myco.com/bugs/4923> fix myValidationFunction") {
  XCTAssert(myValidationFunction())
}
```

Issue matching filters:

```swift
let options = XCTExpectedFailure.Options()
options.issueMatcher = { issue in
  return issue.type == .assertionFailure
}

XCTExpectFailure("<https://dev.myco.com/bugs/4923> fix myValidationFunction", options: options)
```

```swift
let options = XCTExpectedFailure.Options()
#if os(macOS)
options.isEnabled = false
#endif

XCTExpectFailure("<https://dev.myco.com/bugs/4923> fix myValidationFunction", options: options) {
  XCTAssert(myValidationFunction())
}
```

Tests that don’t always fail (deterministic or not), can specify as “non strict”:

```swift
XCTExpectFailure("<https://dev.myco.com/bugs/4923> fix myValidationFunction", strict: false) {
  XCTAssert(myValidationFunction())
}
```
