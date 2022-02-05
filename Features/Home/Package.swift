// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Home",
            targets: ["Home"])
    ],
    dependencies: [
        .package(name: "SharedCode", path: "../Support/SharedCode")
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                "SharedCode"
            ]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: [
                "Home",
                "SharedCode"
            ]
        )
    ]
)
