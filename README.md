# Omnibus

Swift dependency container.

## Installation

To install it, simply add the following line to your Podfile:

```ruby
pod 'Omnibus', :git => 'https://github.com/IgorMuzyka/Omnibus.git'
```

## Usage

***Create*** your **module** and **conform** to `Module`. You can also **conform** to `Installable`, `Uninstallable` ***protocols*** to be able to **handle** those events.

```swift
import Omnibus

public class MyFirstModule: Module, Installable, Uninstallable {

	public weak var bus: Bus?

	public var preInstall: ((Bus) -> Void)! {
		return { bus in
			print("will install module on", bus)
		}
	}
	public var postInstall: ((Bus) -> Void)!
	public var preUninstall: ((Bus) -> Void)! {
		return { bus in
			print("will uninstall module from", bus)
		}
	}
	public var postUninstall: ((Bus) -> Void)!

	public init() {

	}
}
```

Or some `struct` **Object** without conforming to `Module`

```swift
public struct MyObject {

	var name: String
}
```

**Extend** the `Bus`. You can also **specify** `Installable`, `Uninstallable` calls on `ModuleWrap` object.

```swift
import Omnibus

extension Bus {

	public static var common: Bus {
		return .new { bus in
			bus.install(MyFirstModule())
			bus.install(
				ModuleWrap(MyObject(name: "Object"))
					.preInstall {
						print("will install object on", $0)
					}.preUninstall {
						print("will uninstall object from", $0)
					}
			)
		}
	}
}
```

***Create*** the `Bus` and ***install*** a `Backdoor` on it

```swift
// somewhere in your main.swift or AppDelegate.swift

Backdoor.install(on: .common)

```

And whenever you need your specific `Module` just ***access*** them

```swift
// like this
let myFirstModuleOne: MyFirstModule? = Backdoor.bus?.access()
let myObjectOne: MyObject? = (Backdoor.bus?.access() as ModuleWrap<MyObject>?)?.unwrap()

// or like this
let myFirstModuleTwo = (Backdoor.bus?.access() as MyFirstModule?)
let myObjectTwo = ((Backdoor.bus?.access() as ModuleWrap<MyObject>?)?.unwrap() as MyObject?)
```

And you can always ***uninstall*** your `Backdoor` from the `Bus` which will also destroy the `Bus` ***uninstalling*** all the **modules** it has.

```swift
Backdoor.uninstall(from: Backdoor.bus)
```

If you want to just ***change*** your `Bus` you should

```swift
Backdoor.uninstall(from: Backdoor.bus)
Backdoor.install(on: someBus)
```

You can ***install*** and ***uninstall*** **modules** on `Bus` at any time

```swift
let module = MyFirstModule()
Backdoor.bus?.install(module)
Backdoor.bus?.uninstall(module)
```

## Author

Igor Muzyka, igormuzyka42@gmail.com

## License

Omnibus is available under the MIT license. See the LICENSE file for more info.
