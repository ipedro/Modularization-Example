// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "AlertPresenting",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AlertPresenting",
            targets: ["AlertPresenting"]
        ),
    ],
    dependencies: [
        .package(name: "Shared", path: "../Shared"),
    ],
    targets: [
        .target(
            name: "AlertPresenting",
            dependencies: [
                "Shared",
            ]
        ),
        .testTarget(
            name: "AlertPresentingTests",
            dependencies: [
                "AlertPresenting",
                "Shared",
            ]
        ),
    ]
)
