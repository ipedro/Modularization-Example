// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MyMenu",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "MyMenu",
            targets: ["MyMenu"])
    ],
    dependencies: [
        .package(name: "SharedCode", path: "../SharedCode")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MyMenu",
            dependencies: [
                "SharedCode"
            ]
        ),
        .testTarget(
            name: "MyMenuTests",
            dependencies: [
                "MyMenu",
                "SharedCode"
            ]
        )
    ]
)
