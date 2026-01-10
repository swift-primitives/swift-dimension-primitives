// Radian.swift
// An angle measured in radians, implemented as a Tagged type.

public import Real_Primitives

/// An angle measured in radians (dimensionless ratio of arc length to radius).
///
/// Radians are the natural unit for angular measurement, representing pure ratios
/// independent of coordinate systems. Use radians for mathematical operations,
/// trigonometry, and when working with the standard library's `Double` math functions.
///
/// ## Example
///
/// ```swift
/// let angle = Radian(.pi / 4)       // 45°
/// print(angle.sin)                  // 0.7071...
/// print(angle.degrees)              // Degree(45.0)
///
/// // Arithmetic operations
/// let doubled = angle * 2           // Radian(π/2) = 90°
/// let sum = angle + Radian(.pi)     // Radian(5π/4) = 225°
///
/// // Pi accessor pattern
/// let halfPi = Radian<Double>.pi.half       // π/2
/// let third = Radian<Double>.pi.third       // π/3
/// let custom = Radian<Double>.pi.fraction<3, 4>()()  // 3π/4
/// ```
public typealias Radian<Scalar> = Angle.Radian.Value<Scalar>

// MARK: - Common Angles

extension Tagged where Tag == Angle.Radian, RawValue: BinaryFloatingPoint {
    /// Zero radians
    @inlinable
    public static var zero: Self { Self(0) }

    /// π radians (180°)
    @inlinable
    public static var pi: Angle.Radian.Pi<RawValue> { .init() }

    /// π/2 radians (90°)
    @inlinable
    public static var halfPi: Self { Self(.pi / 2) }

    /// 2π radians (360°)
    @inlinable
    public static var twoPi: Self { Self(.pi * 2) }

    /// π/4 radians (45°)
    @inlinable
    public static var quarterPi: Self { Self(.pi / 4) }
}

// MARK: - Pi Accessor

extension Angle.Radian {
    /// Accessor for π-based angle values with compile-time fraction support.
    ///
    /// Provides common angle fractions and arbitrary fractions via integer
    /// generic parameters (SE-0452).
    ///
    /// ```swift
    /// Radian<Double>.pi.half              // π/2
    /// Radian<Double>.pi.quarter           // π/4
    /// Radian<Double>.pi.two               // 2π
    /// Radian<Double>.pi.fraction<1, 3>()  // π/3
    /// ```
    public struct Pi<Scalar: BinaryFloatingPoint>: Sendable {
        @usableFromInline
        internal init() {}

        /// π radians (180 degrees).
        @inlinable
        public var full: Radian<Scalar> { Radian(.pi) }

        /// π/2 radians (90 degrees).
        @inlinable
        public var half: Radian<Scalar> { Radian(.pi / 2) }

        /// π/4 radians (45 degrees).
        @inlinable
        public var quarter: Radian<Scalar> { Radian(.pi / 4) }

        /// 2π radians (360 degrees).
        @inlinable
        public var two: Radian<Scalar> { Radian(.pi * 2) }

        /// π/3 radians (60 degrees).
        @inlinable
        public var third: Radian<Scalar> { Radian(.pi / 3) }

        /// π/6 radians (30 degrees).
        @inlinable
        public var sixth: Radian<Scalar> { Radian(.pi / 6) }

        /// Typealias for compile-time fraction of π.
        public typealias Fraction<let Numerator: Int, let Denominator: Int> = Numeric.Fraction<Numerator, Denominator, Radian<Scalar>>

        /// Access arbitrary fraction of π with compile-time integer parameters.
        ///
        /// ```swift
        /// Radian<Double>.pi.fraction<1, 3>()()  // π/3
        /// Radian<Double>.pi.fraction<3, 4>()()  // 3π/4
        /// ```
        @inlinable
        public func fraction<let Numerator: Int, let Denominator: Int>() -> Fraction<Numerator, Denominator>
        where Scalar: Sendable {
            .init(Radian(.pi * Scalar(Numerator) / Scalar(Denominator)))
        }
    }
}

// MARK: - Arithmetic

extension Tagged where Tag == Angle.Radian, RawValue: AdditiveArithmetic {
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs.rawValue + rhs.rawValue)
    }

    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(lhs.rawValue - rhs.rawValue)
    }
}

extension Tagged where Tag == Angle.Radian, RawValue: Swift.Numeric {
    @_disfavoredOverload
    @inlinable
    public static func * (lhs: Self, rhs: RawValue) -> Self {
        Self(lhs.rawValue * rhs)
    }

    @_disfavoredOverload
    @inlinable
    public static func * (lhs: RawValue, rhs: Self) -> Self {
        Self(lhs * rhs.rawValue)
    }
}

extension Tagged where Tag == Angle.Radian, RawValue: FloatingPoint {
    @inlinable
    public static func / (lhs: Self, rhs: RawValue) -> Self {
        Self(lhs.rawValue / rhs)
    }
}

// MARK: - Negation

extension Tagged where Tag == Angle.Radian, RawValue: SignedNumeric {
    @inlinable
    public static prefix func - (value: Self) -> Self {
        Self(-value.rawValue)
    }
}

// MARK: - Conversion

extension Tagged where Tag == Angle.Radian, RawValue: BinaryFloatingPoint {
    /// Creates a radian angle from degrees.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let deg = Degree(90)
    /// let rad = Radian(degrees: deg)  // Radian(π/2)
    /// ```
    @inlinable
    public init(degrees: Degree<RawValue>) {
        self.init(degrees.rawValue * .pi / 180)
    }
}

extension Tagged where Tag == Angle.Radian, RawValue: BinaryFloatingPoint {
    /// Converts to degrees.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let rad = Radian(.pi)
    /// print(rad.degrees)  // Degree(180)
    /// ```
    @inlinable
    public var degrees: Degree<RawValue> {
        Degree(radians: self)
    }
}
