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
            path: "Synth/Source"
        ),
        .testTarget(
            name: "synth-iosTests",
            dependencies: ["synth-ios"]
        ),
    ]
)
