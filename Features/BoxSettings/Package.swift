// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "BoxSettings",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "BoxSettings",
            targets: ["BoxSettings"])
    ],
    dependencies: [
        .package(name: "SharedCode", path: "../Support/SharedCode")
    ],
    targets: [
        .target(
            name: "BoxSettings",
            dependencies: [
                "SharedCode"
            ]
        ),
        .testTarget(
            name: "BoxSettingsTests",
            dependencies: [
                "BoxSettings",
                "SharedCode"
            ]
        )
    ]
)
