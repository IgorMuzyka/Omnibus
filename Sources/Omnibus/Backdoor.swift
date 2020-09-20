
/// literally
public struct Backdoor {

	private static var bug = Bug()

	private init() {}

	public static func install(on bus: Bus) {
		bus.install(bug)
		bus.install(bus)
	}

	public static func uninstall(from: Bus?) {
		guard let bus = bus else { return }

		bus.uninstall(bug)
		bus.uninstall(bus)

		let modules = Array(bus.modules.values)
		modules.forEach { module in
			(module as? Uninstallable)?.preUninstall?(bus)
		}
		bus.modules = [:]

		modules.forEach { module in
			(module as? Uninstallable)?.postUninstall?(bus)
		}
	}

	public static var bus: Bus? {
		return bug.bus
	}

	/// as the one that NSA would install on your phone
	private final class Bug: Module {

		fileprivate weak var bus: Bus?

		fileprivate init() {}
	}
}
