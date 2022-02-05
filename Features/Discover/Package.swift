// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Discover",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Discover",
            targets: ["Discover"])
    ],
    dependencies: [
        .package(name: "SharedCode", path: "../Support/SharedCode")
    ],
    targets: [
        .target(
            name: "Discover",
            dependencies: [
                "SharedCode"
            ]
        ),
        .testTarget(
            name: "DiscoverTests",
            dependencies: [
                "Discover",
                "SharedCode"
            ]
        )
    ]
)
