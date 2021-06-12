Title:     Notes WWDC 2021 : Meet the Location Button  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 12, 2021  
Update:    
Keywords:  dev, iOS  
Summary:   Mes notes pour la session « Meet the Location Button » de la WWDC 2021.  
Image:     
Language:  fr  


Mes notes pour la session [Meet the Location Button](https://developer.apple.com/videos/play/wwdc2021/10102) de la WWDC 2021.

`CLLoctionButton`: new way to request location authorization.

Gives the app “allow once” authorization without prompt.

Customizable, but with restrictions: will log a message for “inappropriate size”, “insufficient alpha” or “insufficient contrast ratio between tintColor and backgroundColor”.

``` swift
let button = CLLocationButton()
button.label = .currentLocation
button.addTarget(self, action: #selector(showParks), for: .touchUpInside)

// ...

@objc func showParks() {
  // Not needed, called by the button itself
  // self.locationManager.requestWhenInUseAuthorization()
  
  self.locationManager.startUpdatingLocation()
}
```

For SwiftUI, use `LocationButton()`
