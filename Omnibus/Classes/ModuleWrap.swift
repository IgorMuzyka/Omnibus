
public final class ModuleWrap<Wrappable>: Module, Installable, Uninstallable {

	public typealias Wrapped = Wrappable

	fileprivate var wrapped: Wrapped?

	public var preInstall: ((Bus) -> Void)!
	public var postInstall: ((Bus) -> Void)!
	public var preUninstall: ((Bus) -> Void)!
	public var postUninstall: ((Bus) -> Void)!

	public weak var bus: Bus? {
		didSet {
			if let module = wrapped as? Module {
				module.bus = bus
			}
		}
	}

	public init(_ wrappable: Wrappable) {
		wrapped = wrappable

		preInstall = { [weak self] bus in
			(self?.wrapped as? Installable)?.preInstall(bus)
		}
		postInstall = { [weak self] bus in
			(self?.wrapped as? Installable)?.postInstall(bus)
		}
		preUninstall = { [weak self] bus in
			(self?.wrapped as? Uninstallable)?.preUninstall(bus)
		}
		postUninstall = { [weak self] bus in
			(self?.wrapped as? Uninstallable)?.postUninstall(bus)
		}
	}

	public func preInstall(_ handler: @escaping (Bus) -> Void) -> ModuleWrap<Wrapped> {
		preInstall = handler
		return self
	}

	public func postInstall(_ handler: @escaping (Bus) -> Void) -> ModuleWrap<Wrapped> {
		postInstall = handler
		return self
	}

	public func preUninstall(_ handler: @escaping (Bus) -> Void) -> ModuleWrap<Wrapped> {
		preUninstall = handler
		return self
	}

	public func postUninstall(_ handler: @escaping (Bus) -> Void) -> ModuleWrap<Wrapped> {
		postUninstall = handler
		return self
	}

	public func unwrap() -> Wrapped? {
		return wrapped
	}
}
