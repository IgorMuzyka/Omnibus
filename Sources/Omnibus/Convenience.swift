
@inline(__always) internal func typeName<T>(of object: T) -> String {
    return String(reflecting: type(of: T.self))
}
