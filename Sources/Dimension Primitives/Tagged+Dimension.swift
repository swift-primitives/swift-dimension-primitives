// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-primitives open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

// Numeric and algebraic extensions for Tagged types used in dimensional analysis.

import Identity_Primitives

// MARK: - FloatingPoint Properties

extension Tagged where RawValue: FloatingPoint {
    /// The unit value in the last place of 1.0.
    @inlinable
    public static var ulpOfOne: Self { Self(RawValue.ulpOfOne) }

    /// Positive infinity.
    @inlinable
    public static var infinity: Self { Self(RawValue.infinity) }

    /// A quiet NaN ("not a number").
    @inlinable
    public static var nan: Self { Self(RawValue.nan) }

    /// A Boolean value indicating whether this instance is NaN.
    @inlinable
    public var isNaN: Bool { rawValue.isNaN }

    /// A Boolean value indicating whether this instance is infinite.
    @inlinable
    public var isInfinite: Bool { rawValue.isInfinite }

    /// A Boolean value indicating whether this instance is finite.
    @inlinable
    public var isFinite: Bool { rawValue.isFinite }

    /// A Boolean value indicating whether this instance is zero.
    @inlinable
    public var isZero: Bool { rawValue.isZero }

    /// The sign of this value.
    @inlinable
    public var sign: FloatingPointSign { rawValue.sign }
}

// MARK: - Square Root for Measures

/// Square root of area returns magnitude (Length).
///
/// Dimensionally: √(L²) = L
@inlinable
public func sqrt<Space, Scalar: FloatingPoint>(
    _ value: Tagged<Area<Space>, Scalar>
) -> Tagged<Magnitude<Space>, Scalar> {
    Tagged(value.rawValue.squareRoot())
}

/// Square root of volume returns area.
///
/// Dimensionally: √(L³) = L^1.5 (not exact, but useful for certain calculations)
@inlinable
public func sqrt<Space, Scalar: FloatingPoint>(
    _ value: Tagged<Volume<Space>, Scalar>
) -> Tagged<Area<Space>, Scalar> {
    Tagged(value.rawValue.squareRoot())
}

extension Tagged where RawValue: FloatingPoint {
    /// The square root of this value.
    @inlinable
    public func squareRoot() -> Self {
        Self(rawValue.squareRoot())
    }
}

// MARK: - Strideable

extension Tagged: @retroactive Strideable where RawValue: Strideable {
    public typealias Stride = RawValue.Stride

    @inlinable
    public func distance(to other: Self) -> Stride {
        rawValue.distance(to: other.rawValue)
    }

    @inlinable
    public func advanced(by n: Stride) -> Self {
        Self(rawValue.advanced(by: n))
    }
}

extension Tagged where RawValue: BinaryFloatingPoint {
    public init<I: BinaryInteger>(_ value: I) {
        self.init(RawValue(value))
    }
}

// MARK: - Magnitude / Absolute Value

extension Tagged where RawValue: SignedNumeric, RawValue.Magnitude == RawValue {
    /// The magnitude (absolute value) of this tagged value.
    ///
    /// For signed numeric values, this returns the absolute value while preserving the tag type.
    /// Mathematically: `|x|` where the result has the same unit/type as the input.
    @inlinable
    public var magnitude: Self {
        Self(rawValue.magnitude)
    }
}

// MARK: - BinaryFloatingPoint Properties

extension Tagged where RawValue: BinaryFloatingPoint {
    /// The mathematical constant pi (π).
    @inlinable
    public static var pi: Self { Self(RawValue.pi) }
}
