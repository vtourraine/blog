Title:     Notes WWDC 2021 : Meet DocC documentation in Xcode  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 15, 2021  
Update:    
Keywords:  dev, Xcode  
Summary:   Mes notes pour la session « Meet DocC documentation in Xcode » de la WWDC 2021.  
Image:     
Language:  fr  


Mes notes pour la session [Meet DocC documentation in Xcode](https://developer.apple.com/videos/play/wwdc2021/10166) de la WWDC 2021.


DocC (“Documentation Compiler”): Reference, Articles, and Tutorials

Open Source later this year

- New “Build Documentation” menu item in “Product“ menu
- New “Build Documentation during 'Build'” build settings
- New `xcodebuild docbuild` command

Comment with `/// ...` or `/** ... */` (multiline)

Example with inner code example:

```swift
/// Food that a sloth can consume.
///
/// Sloths love to eat the leaves and twigs they find in the rainforest canopy as they
/// slowly move around. To feed them these items, you can use the `twig`,
/// `regularLeaf` and `largeLeaf` default foods.
///
/// ```swift
/// superSloth.eat(.twig)
/// ```
public struct Food {
  // ...
}
```

Example with parameters and returns:

```swift
/// A model representing a sloth.
public struct Sloth {
  /// Sleep in the specified habitat for a number of hours.
  ///
  /// - Parameters:
  ///   - habitat: The location for the sloth to sleep.
  ///   - numberOfHours: The number of hours for the sloth to sleep.
  /// - Returns: The sloth’s energy level after sleeping.
  mutating public func sleep(in habitat: Habitat, for numberOfHours: Int = 12) -> Int {
    energyLevel += habitat.comfortLevel * numberOfHours
    return energyLevel
  }
}
```

New with DocC: connecting your documentation with double backtick:

```swift
/// A model representing a sloth.
public struct Sloth {
  /// Eat the provided specialty sloth food.
  ///
  /// Sloths love to eat while they move very slowly through their rainforest habitats. They
  /// are especially happy to consume leaves and twigs, which they digest over long periods
  /// of time, mostly while they sleep.
  ///
  /// ```swift
  /// let flower = Sloth.Food(name: "Flower Bud", energy: 10)
  /// superSloth.eat(flower)
  /// ```
  ///
  /// When they eat food, a sloth's ``energyLevel`` increases by the food's
  /// ``Food/energy``. 
  ///
  /// - Parameters:
  ///   - food: The food for the sloth to eat.
  ///   - quantity: The quantity of the food for the sloth to eat.
  /// - Returns: The sloth's energy level after eating.
  mutating public func eat(_ food: Food, quantity: Int = 1) -> Int {
    energyLevel += food.energy * quantity
    return energyLevel
  }
}
```

Documentation “archives”, additional output shareable as single-page web app.
