// Coordinate.swift
// Phantom type tags for absolute positions in affine space.

/// Phantom type tags for absolute positions in affine space.
///
/// Coordinates represent positions, not displacements. You cannot add two coordinates,
/// but you can compute the displacement between them or translate a coordinate by a displacement.
///
/// ## Affine Arithmetic
/// - `Coordinate - Coordinate = Displacement` (vector between positions)
/// - `Coordinate + Displacement = Coordinate` (translate position)
/// - `Coordinate - Displacement = Coordinate` (translate position)
///
/// ## Example
///
/// ```swift
/// typealias X = Coordinate.X<MySpace>.Value<Double>
/// let x: X = 10.0
/// let dx: Displacement.X<MySpace>.Value<Double> = 5.0
/// let newX = x + dx  // OK: Coordinate + Displacement = Coordinate
/// ```
public enum Coordinate {}

// MARK: - Nested Types

extension Coordinate {
    /// Horizontal position (1D), parameterized by coordinate system.
    public enum X<Space> {}

    /// Vertical position (1D), parameterized by coordinate system.
    public enum Y<Space> {}

    /// Depth position (1D), parameterized by coordinate system.
    public enum Z<Space> {}

    /// Homogeneous coordinate (1D), parameterized by coordinate system.
    public enum W<Space> {}

    /// N-dimensional position, parameterized by dimensionality and coordinate system.
    public enum Vector<let N: Int, Space> {}
}

// MARK: - Spatial Conformances

extension Coordinate.X: Spatial {}
extension Coordinate.Y: Spatial {}
extension Coordinate.Z: Spatial {}
extension Coordinate.W: Spatial {}
extension Coordinate.Vector: Spatial {}

// MARK: - Value Typealiases

extension Coordinate.X {
    /// A tagged X coordinate value in the given space.
    public typealias Value<Scalar> = Tagged<Coordinate.X<Space>, Scalar>
}

extension Coordinate.Y {
    /// A tagged Y coordinate value in the given space.
    public typealias Value<Scalar> = Tagged<Coordinate.Y<Space>, Scalar>
}

extension Coordinate.Z {
    /// A tagged Z coordinate value in the given space.
    public typealias Value<Scalar> = Tagged<Coordinate.Z<Space>, Scalar>
}

extension Coordinate.W {
    /// A tagged W coordinate value in the given space.
    public typealias Value<Scalar> = Tagged<Coordinate.W<Space>, Scalar>
}
