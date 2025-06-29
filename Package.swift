// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "MiniSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MiniSDK",
            targets: ["MiniSDK"]
        ),
    ],
    targets: [
        .target(
            name: "MiniSDK",
            dependencies: [],
            path: "Sources/MiniSDK"
        ),
        .testTarget(
            name: "MiniSDKTests",
            dependencies: ["MiniSDK"],
            path: "Tests/MiniSDKTests"
        ),
    ]
)
