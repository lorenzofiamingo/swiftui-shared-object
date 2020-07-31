# SharedObject 🍱

`@SharedObject` is an alternative way to `@StateObject`, `@ObservedObject`, `@EnvironmentObject` for handle `ObservableObject`.
The problem is that with `@StateObject` the object will deinit with the view, with `@EnvironmentObject` you can bind only one instance of the same class for each Environment.

`@SharedObject` simply stores the objects using an identifier, so you can retrieve it each time you'll need it.

## Usage

Retrieve the shared object with the given id or, if not present, create a shared object with an initial value:
```swift
@SharedObject("A") var letterA = Letter()
```
If you are sure that the object is already been created you can just retrieve the shared object:
```swift
@SharedObject("A") var letterA: Letter
```
You can give a default initial value to the class, so you don't need to specify in each view you think the object will be created:
```swift
final class Letter: SharableObject {

  var value: String
		
  init(_ value: String) {
	self.value = value
  }
		
  static var initialValue: Self {
	.init("A")
  }
}
```

## Installation

1. In Xcode, open your project and navigate to **File** → **Swift Packages** → **Add Package Dependency...**
2. Paste the repository URL (`https://github.com/lorenzofiamingo/SwiftUI-SharedObject`) and click **Next**.
3. Click **Finish**.
