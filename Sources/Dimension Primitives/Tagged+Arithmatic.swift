//
//  File.swift
//  swift-standards
//
//  Created by Coen ten Thije Boonkkamp on 13/12/2025.
//

// MARK: - Displacement to Extent Conversion

// These functions convert displacement (signed vector component) to extent (size dimension).
// Use when computing sizes from coordinate differences: width((urx - llx))

/// Converts an X-displacement to an X-extent (width).
@inlinable
public func width<Space, Scalar>(
    _ dx: Displacement.X<Space>.Value<Scalar>
) -> Extent.X<Space>.Value<Scalar> {
    dx.retag(Extent.X<Space>.self)
}

/// Converts a Y-displacement to a Y-extent (height).
@inlinable
public func height<Space, Scalar>(
    _ dy: Displacement.Y<Space>.Value<Scalar>
) -> Extent.Y<Space>.Value<Scalar> {
    dy.retag(Extent.Y<Space>.self)
}

/// Converts a Z-displacement to a Z-extent (depth).
@inlinable
public func depth<Space, Scalar>(
    _ dz: Displacement.Z<Space>.Value<Scalar>
) -> Extent.Z<Space>.Value<Scalar> {
    dz.retag(Extent.Z<Space>.self)
}

// MARK: - Zero

// Note: We intentionally do NOT conform Tagged to AdditiveArithmetic.
// In affine geometry, Coordinate - Coordinate = Displacement (not Coordinate).
// Blanket +/- operators would give wrong types. Each type defines its own operators.

extension Tagged where RawValue: AdditiveArithmetic {
    /// The zero value for this tagged type.
    @inlinable
    public static var zero: Self {
        Self(__unchecked: (), .zero)
    }
}

// MARK: - Negation

extension Tagged where RawValue: SignedNumeric {
    /// Returns the negation of this value.
    @inlinable
    public static prefix func - (value: Self) -> Self {
        value.map { -$0 }
    }
}

// MARK: - Absolute Value, Min, Max

/// Returns the absolute value of a tagged value.
@inlinable
public func abs<Tag, T: SignedNumeric & Comparable>(_ x: Tagged<Tag, T>) -> Tagged<Tag, T> {
    x.map { abs($0) }
}

/// Returns the minimum of two tagged values.
@inlinable
public func min<Tag, T: Comparable>(_ x: Tagged<Tag, T>, _ y: Tagged<Tag, T>) -> Tagged<Tag, T> {
    x.rawValue <= y.rawValue ? x : y
}

/// Returns the maximum of two tagged values.
@inlinable
public func max<Tag, T: Comparable>(_ x: Tagged<Tag, T>, _ y: Tagged<Tag, T>) -> Tagged<Tag, T> {
    x.rawValue >= y.rawValue ? x : y
}

// NOTE: Blanket scaling operators (Tagged * Int, Tagged / Int) were removed.
// In affine geometry, only Displacements and Magnitudes can be scaled - not Coordinates.
// See below for mathematically correct per-type scaling operators.

// MARK: - Angle × Scale

/// Scales a radian angle by a scale factor.
@inlinable
public func * <Scalar: FloatingPoint>(
    lhs: Angle.Radian.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Angle.Radian.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.value)
}

/// Scales a radian angle by a scale factor (commutative).
@inlinable
public func * <Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Angle.Radian.Value<Scalar>
) -> Angle.Radian.Value<Scalar> {
    Tagged(__unchecked: (), lhs.value * rhs.rawValue)
}

/// Divides a radian angle by a scale factor.
@inlinable
public func / <Scalar: FloatingPoint>(
    lhs: Angle.Radian.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Angle.Radian.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue / rhs.value)
}

/// Scales a degree angle by a scale factor.
@inlinable
public func * <Scalar: FloatingPoint>(
    lhs: Angle.Degree.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Angle.Degree.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.value)
}

/// Scales a degree angle by a scale factor (commutative).
@inlinable
public func * <Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Angle.Degree.Value<Scalar>
) -> Angle.Degree.Value<Scalar> {
    Tagged(__unchecked: (), lhs.value * rhs.rawValue)
}

/// Divides a degree angle by a scale factor.
@inlinable
public func / <Scalar: FloatingPoint>(
    lhs: Angle.Degree.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Angle.Degree.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue / rhs.value)
}

// MARK: - Displacement Same-Type Arithmetic

/// Adds two X-displacements.
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Displacement.X<Space>.Value<Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) -> Displacement.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Subtracts two X-displacements.
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Displacement.X<Space>.Value<Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) -> Displacement.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Adds two Y-displacements.
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Displacement.Y<Space>.Value<Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) -> Displacement.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Subtracts two Y-displacements.
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Displacement.Y<Space>.Value<Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) -> Displacement.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Adds two Z-displacements.
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Displacement.Z<Space>.Value<Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) -> Displacement.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Subtracts two Z-displacements.
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Displacement.Z<Space>.Value<Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) -> Displacement.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Add and assign X-displacements.
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Displacement.X<Space>.Value<Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract and assign X-displacements.
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Displacement.X<Space>.Value<Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

