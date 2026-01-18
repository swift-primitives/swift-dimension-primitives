// swift-tools-version: 6.2

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
        )
    ],
    dependencies: [
        .package(path: "../swift-algebra-primitives"),
        .package(path: "../swift-finite-primitives"),
        .package(path: "../swift-identity-primitives"),
        .package(path: "../swift-numeric-primitives"),
        .package(path: "../swift-formatting-primitives")
    ],
    targets: [
        .target(
            name: "Dimension Primitives",
            dependencies: [
                .product(name: "Algebra Primitives", package: "swift-algebra-primitives"),
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
                .product(name: "Identity Primitives", package: "swift-identity-primitives"),
                .product(name: "Numeric Primitives", package: "swift-numeric-primitives"),
                .product(name: "Real Primitives", package: "swift-numeric-primitives"),
                .product(name: "Formatting Primitives", package: "swift-formatting-primitives")
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let settings: [SwiftSetting] = [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableExperimentalFeature("Lifetimes"),
        .strictMemorySafety()
    ]
    target.swiftSettings = (target.swiftSettings ?? []) + settings
}
