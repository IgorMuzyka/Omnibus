
@propertyWrapper
public struct Plugin<Injected> {

    public var wrappedValue: Injected {
        guard let bus = Backdoor.bus else {
            fatalError("Bus not initialized")
        }
        guard let dependency: Injected = bus.access() else {
            fatalError("Missing dependency\(Injected.self)")
        }

        return dependency
    }
    public init() {}
}
