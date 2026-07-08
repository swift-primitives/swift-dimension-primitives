// Extent.swift
// Phantom type tags for unsigned size dimensions.

/// Phantom type tags for unsigned size dimensions.
///
/// Extents represent non-directional size dimensions: width, height, depth.
/// Semantically distinct from signed displacements.
///
/// ## Example
///
/// ```swift
/// typealias Width = Extent.X<MySpace>.Value<Double>
/// typealias Height = Extent.Y<MySpace>.Value<Double>
/// let size = width * height  // Raw scalar (area)
/// ```
public enum Extent {}

// MARK: - Nested Types

extension Extent {
    /// Width (1D), parameterized by coordinate system.
    public enum X<Space> {}

    /// Height (1D), parameterized by coordinate system.
    public enum Y<Space> {}

    /// Depth (1D), parameterized by coordinate system.
    public enum Z<Space> {}

    /// N-dimensional extent, parameterized by dimensionality and coordinate system.
    public enum Vector<let N: Int, Space> {}
}

// MARK: - Spatial Conformances

extension Extent.X: Spatial {}
extension Extent.Y: Spatial {}
extension Extent.Z: Spatial {}
extension Extent.Vector: Spatial {}

// MARK: - Value Typealiases

extension Extent.X {
    /// A tagged X extent (width) value in the given space.
    public typealias Value<Scalar> = Tagged<Extent.X<Space>, Scalar>
}

extension Extent.Y {
    /// A tagged Y extent (height) value in the given space.
    public typealias Value<Scalar> = Tagged<Extent.Y<Space>, Scalar>
}

extension Extent.Z {
    /// A tagged Z extent (depth) value in the given space.
    public typealias Value<Scalar> = Tagged<Extent.Z<Space>, Scalar>
}
