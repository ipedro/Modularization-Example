// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Recipe",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Recipe",
            targets: ["Recipe"]
        ),
    ],
    dependencies: [
        .package(name: "Shared", path: "../Support/Shared"),
    ],
    targets: [
        .target(
            name: "Recipe",
            dependencies: [
                "Shared",
            ]
        ),
        .testTarget(
            name: "RecipeTests",
            dependencies: [
                "Recipe",
                "Shared",
            ]
        ),
    ]
)
