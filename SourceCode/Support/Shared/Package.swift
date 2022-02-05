// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Shared",
            targets: ["Shared"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ipedro/Coordinator", branch: "main"),
    ],
    targets: [
        .target(
            name: "Shared",
            dependencies: [
                "Coordinator",
            ]
        ),
        .testTarget(
            name: "SharedTests",
            dependencies: [
                "Shared",
                "Coordinator",
            ]
        ),
    ]
)
