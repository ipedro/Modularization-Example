// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Settings",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Settings",
            targets: ["Settings"]
        ),
    ],
    dependencies: [
        .package(name: "Shared", path: "../Support/Shared"),
        .package(name: "AlertPresentable", path: "../Support/AlertPresentable"),
    ],
    targets: [
        .target(
            name: "Settings",
            dependencies: [
                "Shared",
                "AlertPresentable",
            ]
        ),
        .testTarget(
            name: "SettingsTests",
            dependencies: [
                "Settings",
                "Shared",
                "AlertPresentable",
            ]
        ),
    ]
)
