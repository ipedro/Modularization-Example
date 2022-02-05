// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Inbox",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Inbox",
            targets: ["Inbox"]
        ),
    ],
    dependencies: [
        .package(name: "Shared", path: "../Support/Shared"),
    ],
    targets: [
        .target(
            name: "Inbox",
            dependencies: [
                "Shared",
            ]
        ),
        .testTarget(
            name: "InboxTests",
            dependencies: [
                "Inbox",
                "Shared",
            ]
        ),
    ]
)
