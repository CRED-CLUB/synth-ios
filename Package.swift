// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Synth",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "Synth",
            targets: ["Synth"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Synth",
            dependencies: [],
            path: "Synth/Source"
        ),
        .testTarget(
            name: "synth-iosTests",
            dependencies: ["Synth"]
        ),
    ]
)
