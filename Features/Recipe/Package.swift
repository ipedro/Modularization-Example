// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Recipe",

    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Recipe",
            targets: ["Recipe"]),
    ],
    dependencies: [
        .package(name: "SharedCode", path: "../Support/SharedCode")
    ],
    targets: [
        .target(
            name: "Recipe",
            dependencies: [
                "SharedCode"
            ]
        ),
        .testTarget(
            name: "RecipeTests",
            dependencies: [
                "Recipe",
                "SharedCode"
            ]
        )
    ]
)
