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

import Tagged_Primitives

// MARK: - FloatingPoint Properties

extension Tagged where Underlying: FloatingPoint {
    /// The unit value in the last place of 1.0.
    @inlinable
    public static var ulpOfOne: Self { Self(_unchecked: Underlying.ulpOfOne) }

    /// Positive infinity.
    @inlinable
    public static var infinity: Self { Self(_unchecked: Underlying.infinity) }

    /// A quiet NaN ("not a number").
    @inlinable
    public static var nan: Self { Self(_unchecked: Underlying.nan) }

    /// A Boolean value indicating whether this instance is NaN.
    @inlinable
    public var isNaN: Bool { underlying.isNaN }

    /// A Boolean value indicating whether this instance is infinite.
    @inlinable
    public var isInfinite: Bool { underlying.isInfinite }

    /// A Boolean value indicating whether this instance is finite.
    @inlinable
    public var isFinite: Bool { underlying.isFinite }

    /// A Boolean value indicating whether this instance is zero.
    @inlinable
    public var isZero: Bool { underlying.isZero }

    /// The sign of this value.
    @inlinable
    public var sign: FloatingPointSign { underlying.sign }
}

// MARK: - Square Root for Measures

/// Square root of area returns magnitude (Length).
///
/// Dimensionally: √(L²) = L
@inlinable
public func sqrt<Space, Scalar: FloatingPoint>(
    _ value: Tagged<Area<Space>, Scalar>
) -> Tagged<Magnitude<Space>, Scalar> {
    Tagged(_unchecked: value.underlying.squareRoot())
}

/// Square root of volume returns area.
///
/// Dimensionally: √(L³) = L^1.5 (not exact, but useful for certain calculations)
@inlinable
public func sqrt<Space, Scalar: FloatingPoint>(
    _ value: Tagged<Volume<Space>, Scalar>
) -> Tagged<Area<Space>, Scalar> {
    Tagged(_unchecked: value.underlying.squareRoot())
}

extension Tagged where Underlying: FloatingPoint {
    /// The square root of this value.
    @inlinable
    public func squareRoot() -> Self {
        Self(_unchecked: underlying.squareRoot())
    }
}

extension Tagged where Underlying: BinaryFloatingPoint {
    /// Creates a tagged value by converting from a binary integer.
    public init<I: BinaryInteger>(_ value: I) {
        self.init(_unchecked: Underlying(value))
    }
}

// MARK: - Spatial Init

extension Tagged where Tag: Spatial {
    /// Creates a tagged spatial value by wrapping a raw value.
    ///
    /// For non-quantized coordinate spaces, this is a direct wrap.
    /// When `Underlying` is `BinaryFloatingPoint`, the more specific
    /// quantization-aware overload is selected instead.
    @_disfavoredOverload
    @inlinable
    public init(_ value: Underlying) {
        self.init(_unchecked: value)
    }
}

extension Tagged where Tag: Spatial, Underlying: BinaryFloatingPoint {
    /// Creates a tagged spatial value, quantizing to the grid when the
    /// coordinate space conforms to `Numeric.Quantized`.
    @inlinable
    public init(_ value: Underlying) {
        self = ._quantize(value, in: Tag.Space.self)
    }
}

// MARK: - Magnitude / Absolute Value

extension Tagged where Underlying: SignedNumeric, Underlying.Magnitude == Underlying {
    /// The magnitude (absolute value) of this tagged value.
    ///
    /// For signed numeric values, this returns the absolute value while preserving the tag type.
    /// Mathematically: `|x|` where the result has the same unit/type as the input.
    @inlinable
    public var magnitude: Self {
        Self(_unchecked: underlying.magnitude)
    }
}

// MARK: - BinaryFloatingPoint Properties

extension Tagged where Underlying: BinaryFloatingPoint {
    /// The mathematical constant pi (π).
    @inlinable
    public static var pi: Self { Self(_unchecked: Underlying.pi) }
}
