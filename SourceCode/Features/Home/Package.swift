// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Home",
            targets: ["Home"]
        ),
    ],
    dependencies: [
        .package(name: "Shared", path: "../Support/Shared"),
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                "Shared",
            ]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: [
                "Home",
                "Shared",
            ]
        ),
    ]
)
