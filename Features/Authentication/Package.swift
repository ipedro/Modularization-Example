// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Authentication",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Authentication",
            targets: ["Authentication"])
    ],
    dependencies: [
        .package(name: "SharedCode", path: "../Support/SharedCode")
    ],
    targets: [
        .target(
            name: "Authentication",
            dependencies: [
                "SharedCode"
            ]
        ),
        .testTarget(
            name: "AuthenticationTests",
            dependencies: [
                "Authentication",
                "SharedCode"
            ]
        )
    ]
)
