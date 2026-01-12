// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-dimension-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(
            name: "Dimension Primitives",
            targets: ["Dimension Primitives"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-identity-primitives.git", from: "0.0.1"),
        .package(url: "https://github.com/swift-primitives/swift-numeric-primitives.git", from: "0.0.1"),
        .package(url: "https://github.com/swift-primitives/swift-formatting-primitives.git", from: "0.0.1"),
        .package(url: "https://github.com/swift-primitives/swift-test-primitives.git", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "Dimension Primitives",
            dependencies: [
                .product(name: "Identity Primitives", package: "swift-identity-primitives"),
                .product(name: "Numeric Primitives", package: "swift-numeric-primitives"),
                .product(name: "Real Primitives", package: "swift-numeric-primitives"),
                .product(name: "Formatting Primitives", package: "swift-formatting-primitives"),
            ]
        ),
        .testTarget(
            name: "Dimension Primitives Tests",
            dependencies: [
                "Dimension Primitives",
                .product(name: "Numeric Primitives", package: "swift-numeric-primitives"),
                .product(name: "Test Primitives", package: "swift-test-primitives"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
