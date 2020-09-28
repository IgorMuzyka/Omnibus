
open class Bus: Module, AccessInterface, BusInterface {

	public weak var bus: Bus?
	internal var modules = [String: Module]()

	public init() {
		bus = self
	}

    @discardableResult
	public static func new(_ configure: (Bus) -> Void) -> Bus {
		let bus = Bus()

		configure(bus)
        Backdoor.install(on: bus)

		return bus
	}
}