/// Add and assign Y-displacements.
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Displacement.Y<Space>.Value<Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract and assign Y-displacements.
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Displacement.Y<Space>.Value<Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

/// Add and assign Z-displacements.
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Displacement.Z<Space>.Value<Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract and assign Z-displacements.
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Displacement.Z<Space>.Value<Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

// MARK: - Magnitude Same-Type Arithmetic

/// Adds two magnitudes.
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Magnitude<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Magnitude<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Subtracts two magnitudes.
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Magnitude<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Magnitude<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Add and assign magnitudes.
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Magnitude<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract and assign magnitudes.
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Magnitude<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

// MARK: - Extent Same-Type Arithmetic

/// Adds two X-extents (widths).
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Extent.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Subtracts two X-extents (widths).
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Extent.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Adds two Y-extents (heights).
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Extent.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Subtracts two Y-extents (heights).
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Extent.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Adds two Z-extents (depths).
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Extent.Z<Space>.Value<Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) -> Extent.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Subtracts two Z-extents (depths).
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Extent.Z<Space>.Value<Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) -> Extent.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Add and assign X-extents.
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Extent.X<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract and assign X-extents.
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Extent.X<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

/// Add and assign Y-extents.
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Extent.Y<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract and assign Y-extents.
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Extent.Y<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

/// Add and assign Z-extents.
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Extent.Z<Space>.Value<Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract and assign Z-extents.
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Extent.Z<Space>.Value<Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

// MARK: - Cross-Axis Extent Comparison

// Comparing extents across axes is geometrically meaningful (e.g., "is width > height?").
// Both represent lengths in the same space, just along different axes.

/// Compares X-extent to Y-extent.
@inlinable
public func < <Space, Scalar: Comparable>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Bool { lhs.rawValue < rhs.rawValue }

/// Compares Y-extent to X-extent.
@inlinable
public func < <Space, Scalar: Comparable>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Bool { lhs.rawValue < rhs.rawValue }

/// Compares X-extent to Y-extent.
@inlinable
public func <= <Space, Scalar: Comparable>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Bool { lhs.rawValue <= rhs.rawValue }

/// Compares Y-extent to X-extent.
@inlinable
public func <= <Space, Scalar: Comparable>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Bool { lhs.rawValue <= rhs.rawValue }

/// Compares X-extent to Y-extent.
@inlinable
public func > <Space, Scalar: Comparable>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Bool { lhs.rawValue > rhs.rawValue }

/// Compares Y-extent to X-extent.
@inlinable
public func > <Space, Scalar: Comparable>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Bool { lhs.rawValue > rhs.rawValue }

/// Compares X-extent to Y-extent.
@inlinable
public func >= <Space, Scalar: Comparable>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Bool { lhs.rawValue >= rhs.rawValue }

/// Compares Y-extent to X-extent.
@inlinable
public func >= <Space, Scalar: Comparable>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Bool { lhs.rawValue >= rhs.rawValue }

/// Compares X-extent to Y-extent for equality.
@inlinable
public func == <Space, Scalar: Equatable>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Bool { lhs.rawValue == rhs.rawValue }

/// Compares Y-extent to X-extent for equality.
@inlinable
public func == <Space, Scalar: Equatable>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Bool { lhs.rawValue == rhs.rawValue }

// MARK: - Angle Same-Type Arithmetic

/// Adds two radian angles.
@inlinable
public func + <Scalar: AdditiveArithmetic>(
    lhs: Angle.Radian.Value<Scalar>,
    rhs: Angle.Radian.Value<Scalar>
) -> Angle.Radian.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Subtracts two radian angles.
@inlinable
public func - <Scalar: AdditiveArithmetic>(
    lhs: Angle.Radian.Value<Scalar>,
    rhs: Angle.Radian.Value<Scalar>
) -> Angle.Radian.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Adds two degree angles.
@inlinable
public func + <Scalar: AdditiveArithmetic>(
    lhs: Angle.Degree.Value<Scalar>,
    rhs: Angle.Degree.Value<Scalar>
) -> Angle.Degree.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Subtracts two degree angles.
@inlinable
public func - <Scalar: AdditiveArithmetic>(
    lhs: Angle.Degree.Value<Scalar>,
    rhs: Angle.Degree.Value<Scalar>
) -> Angle.Degree.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

// MARK: - Displacement Multiplication → Area

// Displacement products return typed Area (Measure<2>).
// Same-axis: Dx × Dx = Area (length squared)
// Cross-axis: Dx × Dy = Area (length × length)

