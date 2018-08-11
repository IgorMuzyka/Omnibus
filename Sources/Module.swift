
public protocol Module: class {

	var bus: Bus? { get set } // use weak value
}

public protocol Installable: Module {

	var preInstall: ((Bus) -> Void)! { get }
	var postInstall: ((Bus) -> Void)! { get }
}

public protocol Uninstallable: Module {

	var preUninstall: ((Bus) -> Void)! { get }
	var postUninstall: ((Bus) -> Void)! { get }
}
