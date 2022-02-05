// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "ToastPresenting",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "ToastPresenting",
            targets: ["ToastPresenting"]
        ),
    ],
    dependencies: [
        .package(name: "Shared", path: "../Shared"),
    ],
    targets: [
        .target(
            name: "ToastPresenting",
            dependencies: [
                "Shared",
            ]
        ),
        .testTarget(
            name: "ToastPresentingTests",
            dependencies: [
                "ToastPresenting",
                "Shared",
            ]
        ),
    ]
)
