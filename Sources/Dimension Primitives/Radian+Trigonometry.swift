// Radian+Trigonometry.swift
// Trigonometric functions and constants for Radian.

public import Real_Primitives

// MARK: - Numeric.Transcendental

extension Tagged where Tag == Angle.Radian, RawValue: BinaryFloatingPoint & Numeric.Transcendental {
    /// Sine of an angle.
    @inlinable
    public static func sin(of angle: Self) -> Scale<1, RawValue> {
        Scale(RawValue._sin(angle.rawValue))
    }

    /// Cosine of an angle.
    @inlinable
    public static func cos(of angle: Self) -> Scale<1, RawValue> {
        Scale(RawValue._cos(angle.rawValue))
    }

    /// Tangent of an angle.
    @inlinable
    public static func tan(of angle: Self) -> Scale<1, RawValue> {
        Scale(RawValue._tan(angle.rawValue))
    }

    /// Sine of the angle.
    @inlinable
    public var sin: Scale<1, RawValue> { Self.sin(of: self) }

    /// Cosine of the angle.
    @inlinable
    public var cos: Scale<1, RawValue> { Self.cos(of: self) }

    /// Tangent of the angle.
    @inlinable
    public var tan: Scale<1, RawValue> { Self.tan(of: self) }

    /// Creates an angle from its sine value.
    @inlinable
    public static func asin(_ ratio: Scale<1, RawValue>) -> Self {
        Self(__unchecked: (), RawValue._asin(ratio.value))
    }

    /// Creates an angle from its cosine value.
    @inlinable
    public static func acos(_ ratio: Scale<1, RawValue>) -> Self {
        Self(__unchecked: (), RawValue._acos(ratio.value))
    }

    /// Creates an angle from its tangent value.
    @inlinable
    public static func atan(_ ratio: Scale<1, RawValue>) -> Self {
        Self(__unchecked: (), RawValue._atan(ratio.value))
    }

    /// Creates an angle from y and x displacements using atan2.
    @inlinable
    public static func atan2<Space>(
        y: Displacement.Y<Space>.Value<RawValue>,
        x: Displacement.X<Space>.Value<RawValue>
    ) -> Self {
        Self(__unchecked: (), RawValue._atan2(y.rawValue, x.rawValue))
    }

    /// Returns π divided by the given value.
    @inlinable
    public static func pi(over n: RawValue) -> Self {
        Self(__unchecked: (), RawValue.pi / n)
    }

    /// Returns π multiplied by the given value.
    @inlinable
    public static func pi(times n: RawValue) -> Self {
        Self(__unchecked: (), RawValue.pi * n)
    }

    /// Normalizes an angle to the range [0, 2π).
    @inlinable
    public static func normalized(_ angle: Self) -> Self {
        let twoPi = RawValue.pi * 2
        var result = angle.rawValue.truncatingRemainder(dividingBy: twoPi)
        if result < 0 {
            result += twoPi
        }
        return Self(__unchecked: (), result)
    }

    /// Normalizes the angle to the range [0, 2π).
    @inlinable
    public var normalized: Self {
        Self.normalized(self)
    }
}
