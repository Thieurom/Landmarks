// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Landmarks",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "Styleguide", targets: ["Styleguide"]),
        .library(name: "DataManager", targets: ["DataManager"]),
        .library(name: "Home", targets: ["Home"]),
        .library(name: "LandmarkDetail", targets: ["LandmarkDetail"]),
        .library(name: "LandmarkList", targets: ["LandmarkList"]),
        .library(name: "Models", targets: ["Models"]),
        .library(name: "ProfileDetail", targets: ["ProfileDetail"]),
        .library(name: "ProfileEditor", targets: ["ProfileEditor"])
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
            name: "Styleguide",
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
                "Styleguide",
                "LandmarkDetail",
                "Models",
                "ProfileDetail",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "LandmarkDetail",
            dependencies: [
                "Styleguide",
                "Models",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "LandmarkList",
            dependencies: [
                "Styleguide",
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
        .target(
            name: "ProfileDetail",
            dependencies: [
                "Styleguide",
                "Models",
                "ProfileEditor",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "ProfileEditor",
            dependencies: [
                "Styleguide",
                "Models",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: ["AppFeature"]
        ),
        .testTarget(
            name: "LandmarkDetailTests",
            dependencies: ["LandmarkDetail"]
        ),
        .testTarget(
            name: "LandmarkListTests",
            dependencies: [
                "Models",
                "LandmarkList"
            ]
        )
    ]
)
