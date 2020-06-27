Title:     Notes WWDC 2020 : Tests  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 27, 2020  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour les sessions dédiées aux tests de la WWDC 2020 : « Write tests to fail », « Triage test failures with XCTIssue » et « XCTSkip your tests ».  
Image:     
Language:  fr  

Voici mes notes pour les sessions dédiées aux tests de la WWDC 2020.

## [Write tests to fail](https://developer.apple.com/wwdc20/10091)

### Set up
- Use `func setUpWithError() throws`
- Perform common class setup tasks
- Leverage `launchArguments` or `launchEnvironment` to set state
- Adopt product changes to focus testing

### Test: actions
- Design tests for a specific goal
- Use enum (for instance to store strings)
- Factor common code into helper functions
- Model UI hierarchy in testing code
- Consider using a framework or a Swift package to share testing code

### Test: assertions
- Add assertion messages
- Use relevant `XCTAssert*` function
- Unwrap optionals
- Use `waitForExistence()` for asynchronous events
- Throw errors from shared code
- Use `XCTContext.runActivity()` and attachments
- Consider `XCTSkip()`

### Tear down
- Use `tearDownWithError() throws`
- Collect additional logging
- Reset the environment


## [Triage test failures with XCTIssue](https://developer.apple.com/wwdc20/10687)

New in Xcode 12

### Swift errors in tests
Source locations for thrown errors, with Swift runtime improvements (iOS 13.4, macOS 10.15.4)

Throwing from setup and teardown with
`setUpWithError() throws` and `tearDownWithError() throws`

### Rich failure objects
In Xcode 12, errors are represented with `XCTIssue`: can now add attachments, and more.

## [XCTSkip your tests](https://developer.apple.com/wwdc20/10164)

New in Xcode 11.4

- Dynamic conditional test execution (for instance, to skip iPad specific code, iOS version specific code)
- Adds a third test result: “Pass”, “Fail”, “Skip”
- Skipped tests properly displayed in Xcode; in tests report, with a button to jump to the code where the test was skipped
- Two throwing functions: `XCTSkipIf()` and `XCTSkipUnless()` (same parameters)
- `XCTSkip` to throw directly, in combination with `guard`

``` swift
func testABC() throws {
  guard #available(iOS 13.4, *) else {
    throws XCTSkip("Can only run on iOS 13.4+")
  }

  try XCTSkipIf(UIDevice.current.userInterfaceIdiom != .pad, "for iPad only")
}
```
