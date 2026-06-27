// Displacement.swift
// Phantom type tags for directed offsets in affine space.

/// Phantom type tags for directed offsets in affine space.
///
/// Displacements represent directed quantities: offsets, velocities, extents.
/// Unlike coordinates, displacements form a vector space and can be added together.
///
/// ## Displacement Arithmetic
/// - `Displacement + Displacement = Displacement`
/// - `Displacement - Displacement = Displacement`
/// - `Displacement + Coordinate = Coordinate` (commutative translation)
///
/// ## Example
///
/// ```swift
/// typealias Dx = Displacement.X<MySpace>.Value<Double>
/// let dx1: Dx = 5.0
/// let dx2: Dx = 3.0
/// let sum = dx1 + dx2  // OK: Displacement + Displacement = Displacement
/// ```
public enum Displacement {
    /// Horizontal offset dx (1D), parameterized by coordinate system.
    public enum X<Space> {}

    /// Vertical offset dy (1D), parameterized by coordinate system.
    public enum Y<Space> {}

    /// Depth offset dz (1D), parameterized by coordinate system.
    public enum Z<Space> {}

    /// W offset dw (1D), parameterized by coordinate system.
    public enum W<Space> {}

    /// N-dimensional displacement, parameterized by dimensionality and coordinate system.
    public enum Vector<let N: Int, Space> {}
}

// MARK: - Spatial Conformances

extension Displacement.X: Spatial {}
extension Displacement.Y: Spatial {}
extension Displacement.Z: Spatial {}
extension Displacement.W: Spatial {}
extension Displacement.Vector: Spatial {}

// MARK: - Value Typealiases

extension Displacement.X {
    /// A tagged X displacement value in the given space.
    public typealias Value<Scalar> = Tagged<Displacement.X<Space>, Scalar>
}

extension Displacement.Y {
    /// A tagged Y displacement value in the given space.
    public typealias Value<Scalar> = Tagged<Displacement.Y<Space>, Scalar>
}

extension Displacement.Z {
    /// A tagged Z displacement value in the given space.
    public typealias Value<Scalar> = Tagged<Displacement.Z<Space>, Scalar>
}

extension Displacement.W {
    /// A tagged W displacement value in the given space.
    public typealias Value<Scalar> = Tagged<Displacement.W<Space>, Scalar>
}
