Title:     Notes WWDC 2021 : What’s new in Swift  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 18, 2021  
Update:    
Keywords:  dev  
Summary:   Mes notes pour la session « What’s new in Swift » de la WWDC 2021.  
Image:     
Language:  fr  


Mes notes pour la session [What’s new in Swift](https://developer.apple.com/videos/play/wwdc2021/10192) de la WWDC 2021.

## Swift packages

### Swift package collections

- Curated list of packages, for different use cases
- Browse package collections from Xcode, add package to projects
- JSON file, anyone can publish
- [swift.org/blog/package-collections](https://swift.org/blog/package-collections)

### New open source packages

Complement what’s available in standard library:

- [Swift Collections](https://github.com/apple/swift-collections): `Deque`, `OrderedSet`, `OrderedDictonary`
- [Swift Algorithms](https://github.com/apple/swift-algorithms)
- [Swift System](https://github.com/apple/swift-system): file paths
- [Swift Numerics](https://github.com/apple/swift-numerics): `Float16`, `Complex`
- [Swift Argument Parser](https://github.com/apple/swift-argument-parser)

## Swift on server

- Static linking on Linux
- Improved JSON performance
- Enhanced AWS Lambda runtime

## Developer experience improvements

- Swift DocC
- Better type checker
- Build improvements
- Memory management

## Ergonomic improvements

- Result builders
- Enum `Codable` synthesis
- Flexible static member lookup
- Property wrappers on parameters

## Asynchronous and concurrent programming

Async example:

``` swift
func fetchImage(id: String) async throws -> UIImage {
  let request = self.imageURLRequest(for: id)
  let (data, response) = try await URLSession.shared.data(for: request)
  if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
    throw TransferFailure()
  }
  guard let image = UIImage(data: data) else {
    throw ImageDecodingFailure()
  }
  return image
}
```

Structured concurrency example:

``` swift
func titleImage() async throws -> Image {
  async let background = renderBackground()
  async let foreground = renderForeground()
  let title = try renderTitle()
  return try await merge(background, foreground, title)
}
```

Actors:

``` swift
actor Statistics {
  private var counter: Int = 0
  func increment() {
    counter += 1
  }
  func publish() async {
    await sendResults(counter)
  }
}

var statistics = Statistics()
await statistics.increment()
```
