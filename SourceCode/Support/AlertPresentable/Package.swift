// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "AlertPresentable",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AlertPresentable",
            targets: ["AlertPresentable"]
        ),
    ],
    dependencies: [
        .package(name: "Shared", path: "../Shared"),
    ],
    targets: [
        .target(
            name: "AlertPresentable",
            dependencies: [
                "Shared",
            ]
        ),
        .testTarget(
            name: "AlertPresentableTests",
            dependencies: [
                "AlertPresentable",
                "Shared",
            ]
        ),
    ]
)
