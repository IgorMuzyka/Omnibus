
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
