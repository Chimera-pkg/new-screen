# skribex_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Links - Notes that helped me to build this, Thanks to the authors. 
- https://medium.com/flutter/google-maps-and-flutter-cfb330f9a245
- https://www.youtube.com/watch?v=M7cOmiSly3Q
- https://www.youtube.com/watch?v=D4nhaszNW4o
- https://pub.dev/packages/location
- https://aws.amazon.com/getting-started/hands-on/build-flutter-mobile-app-part-one/module-one/
- https://www.youtube.com/watch?v=4LVeom2V5S8
- https://apple.stackexchange.com/questions/422371/how-to-disable-cmdshifta-and-cmdshiftm-from-cli-in-macos

# Some Notes
## Make Google maps to work on ios side
- For google maps to work, add the below lines exactly in the `ios/Runner/Info.plist` file
- Make sure you have `<string>` first and then `<key>`. If you have `<key>` first and then `<string>` it is not working.
- And also add these lines in the `Info.plist` file along with other `<string>` and `<key>` entries.
```xml
<string>SkribeX displays the location on map and saves your trip.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>SkribeX displays the location on map and saves your trip.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key> 
```
## Make sure the development target is set to at least 13.0
```shell
Open `xcode` and check the below screen.
```
![Screenshot 2024-01-03 at 3.09.55 PM.png](Screenshot%202024-01-03%20at%203.09.55%E2%80%AFPM.png)

## Check Simulator Location:
``` 
Ensure that the iOS Simulator has a location set. In the simulator menu, go to "Features" -> "Location" and select a location.
```
## Simulate Location Updates:
In the simulator menu, go to "Features" -> "Location" -> "Freeway Drive" or any other location that simulates movement. This might trigger location updates in the app.

## To upgrade Google Maps SDK for ios
- Update the platform version to `11.0` by uncommenting the line in `ios/Podfile`
```
platform :ios, '11.0'
```
- Then run the below commands
```shell
> cd ios
> pod update
```#   n e w - s c r e e n  
 #   n e w - s c r e e n  
 