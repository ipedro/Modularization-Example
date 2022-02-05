// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Authentication",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Authentication",
            targets: ["Authentication"]
        ),
    ],
    dependencies: [
        .package(name: "Shared", path: "../Support/Shared"),
    ],
    targets: [
        .target(
            name: "Authentication",
            dependencies: [
                "Shared",
            ]
        ),
        .testTarget(
            name: "AuthenticationTests",
            dependencies: [
                "Authentication",
                "Shared",
            ]
        ),
    ]
)
