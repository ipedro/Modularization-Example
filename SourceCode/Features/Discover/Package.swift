// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Discover",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Discover",
            targets: ["Discover"]
        ),
    ],
    dependencies: [
        .package(name: "Shared", path: "../Support/Shared"),
    ],
    targets: [
        .target(
            name: "Discover",
            dependencies: [
                "Shared",
            ]
        ),
        .testTarget(
            name: "DiscoverTests",
            dependencies: [
                "Discover",
                "Shared",
            ]
        ),
    ]
)
