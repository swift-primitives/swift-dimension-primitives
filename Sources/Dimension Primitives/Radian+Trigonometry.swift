// Radian+Trigonometry.swift
// Trigonometric functions and constants for Radian.

public import Real_Primitives

// MARK: - Numeric.Transcendental

extension Tagged where Tag == Angle.Radian, Underlying: BinaryFloatingPoint & Numeric.Transcendental {
    /// Sine of an angle.
    @inlinable
    public static func sin(of angle: Self) -> Scale<1, Underlying> {
        Scale(Underlying._sin(angle.underlying))
    }

    /// Cosine of an angle.
    @inlinable
    public static func cos(of angle: Self) -> Scale<1, Underlying> {
        Scale(Underlying._cos(angle.underlying))
    }

    /// Tangent of an angle.
    @inlinable
    public static func tan(of angle: Self) -> Scale<1, Underlying> {
        Scale(Underlying._tan(angle.underlying))
    }

    /// Sine of the angle.
    @inlinable
    public var sin: Scale<1, Underlying> { Self.sin(of: self) }

    /// Cosine of the angle.
    @inlinable
    public var cos: Scale<1, Underlying> { Self.cos(of: self) }

    /// Tangent of the angle.
    @inlinable
    public var tan: Scale<1, Underlying> { Self.tan(of: self) }

    /// Creates an angle from its sine value.
    @inlinable
    public static func asin(_ ratio: Scale<1, Underlying>) -> Self {
        Self(_unchecked: Underlying._asin(ratio.value))
    }

    /// Creates an angle from its cosine value.
    @inlinable
    public static func acos(_ ratio: Scale<1, Underlying>) -> Self {
        Self(_unchecked: Underlying._acos(ratio.value))
    }

    /// Creates an angle from its tangent value.
    @inlinable
    public static func atan(_ ratio: Scale<1, Underlying>) -> Self {
        Self(_unchecked: Underlying._atan(ratio.value))
    }

    /// Creates an angle from y and x displacements using atan2.
    @inlinable
    public static func atan2<Space>(
        y: Displacement.Y<Space>.Value<Underlying>,
        x: Displacement.X<Space>.Value<Underlying>
    ) -> Self {
        Self(_unchecked: Underlying._atan2(y.underlying, x.underlying))
    }

    /// Returns π divided by the given value.
    @inlinable
    public static func pi(over n: Underlying) -> Self {
        Self(_unchecked: Underlying.pi / n)
    }

    /// Returns π multiplied by the given value.
    @inlinable
    public static func pi(times n: Underlying) -> Self {
        Self(_unchecked: Underlying.pi * n)
    }

    /// Normalizes an angle to the range [0, 2π).
    @inlinable
    public static func normalized(_ angle: Self) -> Self {
        let twoPi = Underlying.pi * 2
        var result = angle.underlying.truncatingRemainder(dividingBy: twoPi)
        if result < 0 {
            result += twoPi
        }
        return Self(_unchecked: result)
    }

    /// Normalizes the angle to the range [0, 2π).
    @inlinable
    public var normalized: Self {
        Self.normalized(self)
    }
}
