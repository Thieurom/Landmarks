// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Landmarks",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "AppFeature", targets: ["AppFeature"])
    ],
    dependencies: [],
    targets: [
        .target(name: "AppFeature"),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: ["AppFeature"]
        )
    ]
)