/// Multiplies X-displacement by X-displacement, returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Displacement.X<Space>.Value<Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies Y-displacement by Y-displacement, returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Displacement.Y<Space>.Value<Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies Z-displacement by Z-displacement, returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Displacement.Z<Space>.Value<Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies X-displacement by Y-displacement, returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Displacement.X<Space>.Value<Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies Y-displacement by X-displacement, returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Displacement.Y<Space>.Value<Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies X-displacement by Z-displacement, returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Displacement.X<Space>.Value<Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies Z-displacement by X-displacement, returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Displacement.Z<Space>.Value<Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies Y-displacement by Z-displacement, returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Displacement.Y<Space>.Value<Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies Z-displacement by Y-displacement, returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Displacement.Z<Space>.Value<Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

// MARK: - Extent Multiplication → Area

// Extent products return typed Area (Measure<2>).
// Same-axis: Width × Width = Area (length squared)
// Cross-axis: Width × Height = Area (length × length)

/// Multiplies X-extent (width) by X-extent (width), returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies Y-extent (height) by Y-extent (height), returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies Z-extent (depth) by Z-extent (depth), returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Extent.Z<Space>.Value<Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies X-extent (width) by Y-extent (height), returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies Y-extent (height) by X-extent (width), returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies X-extent (width) by Z-extent (depth), returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies Z-extent (depth) by X-extent (width), returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Extent.Z<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies Y-extent (height) by Z-extent (depth), returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies Z-extent (depth) by Y-extent (height), returning area.
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Extent.Z<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

// MARK: - Measure Multiplication

/// Multiplies two lengths (Measure<1>), returning area (Measure<2>).
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Measure<1, Space>.Value<Scalar>,
    rhs: Measure<1, Space>.Value<Scalar>
) -> Measure<2, Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies length by area, returning volume (Measure<3>).
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Measure<1, Space>.Value<Scalar>,
    rhs: Measure<2, Space>.Value<Scalar>
) -> Measure<3, Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

/// Multiplies area by length, returning volume (Measure<3>).
@inlinable
public func * <Space, Scalar: Swift.Numeric>(
    lhs: Measure<2, Space>.Value<Scalar>,
    rhs: Measure<1, Space>.Value<Scalar>
) -> Measure<3, Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.rawValue)
}

// MARK: - Area Arithmetic

/// Adds two areas.
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Area<Space>.Value<Scalar>,
    rhs: Area<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Subtracts two areas.
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Area<Space>.Value<Scalar>,
    rhs: Area<Space>.Value<Scalar>
) -> Area<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

// MARK: - Measure × Scale (Magnitude, Area, Volume)

/// Scales a measure by a scale factor.
@inlinable
public func * <let N: Int, Space, Scalar: FloatingPoint>(
    lhs: Measure<N, Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Measure<N, Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.value)
}

/// Scales a measure by a scale factor (commutative).
@inlinable
public func * <let N: Int, Space, Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Measure<N, Space>.Value<Scalar>
) -> Measure<N, Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.value * rhs.rawValue)
}

/// Divides a measure by a scale factor.
@inlinable
public func / <let N: Int, Space, Scalar: FloatingPoint>(
    lhs: Measure<N, Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Measure<N, Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue / rhs.value)
}

// MARK: - Area / Magnitude = Magnitude (L² / L = L)

/// Divides area by magnitude, returning magnitude.
@inlinable
public func / <Space, Scalar: FloatingPoint>(
    lhs: Area<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Magnitude<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue / rhs.rawValue)
}

/// Divides area by area, returning a dimensionless scale factor.
/// Area / Area = dimensionless ratio (L² / L² = 1)
@inlinable
public func / <Space, Scalar: FloatingPoint>(
    lhs: Area<Space>.Value<Scalar>,
    rhs: Area<Space>.Value<Scalar>
) -> Scale<1, Scalar> {
    Scale(lhs.rawValue / rhs.rawValue)
}

// MARK: - Displacement Division (ratio)

/// Divides two X-displacements, returning a dimensionless scale factor.
@inlinable
public func / <Space, Scalar: FloatingPoint>(
    lhs: Displacement.X<Space>.Value<Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) -> Scale<1, Scalar> {
    Scale(lhs.rawValue / rhs.rawValue)
}

/// Divides two Y-displacements, returning a dimensionless scale factor.
@inlinable
public func / <Space, Scalar: FloatingPoint>(
    lhs: Displacement.Y<Space>.Value<Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) -> Scale<1, Scalar> {
    Scale(lhs.rawValue / rhs.rawValue)
}

/// Divides two Z-displacements, returning a dimensionless scale factor.
@inlinable
public func / <Space, Scalar: FloatingPoint>(
    lhs: Displacement.Z<Space>.Value<Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) -> Scale<1, Scalar> {
    Scale(lhs.rawValue / rhs.rawValue)
}

