# Dimension Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Phantom-typed spatial dimensions for Swift — coordinates, displacements, extents, measures, angles, scales, and orientations whose arithmetic is checked by the type system.

Every quantity is tagged with the coordinate space it lives in and the role it plays, so affine geometry is enforced at compile time: you can subtract two positions to get a displacement, translate a position by a displacement, and multiply two lengths to get an area — but adding two positions, or assigning an area where a length is expected, simply does not type-check.

---

## Quick Start

```swift
import Dimension_Primitives

// A coordinate space is just a phantom tag — declare one per logical space.
enum Screen {}

// Positions are coordinates; offsets are displacements. The type system keeps them apart.
let left: Coordinate.X<Screen>.Value<Double> = 10
let right: Coordinate.X<Screen>.Value<Double> = 90

// Subtracting two positions yields a displacement (the vector between them)…
let width: Displacement.X<Screen>.Value<Double> = right - left   // 80

// …and translating a position by a displacement yields another position.
let shifted = left + width                                       // Coordinate.X == 90

// Adding two positions is meaningless in affine geometry — so it is a compile error:
// let nonsense = left + right     // ❌ no '+' for Coordinate.X + Coordinate.X

// Dimensional analysis is enforced too: length × length is an area, not a length.
let area: Area<Screen>.Value<Double> = width * width             // Measure<2>

// Angles carry their unit; conversion and trigonometry stay typed.
let quarterTurn = Radian<Double>.pi.half                         // π/2
let inDegrees = quarterTurn.degrees                              // 90°
```

---

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-dimension-primitives.git", branch: "main"),
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Dimension Primitives", package: "swift-dimension-primitives"),
    ]
)
```

The package is pre-1.0 — until 0.1.0 is tagged, depend on `branch: "main"` rather than `from: "0.1.0"`. Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## What's Inside

Foundation-free, with no concurrency surface and no platform conditionals.

| Concept | Type | Role |
|---------|------|------|
| Position | `Coordinate.{X, Y, Z, W, Vector}<Space>` | An absolute point in an affine space. |
| Offset | `Displacement.{X, Y, Z, W, Vector}<Space>` | A directed vector between positions. |
| Size | `Extent.{X, Y, Z, Vector}<Space>` | A non-directional width / height / depth. |
| Measure | `Measure<N, Space>` (`Magnitude`, `Area`, `Volume`, `Length`, `Radius`, …) | An N-dimensional scalar quantity. |
| Angle | `Radian<Scalar>`, `Degree<Scalar>` | A typed angle with conversion and trigonometry. |
| Scaling | `Scale<N, Scalar>` | A dimensionless N-dimensional scale transform. |
| Unit interval | `Interval<Scalar>.Unit` (`Opacity`, `Alpha`) | A value clamped to [0, 1], closed under multiplication. |
| Orientation | `Direction`, `Horizontal`, `Vertical`, `Depth`, `Temporal` | A two-state axis convention conforming to `Orientation`. |
| Handedness | `Chirality`, `Winding` | Left/right and clockwise/counterclockwise distinctions. |

The two library products are `Dimension Primitives` (the umbrella consumers import) and `Dimension Primitives Test Support` (fixtures for downstream test targets).

---

## Affine Arithmetic

The operators are deliberately partial. The type system permits exactly the combinations that are geometrically meaningful and rejects the rest:

| Expression | Result | Notes |
|------------|--------|-------|
| `Coordinate - Coordinate` | `Displacement` | The vector between two positions. |
| `Coordinate + Displacement` | `Coordinate` | Translate a position (commutative). |
| `Coordinate - Displacement` | `Coordinate` | Translate a position. |
| `Displacement + Displacement` | `Displacement` | Displacements form a vector space. |
| `Coordinate + Coordinate` | — | No operator — adding two positions is undefined. |
| `Length × Length` | `Area` | `Measure<1> × Measure<1> → Measure<2>`. |
| `Length × Area` | `Volume` | `Measure<1> × Measure<2> → Measure<3>`. |
| `Displacement × Scale<1>` | `Displacement` | Only vectors scale; positions do not. |

Coordinate spaces that conform to the numeric quantization protocol have their arithmetic results snapped to a grid automatically, so equal grid points always compare equal regardless of floating-point representation.

---

## Platform Support

| Platform | CI | Status |
|----------|-----|--------|
| macOS 26 | Yes | Full support |
| iOS / tvOS / watchOS / visionOS | — | Supported |
| Linux | Yes | Full support |
| Windows | Yes | Full support |
| Swift Embedded | — | Supported (`Codable` conformances are excluded under Embedded) |

---

## Stability

Pre-1.0. The public API may change while the package remains on `branch: "main"`; consumers should expect breaking changes to surface in commit messages until the first tag. Once tagged, the package follows institute SemVer: post-1.0 breaking changes ship behind a major bump.

---

## Related Packages

Direct dependencies (siblings in the swift-primitives org):

- `swift-tagged-primitives` — `Tagged<Tag, Underlying>`, the phantom-tagging machinery every dimensional value is built on.
- `swift-axis-primitives` — `Axis<N>`, the axis namespace the orientation typealiases attach to.
- `swift-direction-primitives` — `Direction`, the canonical two-state orientation atom.
- `swift-numeric-primitives` — `Numeric.Fraction`, the quantization protocol, and the real-number trigonometry surface.
- `swift-finite-primitives` — `Finite.Enumerable`, `Ordinal`, and `Cardinal`, re-exported for convenience.
- `swift-pair-primitives` — `Pair`, the carrier for orientation-paired values (`Oriented`).

---

## Community

<!-- BEGIN: discussion -->
*Discussion thread will be created at first public release.*
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
