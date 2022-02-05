// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "News",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "News",
            targets: ["News"]
        ),
    ],
    dependencies: [
        .package(name: "Shared", path: "../Support/Shared"),
    ],
    targets: [
        .target(
            name: "News",
            dependencies: [
                "Shared",
            ]
        ),
        .testTarget(
            name: "NewsTests",
            dependencies: [
                "News",
                "Shared",
            ]
        ),
    ]
)
