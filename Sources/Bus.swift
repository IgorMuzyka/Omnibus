
open class Bus: Module, AccessInterface, BusInterface {

	public weak var bus: Bus?
	internal var modules = [String: Module]()

	public init() {
		bus = self
	}

	public static func new(_ configure: (Bus) -> Void) -> Bus {
		let bus = Bus()

		configure(bus)

		return bus
	}
}

public protocol BusInterface: Module {}

extension BusInterface where Self == Bus {

	@discardableResult
	public func install<ModuleType: Module>(_ module: ModuleType) -> ModuleType {
		guard let bus = bus else { fatalError() }

		let key = typeName(of: ModuleType.self)
		(module as? Installable)?.preInstall?(self)
		module.bus = bus
		bus.modules[key] = module
		(module as? Installable)?.postInstall?(self)
		return module
	}

	@discardableResult
	public func uninstall<ModuleType: Module>(_ module: ModuleType) -> ModuleType {
		guard let bus = bus else { fatalError() }

		if let _: ModuleType = bus.access() {
			let key = typeName(of: ModuleType.self)
			(module as? Uninstallable)?.preUninstall?(self)
			bus.modules.removeValue(forKey: key)
			(module as? Uninstallable)?.postUninstall?(self)
		}
		return module
	}

	@discardableResult
	public func hotswap<ModuleType: Module>(_ module: ModuleType) -> ModuleType {
		return install(uninstall(module))
	}
}

public protocol AccessInterface: Module {}

extension AccessInterface where Self == Bus {

	@discardableResult
	public func access<WrappedType>() -> WrappedType? {
		let key = typeName(of: ModuleWrap<WrappedType>.self)
		return (self.modules[key] as? ModuleWrap<WrappedType>)?.unwrap()
	}

	@discardableResult
	public func access<ModuleType: Module>() -> ModuleType? {
		let key = typeName(of: ModuleType.self)
		return self.modules[key] as? ModuleType
	}
}

@inline(__always) private func typeName<T>(of object: T) -> String {
	return String(reflecting: type(of: T.self))
}
