// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Inbox",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Inbox",
            targets: ["Inbox"])
    ],
    dependencies: [
        .package(name: "SharedCode", path: "../Support/SharedCode")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Inbox",
            dependencies: [
                "SharedCode"
            ]
        ),
        .testTarget(
            name: "InboxTests",
            dependencies: [
                "Inbox",
                "SharedCode"
            ]
        )
    ]
)