// MARK: - Mixed Coordinate/Displacement Arithmetic

// Affine geometry: Point + Vector = Point, Point - Point = Vector, Point - Vector = Point
// These are free functions generic over Space to work with any coordinate system.

// MARK: X Axis

/// Adds a displacement to an X coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.X<Space>.Value<Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds a displacement to an X coordinate with quantization (for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.X<Space>.Value<Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

/// Subtracts two X coordinates, returning a displacement.
@_disfavoredOverload
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.X<Space>.Value<Scalar>,
    rhs: Coordinate.X<Space>.Value<Scalar>
) -> Displacement.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Subtracts two X coordinates with quantization (for floating-point types).
@inlinable
public func - <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.X<Space>.Value<Scalar>,
    rhs: Coordinate.X<Space>.Value<Scalar>
) -> Displacement.X<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue - rhs.rawValue, in: Space.self)
}

/// Subtracts a displacement from an X coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.X<Space>.Value<Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Subtracts a displacement from an X coordinate with quantization (for floating-point types).
@inlinable
public func - <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.X<Space>.Value<Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue - rhs.rawValue, in: Space.self)
}

/// Adds an X coordinate to a displacement, returning a coordinate (commutative).
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Displacement.X<Space>.Value<Scalar>,
    rhs: Coordinate.X<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds an X coordinate to a displacement with quantization (commutative, for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Displacement.X<Space>.Value<Scalar>,
    rhs: Coordinate.X<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

// MARK: Y Axis

/// Adds a displacement to a Y coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.Y<Space>.Value<Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds a displacement to a Y coordinate with quantization (for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.Y<Space>.Value<Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

/// Subtracts two Y coordinates, returning a displacement.
@_disfavoredOverload
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.Y<Space>.Value<Scalar>,
    rhs: Coordinate.Y<Space>.Value<Scalar>
) -> Displacement.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Subtracts two Y coordinates with quantization (for floating-point types).
@inlinable
public func - <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.Y<Space>.Value<Scalar>,
    rhs: Coordinate.Y<Space>.Value<Scalar>
) -> Displacement.Y<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue - rhs.rawValue, in: Space.self)
}

/// Subtracts a displacement from a Y coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.Y<Space>.Value<Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Subtracts a displacement from a Y coordinate with quantization (for floating-point types).
@inlinable
public func - <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.Y<Space>.Value<Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue - rhs.rawValue, in: Space.self)
}

/// Adds a Y coordinate to a displacement, returning a coordinate (commutative).
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Displacement.Y<Space>.Value<Scalar>,
    rhs: Coordinate.Y<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds a Y coordinate to a displacement with quantization (commutative, for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Displacement.Y<Space>.Value<Scalar>,
    rhs: Coordinate.Y<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

// MARK: Z Axis

/// Adds a displacement to a Z coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.Z<Space>.Value<Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds a displacement to a Z coordinate with quantization (for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.Z<Space>.Value<Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

/// Subtracts two Z coordinates, returning a displacement.
@_disfavoredOverload
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.Z<Space>.Value<Scalar>,
    rhs: Coordinate.Z<Space>.Value<Scalar>
) -> Displacement.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Subtracts two Z coordinates with quantization (for floating-point types).
@inlinable
public func - <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.Z<Space>.Value<Scalar>,
    rhs: Coordinate.Z<Space>.Value<Scalar>
) -> Displacement.Z<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue - rhs.rawValue, in: Space.self)
}

/// Subtracts a displacement from a Z coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.Z<Space>.Value<Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Subtracts a displacement from a Z coordinate with quantization (for floating-point types).
@inlinable
public func - <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.Z<Space>.Value<Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue - rhs.rawValue, in: Space.self)
}

/// Adds a Z coordinate to a displacement, returning a coordinate (commutative).
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Displacement.Z<Space>.Value<Scalar>,
    rhs: Coordinate.Z<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds a Z coordinate to a displacement with quantization (commutative, for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Displacement.Z<Space>.Value<Scalar>,
    rhs: Coordinate.Z<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

// MARK: Coordinate/Displacement Compound Assignment

/// Add-assign a displacement to an X coordinate.
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.X<Space>.Value<Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract-assign a displacement from an X coordinate.
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.X<Space>.Value<Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

/// Add-assign a displacement to a Y coordinate.
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.Y<Space>.Value<Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract-assign a displacement from a Y coordinate.
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.Y<Space>.Value<Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

/// Add-assign a displacement to a Z coordinate.
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.Z<Space>.Value<Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract-assign a displacement from a Z coordinate.
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.Z<Space>.Value<Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

// MARK: - Magnitude/Coordinate Arithmetic

// Magnitude (non-directional distance) can be added/subtracted from coordinates.
// This enables `center.x - radius` patterns in geometry code.
// The magnitude is interpreted as distance along the axis of the coordinate.

/// Adds a magnitude to an X coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.X<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds a magnitude to an X coordinate with quantization (for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.X<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

/// Subtracts a magnitude from an X coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.X<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Subtracts a magnitude from an X coordinate with quantization (for floating-point types).
@inlinable
public func - <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.X<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue - rhs.rawValue, in: Space.self)
}

