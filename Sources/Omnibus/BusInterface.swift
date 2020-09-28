
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
