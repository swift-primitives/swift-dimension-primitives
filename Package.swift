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
        .package(path: "../swift-identity-primitives"),
        .package(path: "../swift-numeric-primitives"),
        .package(path: "../swift-formatting-primitives"),
        .package(path: "../swift-test-support-primitives"),
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
                .product(name: "Test Support Primitives", package: "swift-test-support-primitives"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
