// Measure.swift
// Phantom type tag for N-dimensional scalar measures.

/// Phantom type tag for N-dimensional scalar measures.
///
/// Measures are non-directional quantities parameterized by their dimension:
/// - `Measure<1, Space>` = Length (distance, radius, norm)
/// - `Measure<2, Space>` = Area
/// - `Measure<3, Space>` = Volume
///
/// ## Dimensional Arithmetic
/// - `Measure<1> × Measure<1> → Measure<2>` (Length × Length = Area)
/// - `Measure<1> × Measure<2> → Measure<3>` (Length × Area = Volume)
/// - `√Measure<2> → Measure<1>` (√Area = Length)
///
/// ## Example
///
/// ```swift
/// typealias Radius = Measure<1, MySpace>.Value<Double>
/// typealias Area = Measure<2, MySpace>.Value<Double>
/// let r: Radius = 5.0
/// let area: Area = r * r  // Length × Length = Area
/// ```
public enum Measure<let N: Int, Space> {}

// MARK: - Spatial Conformance

extension Measure: Spatial {}

// MARK: - Value Typealias

extension Measure {
    /// A tagged measure value of dimension N in the given space.
    public typealias Value<Scalar> = Tagged<Measure<N, Space>, Scalar>
}

// MARK: - Measure Dimension Typealiases

/// Non-directional length (1D measure): distances, radii, norms.
///
/// Magnitudes can be added to coordinates along any axis.
///
/// ## Example
///
/// ```swift
/// typealias Radius = Magnitude<MySpace>.Value<Double>
/// let center: Coordinate.X<MySpace>.Value<Double> = 10.0
/// let radius: Radius = 5.0
/// let edge = center + radius  // OK: Coordinate + Magnitude = Coordinate
/// ```
public typealias Magnitude<Space> = Measure<1, Space>

/// 2-dimensional measure (area).
///
/// Result of multiplying two lengths or displacement components.
public typealias Area<Space> = Measure<2, Space>

/// 3-dimensional measure (volume).
///
/// Result of multiplying length by area, or three lengths.
public typealias Volume<Space> = Measure<3, Space>

// MARK: - Semantic Typealiases

// These provide semantic names for common uses of Magnitude.
// All are structurally identical but convey different intent.

/// A non-directional length measurement.
public typealias Length<Space, Scalar> = Magnitude<Space>.Value<Scalar>

/// Radius of a circle or sphere.
public typealias Radius<Space, Scalar> = Magnitude<Space>.Value<Scalar>

/// Diameter of a circle or sphere.
public typealias Diameter<Space, Scalar> = Magnitude<Space>.Value<Scalar>

/// Distance between two points.
public typealias Distance<Space, Scalar> = Magnitude<Space>.Value<Scalar>

/// Circumference of a circle.
public typealias Circumference<Space, Scalar> = Magnitude<Space>.Value<Scalar>

/// Perimeter of a closed shape.
public typealias Perimeter<Space, Scalar> = Magnitude<Space>.Value<Scalar>

/// Arc length along a curve.
public typealias ArcLength<Space, Scalar> = Magnitude<Space>.Value<Scalar>