/// Adds an X coordinate to a magnitude, returning a coordinate (commutative).
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Magnitude<Space>.Value<Scalar>,
    rhs: Coordinate.X<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds an X coordinate to a magnitude with quantization (commutative, for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Magnitude<Space>.Value<Scalar>,
    rhs: Coordinate.X<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

/// Adds a magnitude to a Y coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.Y<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds a magnitude to a Y coordinate with quantization (for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.Y<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

/// Subtracts a magnitude from a Y coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.Y<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Subtracts a magnitude from a Y coordinate with quantization (for floating-point types).
@inlinable
public func - <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.Y<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue - rhs.rawValue, in: Space.self)
}

/// Adds a Y coordinate to a magnitude, returning a coordinate (commutative).
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Magnitude<Space>.Value<Scalar>,
    rhs: Coordinate.Y<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds a Y coordinate to a magnitude with quantization (commutative, for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Magnitude<Space>.Value<Scalar>,
    rhs: Coordinate.Y<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

/// Adds a magnitude to a Z coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.Z<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds a magnitude to a Z coordinate with quantization (for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.Z<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

/// Subtracts a magnitude from a Z coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.Z<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Subtracts a magnitude from a Z coordinate with quantization (for floating-point types).
@inlinable
public func - <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.Z<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue - rhs.rawValue, in: Space.self)
}

/// Adds a Z coordinate to a magnitude, returning a coordinate (commutative).
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Magnitude<Space>.Value<Scalar>,
    rhs: Coordinate.Z<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds a Z coordinate to a magnitude with quantization (commutative, for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Magnitude<Space>.Value<Scalar>,
    rhs: Coordinate.Z<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

// MARK: Magnitude/Coordinate Compound Assignment

/// Add-assign a magnitude to an X coordinate.
@_disfavoredOverload
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.X<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract-assign a magnitude from an X coordinate.
@_disfavoredOverload
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.X<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

/// Add-assign a magnitude to a Y coordinate.
@_disfavoredOverload
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.Y<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract-assign a magnitude from a Y coordinate.
@_disfavoredOverload
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.Y<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

/// Add-assign a magnitude to a Z coordinate.
@_disfavoredOverload
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.Z<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract-assign a magnitude from a Z coordinate.
@_disfavoredOverload
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.Z<Space>.Value<Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

// MARK: - Extent/Coordinate Arithmetic

// Extent (width/height/depth) can be added/subtracted from coordinates.
// This enables `center.x + width` patterns in geometry code.
// The extent is interpreted as offset along the axis of the coordinate.

/// Adds an X extent (width) to an X coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.X<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds an X extent (width) to an X coordinate with quantization (for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.X<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

/// Subtracts an X extent (width) from an X coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.X<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Subtracts an X extent (width) from an X coordinate with quantization (for floating-point types).
@inlinable
public func - <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.X<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue - rhs.rawValue, in: Space.self)
}

/// Adds an X coordinate to an X extent, returning a coordinate (commutative).
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Coordinate.X<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds an X coordinate to an X extent with quantization (commutative, for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Coordinate.X<Space>.Value<Scalar>
) -> Coordinate.X<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

/// Adds a Y extent (height) to a Y coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.Y<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds a Y extent (height) to a Y coordinate with quantization (for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.Y<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

/// Subtracts a Y extent (height) from a Y coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.Y<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Subtracts a Y extent (height) from a Y coordinate with quantization (for floating-point types).
@inlinable
public func - <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.Y<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue - rhs.rawValue, in: Space.self)
}

/// Adds a Y coordinate to a Y extent, returning a coordinate (commutative).
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Coordinate.Y<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds a Y coordinate to a Y extent with quantization (commutative, for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Coordinate.Y<Space>.Value<Scalar>
) -> Coordinate.Y<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

/// Adds a Z extent (depth) to a Z coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.Z<Space>.Value<Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds a Z extent (depth) to a Z coordinate with quantization (for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.Z<Space>.Value<Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

/// Subtracts a Z extent (depth) from a Z coordinate, returning a coordinate.
@_disfavoredOverload
@inlinable
public func - <Space, Scalar: AdditiveArithmetic>(
    lhs: Coordinate.Z<Space>.Value<Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue - rhs.rawValue)
}

/// Subtracts a Z extent (depth) from a Z coordinate with quantization (for floating-point types).
@inlinable
public func - <Space, Scalar: BinaryFloatingPoint>(
    lhs: Coordinate.Z<Space>.Value<Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue - rhs.rawValue, in: Space.self)
}

