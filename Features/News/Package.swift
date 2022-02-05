// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "News",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "News",
            targets: ["News"]),
    ],
    dependencies: [
        .package(name: "SharedCode", path: "../SharedCode")
    ],
    targets: [
        .target(
            name: "News",
            dependencies: [
                "SharedCode"
            ]
        ),
        .testTarget(
            name: "NewsTests",
            dependencies: [
                "News",
                "SharedCode"
            ]
        )
    ]
)
