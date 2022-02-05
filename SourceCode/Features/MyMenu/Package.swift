// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MyMenu",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "MyMenu",
            targets: ["MyMenu"]
        ),
    ],
    dependencies: [
        .package(name: "Shared", path: "../Support/Shared"),
    ],
    targets: [
        .target(
            name: "MyMenu",
            dependencies: [
                "Shared",
            ]
        ),
        .testTarget(
            name: "MyMenuTests",
            dependencies: [
                "MyMenu",
                "Shared",
            ]
        ),
    ]
)
