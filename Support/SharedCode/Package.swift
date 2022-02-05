// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SharedCode",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "SharedCode",
            targets: ["SharedCode"])
    ],
    dependencies: [
        .package(url: "https://github.com/ipedro/Coordinator", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SharedCode",
            dependencies: [
                "Coordinator"
            ]
        ),
        .testTarget(
            name: "SharedCodeTests",
            dependencies: [
                "SharedCode",
                "Coordinator"
            ]
        )
    ]
)
