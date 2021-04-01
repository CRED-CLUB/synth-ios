// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "synth-ios",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "synth-ios",
            targets: ["synth-ios"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "synth-ios",
            dependencies: [],
            path: "synth-ios/Source"
        ),
        .testTarget(
            name: "synth-ios-tests",
            dependencies: ["synth-ios"]
        ),
    ]
)