/// Adds a Z coordinate to a Z extent, returning a coordinate (commutative).
@_disfavoredOverload
@inlinable
public func + <Space, Scalar: AdditiveArithmetic>(
    lhs: Extent.Z<Space>.Value<Scalar>,
    rhs: Coordinate.Z<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue + rhs.rawValue)
}

/// Adds a Z coordinate to a Z extent with quantization (commutative, for floating-point types).
@inlinable
public func + <Space, Scalar: BinaryFloatingPoint>(
    lhs: Extent.Z<Space>.Value<Scalar>,
    rhs: Coordinate.Z<Space>.Value<Scalar>
) -> Coordinate.Z<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue + rhs.rawValue, in: Space.self)
}

// MARK: Extent/Coordinate Compound Assignment

/// Add-assign an X extent to an X coordinate.
@_disfavoredOverload
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.X<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract-assign an X extent from an X coordinate.
@_disfavoredOverload
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.X<Space>.Value<Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

/// Add-assign a Y extent to a Y coordinate.
@_disfavoredOverload
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.Y<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract-assign a Y extent from a Y coordinate.
@_disfavoredOverload
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.Y<Space>.Value<Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

/// Add-assign a Z extent to a Z coordinate.
@_disfavoredOverload
@inlinable
public func += <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.Z<Space>.Value<Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) {
    lhs = lhs + rhs
}

/// Subtract-assign a Z extent from a Z coordinate.
@_disfavoredOverload
@inlinable
public func -= <Space, Scalar: AdditiveArithmetic>(
    lhs: inout Coordinate.Z<Space>.Value<Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) {
    lhs = lhs - rhs
}

// MARK: - Tagged × Scale<1> (Uniform Scaling)

// Displacement, Extent, and Magnitude can be scaled by dimensionless scale factors.
// Coordinates (positions) cannot be scaled - only vectors can.
// Using Scale<1, Scalar> makes the scaling operation explicit in the type system.

// MARK: Displacement.X × Scale

/// Scales an X displacement by a uniform scale factor.
@_disfavoredOverload
@inlinable
public func * <Space, Scalar: FloatingPoint>(
    lhs: Displacement.X<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Displacement.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.value)
}

/// Scales an X displacement by a uniform scale factor with quantization.
@inlinable
public func * <Space, Scalar: BinaryFloatingPoint>(
    lhs: Displacement.X<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Displacement.X<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue * rhs.value, in: Space.self)
}

/// Scales an X displacement by a uniform scale factor (commutative).
@_disfavoredOverload
@inlinable
public func * <Space, Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) -> Displacement.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.value * rhs.rawValue)
}

/// Scales an X displacement by a uniform scale factor with quantization (commutative).
@inlinable
public func * <Space, Scalar: BinaryFloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Displacement.X<Space>.Value<Scalar>
) -> Displacement.X<Space>.Value<Scalar> {
    ._quantize(lhs.value * rhs.rawValue, in: Space.self)
}

/// Divides an X displacement by a uniform scale factor.
@_disfavoredOverload
@inlinable
public func / <Space, Scalar: FloatingPoint>(
    lhs: Displacement.X<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Displacement.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue / rhs.value)
}

/// Divides an X displacement by a uniform scale factor with quantization.
@inlinable
public func / <Space, Scalar: BinaryFloatingPoint>(
    lhs: Displacement.X<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Displacement.X<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue / rhs.value, in: Space.self)
}

// MARK: Displacement.Y × Scale

/// Scales a Y displacement by a uniform scale factor.
@_disfavoredOverload
@inlinable
public func * <Space, Scalar: FloatingPoint>(
    lhs: Displacement.Y<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Displacement.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.value)
}

/// Scales a Y displacement by a uniform scale factor with quantization.
@inlinable
public func * <Space, Scalar: BinaryFloatingPoint>(
    lhs: Displacement.Y<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Displacement.Y<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue * rhs.value, in: Space.self)
}

/// Scales a Y displacement by a uniform scale factor (commutative).
@_disfavoredOverload
@inlinable
public func * <Space, Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) -> Displacement.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.value * rhs.rawValue)
}

/// Scales a Y displacement by a uniform scale factor with quantization (commutative).
@inlinable
public func * <Space, Scalar: BinaryFloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Displacement.Y<Space>.Value<Scalar>
) -> Displacement.Y<Space>.Value<Scalar> {
    ._quantize(lhs.value * rhs.rawValue, in: Space.self)
}

/// Divides a Y displacement by a uniform scale factor.
@_disfavoredOverload
@inlinable
public func / <Space, Scalar: FloatingPoint>(
    lhs: Displacement.Y<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Displacement.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue / rhs.value)
}

