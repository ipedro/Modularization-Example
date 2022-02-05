// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Share",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Share",
            targets: ["Share"]
        ),
    ],
    dependencies: [
        .package(name: "Shared", path: "../Support/Shared"),
    ],
    targets: [
        .target(
            name: "Share",
            dependencies: [
                "Shared",
            ]
        ),
        .testTarget(
            name: "ShareTests",
            dependencies: [
                "Share",
                "Shared",
            ]
        ),
    ]
)
