// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Landmarks",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "Assets", targets: ["Assets"]),
        .library(name: "DataManager", targets: ["DataManager"]),
        .library(name: "Home", targets: ["Home"]),
        .library(name: "LandmarkDetail", targets: ["LandmarkDetail"]),
        .library(name: "LandmarkList", targets: ["LandmarkList"]),
        .library(name: "Models", targets: ["Models"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.50.0")
    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: [
                "DataManager",
                "Home",
                "LandmarkList",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "Assets",
            dependencies: []
        ),
        .target(
            name: "DataManager",
            dependencies: [
                "Models"
            ]
        ),
        .target(
            name: "Home",
            dependencies: [
                "Assets",
                "LandmarkDetail",
                "Models",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "LandmarkDetail",
            dependencies: [
                "Assets",
                "Models",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "LandmarkList",
            dependencies: [
                "Assets",
                "DataManager",
                "Models",
                "LandmarkDetail",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "Models",
            dependencies: []
        ),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: ["AppFeature"]
        )
    ]
)