/// Divides a Y displacement by a uniform scale factor with quantization.
@inlinable
public func / <Space, Scalar: BinaryFloatingPoint>(
    lhs: Displacement.Y<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Displacement.Y<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue / rhs.value, in: Space.self)
}

// MARK: Displacement.Z × Scale

/// Scales a Z displacement by a uniform scale factor.
@_disfavoredOverload
@inlinable
public func * <Space, Scalar: FloatingPoint>(
    lhs: Displacement.Z<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Displacement.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.value)
}

/// Scales a Z displacement by a uniform scale factor with quantization.
@inlinable
public func * <Space, Scalar: BinaryFloatingPoint>(
    lhs: Displacement.Z<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Displacement.Z<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue * rhs.value, in: Space.self)
}

/// Scales a Z displacement by a uniform scale factor (commutative).
@_disfavoredOverload
@inlinable
public func * <Space, Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) -> Displacement.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.value * rhs.rawValue)
}

/// Scales a Z displacement by a uniform scale factor with quantization (commutative).
@inlinable
public func * <Space, Scalar: BinaryFloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Displacement.Z<Space>.Value<Scalar>
) -> Displacement.Z<Space>.Value<Scalar> {
    ._quantize(lhs.value * rhs.rawValue, in: Space.self)
}

/// Divides a Z displacement by a uniform scale factor.
@_disfavoredOverload
@inlinable
public func / <Space, Scalar: FloatingPoint>(
    lhs: Displacement.Z<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Displacement.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue / rhs.value)
}

/// Divides a Z displacement by a uniform scale factor with quantization.
@inlinable
public func / <Space, Scalar: BinaryFloatingPoint>(
    lhs: Displacement.Z<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Displacement.Z<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue / rhs.value, in: Space.self)
}

// MARK: Extent.X × Scale

/// Scales an X extent (width) by a uniform scale factor.
@_disfavoredOverload
@inlinable
public func * <Space, Scalar: FloatingPoint>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Extent.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.value)
}

/// Scales an X extent (width) by a uniform scale factor with quantization.
@inlinable
public func * <Space, Scalar: BinaryFloatingPoint>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Extent.X<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue * rhs.value, in: Space.self)
}

/// Scales an X extent by a uniform scale factor (commutative).
@_disfavoredOverload
@inlinable
public func * <Space, Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Extent.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.value * rhs.rawValue)
}

/// Scales an X extent by a uniform scale factor with quantization (commutative).
@inlinable
public func * <Space, Scalar: BinaryFloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Extent.X<Space>.Value<Scalar>
) -> Extent.X<Space>.Value<Scalar> {
    ._quantize(lhs.value * rhs.rawValue, in: Space.self)
}

/// Divides an X extent by a uniform scale factor.
@_disfavoredOverload
@inlinable
public func / <Space, Scalar: FloatingPoint>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Extent.X<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue / rhs.value)
}

/// Divides an X extent by a uniform scale factor with quantization.
@inlinable
public func / <Space, Scalar: BinaryFloatingPoint>(
    lhs: Extent.X<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Extent.X<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue / rhs.value, in: Space.self)
}

// MARK: Extent.Y × Scale

/// Scales a Y extent (height) by a uniform scale factor.
@_disfavoredOverload
@inlinable
public func * <Space, Scalar: FloatingPoint>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Extent.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.value)
}

/// Scales a Y extent (height) by a uniform scale factor with quantization.
@inlinable
public func * <Space, Scalar: BinaryFloatingPoint>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Extent.Y<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue * rhs.value, in: Space.self)
}

/// Scales a Y extent by a uniform scale factor (commutative).
@_disfavoredOverload
@inlinable
public func * <Space, Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Extent.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.value * rhs.rawValue)
}

/// Scales a Y extent by a uniform scale factor with quantization (commutative).
@inlinable
public func * <Space, Scalar: BinaryFloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Extent.Y<Space>.Value<Scalar>
) -> Extent.Y<Space>.Value<Scalar> {
    ._quantize(lhs.value * rhs.rawValue, in: Space.self)
}

/// Divides a Y extent by a uniform scale factor.
@_disfavoredOverload
@inlinable
public func / <Space, Scalar: FloatingPoint>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Extent.Y<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue / rhs.value)
}

/// Divides a Y extent by a uniform scale factor with quantization.
@inlinable
public func / <Space, Scalar: BinaryFloatingPoint>(
    lhs: Extent.Y<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Extent.Y<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue / rhs.value, in: Space.self)
}

// MARK: Extent.Z × Scale

/// Scales a Z extent (depth) by a uniform scale factor.
@_disfavoredOverload
@inlinable
public func * <Space, Scalar: FloatingPoint>(
    lhs: Extent.Z<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Extent.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.value)
}

