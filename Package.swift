// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Omnibus",
    products: [
        .library(name: "Omnibus", targets: ["Omnibus"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Omnibus", dependencies: []),
    ]
)
