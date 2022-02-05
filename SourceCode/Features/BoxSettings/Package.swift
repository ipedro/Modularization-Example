// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "BoxSettings",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "BoxSettings",
            targets: ["BoxSettings"]
        ),
    ],
    dependencies: [
        .package(name: "Shared", path: "../Support/Shared"),
    ],
    targets: [
        .target(
            name: "BoxSettings",
            dependencies: [
                "Shared",
            ]
        ),
        .testTarget(
            name: "BoxSettingsTests",
            dependencies: [
                "BoxSettings",
                "Shared",
            ]
        ),
    ]
)
