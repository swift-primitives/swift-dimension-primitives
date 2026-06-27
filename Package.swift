// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-dimension-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(
            name: "Dimension Primitives",
            targets: ["Dimension Primitives"]
        ),
        .library(
            name: "Dimension Primitives Test Support",
            targets: ["Dimension Primitives Test Support"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-axis-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-direction-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-finite-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-tagged-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-numeric-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-pair-primitives.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Dimension Primitives",
            dependencies: [
                .product(name: "Axis Primitive", package: "swift-axis-primitives"),
                .product(name: "Direction Primitive", package: "swift-direction-primitives"),
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
                .product(name: "Tagged Primitives", package: "swift-tagged-primitives"),
                .product(name: "Numeric Primitives Core", package: "swift-numeric-primitives"),
                .product(name: "Real Primitives", package: "swift-numeric-primitives"),
                .product(name: "Pair Primitives", package: "swift-pair-primitives"),
            ]
        ),
        .target(
            name: "Dimension Primitives Test Support",
            dependencies: [
                "Dimension Primitives",
                .product(name: "Finite Primitives Test Support", package: "swift-finite-primitives"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Dimension Primitives Tests",
            dependencies: [
                "Dimension Primitives",
                "Dimension Primitives Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
