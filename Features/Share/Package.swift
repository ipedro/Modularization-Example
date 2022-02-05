// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Share",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Share",
            targets: ["Share"])
    ],
    dependencies: [
        .package(name: "SharedCode", path: "../SharedCode")
    ],
    targets: [
        .target(
            name: "Share",
            dependencies: [
                "SharedCode"
            ]
        ),
        .testTarget(
            name: "ShareTests",
            dependencies: [
                "Share",
                "SharedCode"
            ]
        )
    ]
)