/// Scales a Z extent (depth) by a uniform scale factor with quantization.
@inlinable
public func * <Space, Scalar: BinaryFloatingPoint>(
    lhs: Extent.Z<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Extent.Z<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue * rhs.value, in: Space.self)
}

/// Scales a Z extent by a uniform scale factor (commutative).
@_disfavoredOverload
@inlinable
public func * <Space, Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) -> Extent.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.value * rhs.rawValue)
}

/// Scales a Z extent by a uniform scale factor with quantization (commutative).
@inlinable
public func * <Space, Scalar: BinaryFloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Extent.Z<Space>.Value<Scalar>
) -> Extent.Z<Space>.Value<Scalar> {
    ._quantize(lhs.value * rhs.rawValue, in: Space.self)
}

/// Divides a Z extent by a uniform scale factor.
@_disfavoredOverload
@inlinable
public func / <Space, Scalar: FloatingPoint>(
    lhs: Extent.Z<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Extent.Z<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue / rhs.value)
}

/// Divides a Z extent by a uniform scale factor with quantization.
@inlinable
public func / <Space, Scalar: BinaryFloatingPoint>(
    lhs: Extent.Z<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Extent.Z<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue / rhs.value, in: Space.self)
}

// MARK: Magnitude × Scale

/// Scales a magnitude by a uniform scale factor.
@_disfavoredOverload
@inlinable
public func * <Space, Scalar: FloatingPoint>(
    lhs: Magnitude<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Magnitude<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue * rhs.value)
}

/// Scales a magnitude by a uniform scale factor with quantization.
@inlinable
public func * <Space, Scalar: BinaryFloatingPoint>(
    lhs: Magnitude<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Magnitude<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue * rhs.value, in: Space.self)
}

/// Scales a magnitude by a uniform scale factor (commutative).
@_disfavoredOverload
@inlinable
public func * <Space, Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Magnitude<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.value * rhs.rawValue)
}

/// Scales a magnitude by a uniform scale factor with quantization (commutative).
@inlinable
public func * <Space, Scalar: BinaryFloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Magnitude<Space>.Value<Scalar>
) -> Magnitude<Space>.Value<Scalar> {
    ._quantize(lhs.value * rhs.rawValue, in: Space.self)
}

/// Divides a magnitude by a uniform scale factor.
@_disfavoredOverload
@inlinable
public func / <Space, Scalar: FloatingPoint>(
    lhs: Magnitude<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Magnitude<Space>.Value<Scalar> {
    Tagged(__unchecked: (), lhs.rawValue / rhs.value)
}

/// Divides a magnitude by a uniform scale factor with quantization.
@inlinable
public func / <Space, Scalar: BinaryFloatingPoint>(
    lhs: Magnitude<Space>.Value<Scalar>,
    rhs: Scale<1, Scalar>
) -> Magnitude<Space>.Value<Scalar> {
    ._quantize(lhs.rawValue / rhs.value, in: Space.self)
}

// MARK: - Scale × Scale

/// Multiplies two 1D scale factors.
///
/// Enables `cos * cos → cosSq` for use in dimensional formulas.
@inlinable
public func * <Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Scale<1, Scalar>
) -> Scale<1, Scalar> {
    Scale(lhs.value * rhs.value)
}

/// Divides two 1D scale factors.
@inlinable
public func / <Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Scale<1, Scalar>
) -> Scale<1, Scalar> {
    Scale(lhs.value / rhs.value)
}

/// Adds two 1D scale factors.
@inlinable
public func + <Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Scale<1, Scalar>
) -> Scale<1, Scalar> {
    Scale(lhs.value + rhs.value)
}

/// Subtracts two 1D scale factors.
@inlinable
public func - <Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Scale<1, Scalar>
) -> Scale<1, Scalar> {
    Scale(lhs.value - rhs.value)
}

/// Square root of a 1D scale factor.
///
/// Enables `sqrt(Area / Area)` for eccentricity calculations.
@inlinable
public func sqrt<Scalar: FloatingPoint>(
    _ value: Scale<1, Scalar>
) -> Scale<1, Scalar> {
    Scale(value.value.squareRoot())
}

// MARK: - Scale Negation

/// Negates a 1D scale factor.
///
/// Enables `-scale` for symmetry with other Tagged types.
@inlinable
public prefix func - <Scalar: SignedNumeric & FloatingPoint>(
    value: Scale<1, Scalar>
) -> Scale<1, Scalar> {
    Scale(-value.value)
}

// MARK: - Scale Absolute Value

/// Absolute value of a 1D scale factor.
///
/// Enables `abs(eccentricity)` without extracting `.value`.
@inlinable
public func abs<Scalar: FloatingPoint & Comparable>(
    _ value: Scale<1, Scalar>
) -> Scale<1, Scalar> {
    value.value < 0 ? Scale(-value.value) : value
}
