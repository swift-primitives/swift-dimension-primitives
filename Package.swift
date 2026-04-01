// swift-tools-version: 6.3

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
        .package(path: "../swift-finite-primitives"),
        .package(path: "../swift-identity-primitives"),
        .package(path: "../swift-numeric-primitives"),
        .package(path: "../swift-formatting-primitives")
    ],
    targets: [
        .target(
            name: "Dimension Primitives",
            dependencies: [
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
                .product(name: "Identity Primitives", package: "swift-identity-primitives"),
                .product(name: "Numeric Primitives", package: "swift-numeric-primitives"),
                .product(name: "Real Primitives", package: "swift-numeric-primitives"),
                .product(name: "Formatting Primitives", package: "swift-formatting-primitives")
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
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
