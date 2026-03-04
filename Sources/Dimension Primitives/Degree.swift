// Degree.swift
// An angle measured in degrees, implemented as a Tagged type.

public import Real_Primitives

/// An angle measured in degrees (1/360 of a full rotation).
///
/// Degrees provide an intuitive unit for angles familiar to most users,
/// with 360° representing a complete circle. Use degrees for user-facing values,
/// UI controls, and when working with geographic coordinates or navigation.
///
/// ## Example
///
/// ```swift
/// let rightAngle = Degree(__unchecked: (), 90)
/// print(rightAngle.radians)         // Radian(π/2)
/// print(rightAngle.sin)             // 1.0
///
/// // Arithmetic operations
/// let rotation = rightAngle * 2     // Degree(__unchecked: (), 180)
/// let half = rightAngle / 2         // Degree(__unchecked: (), 45)
///
/// // Accessor patterns
/// let right = Degree<Double>.right.full      // 90°
/// let half45 = Degree<Double>.right.half     // 45°
/// let custom = Degree<Double>.full.fraction<1, 12>()()  // 30°
/// ```
public typealias Degree<Scalar> = Angle.Degree.Value<Scalar>

// MARK: - Common Angles

extension Tagged where Tag == Angle.Degree, RawValue: BinaryFloatingPoint {
    /// Zero degrees.
    @inlinable
    public static var zero: Self { Self(__unchecked: (), 0) }

    /// Access right angle (90°) based values.
    ///
    /// ```swift
    /// Degree<Double>.right.full              // 90°
    /// Degree<Double>.right.half              // 45°
    /// Degree<Double>.right.third             // 30°
    /// Degree<Double>.right.fraction<2, 3>()  // 60°
    /// ```
    @inlinable
    public static var right: Angle.Degree.Right<RawValue> { .init() }

    /// Access straight angle (180°) based values.
    ///
    /// ```swift
    /// Degree<Double>.straight.full           // 180°
    /// Degree<Double>.straight.half           // 90°
    /// ```
    @inlinable
    public static var straight: Angle.Degree.Straight<RawValue> { .init() }

    /// Access full rotation (360°) based values.
    ///
    /// ```swift
    /// Degree<Double>.full.full               // 360°
    /// Degree<Double>.full.half               // 180°
    /// Degree<Double>.full.third              // 120°
    /// Degree<Double>.full.fraction<1, 12>()  // 30°
    /// ```
    @inlinable
    public static var full: Angle.Degree.Full<RawValue> { .init() }
}

// MARK: - Double

extension Tagged where Tag == Angle.Degree, RawValue == Double {
    /// Right angle (90°)
    @inlinable
    public static var rightAngle: Self { Self(__unchecked: (), 90) }

    /// Straight angle (180°)
    @inlinable
    public static var straightAngle: Self { Self(__unchecked: (), 180) }

    /// Full circle (360°)
    @inlinable
    public static var fullCircle: Self { Self(__unchecked: (), 360) }

    /// Forty-five degrees (45°)
    @inlinable
    public static var fortyFive: Self { Self(__unchecked: (), 45) }

    /// Sixty degrees (60°)
    @inlinable
    public static var sixty: Self { Self(__unchecked: (), 60) }

    /// Thirty degrees (30°)
    @inlinable
    public static var thirty: Self { Self(__unchecked: (), 30) }
}

// MARK: - Float

extension Tagged where Tag == Angle.Degree, RawValue == Float {
    /// Right angle (90°)
    @inlinable
    public static var rightAngle: Self { Self(__unchecked: (), 90) }

    /// Straight angle (180°)
    @inlinable
    public static var straightAngle: Self { Self(__unchecked: (), 180) }

    /// Full circle (360°)
    @inlinable
    public static var fullCircle: Self { Self(__unchecked: (), 360) }

    /// Forty-five degrees (45°)
    @inlinable
    public static var fortyFive: Self { Self(__unchecked: (), 45) }

    /// Sixty degrees (60°)
    @inlinable
    public static var sixty: Self { Self(__unchecked: (), 60) }

    /// Thirty degrees (30°)
    @inlinable
    public static var thirty: Self { Self(__unchecked: (), 30) }
}

// MARK: - Right Angle Accessor (90°)

extension Angle.Degree {
    /// Accessor for right angle (90°) based values with compile-time fraction support.
    public struct Right<Scalar: BinaryFloatingPoint>: Sendable {
        @usableFromInline
        internal init() {}

        /// 90 degrees (a right angle).
        @inlinable
        public var full: Degree<Scalar> { Degree(__unchecked: (), 90) }

        /// 45 degrees (half a right angle).
        @inlinable
        public var half: Degree<Scalar> { Degree(__unchecked: (), 45) }

        /// 30 degrees (a third of a right angle).
        @inlinable
        public var third: Degree<Scalar> { Degree(__unchecked: (), 30) }

        /// 22.5 degrees (a quarter of a right angle).
        @inlinable
        public var quarter: Degree<Scalar> { Degree(__unchecked: (), 22.5) }

        /// Typealias for compile-time fraction of 90°.
        public typealias Fraction<let Numerator: Int, let Denominator: Int> = Numeric.Fraction<Numerator, Denominator, Degree<Scalar>>

        /// Access arbitrary fraction of 90° with compile-time integer parameters.
        ///
        /// ```swift
        /// Degree<Double>.right.fraction<2, 3>()()  // 60°
        /// Degree<Double>.right.fraction<1, 6>()()  // 15°
        /// ```
        @inlinable
        public func fraction<let Numerator: Int, let Denominator: Int>() -> Fraction<Numerator, Denominator> {
            .init(Degree(__unchecked: (), 90 * Scalar(Numerator) / Scalar(Denominator)))
        }
    }
}

// MARK: - Straight Angle Accessor (180°)

extension Angle.Degree {
    /// Accessor for straight angle (180°) based values with compile-time fraction support.
    public struct Straight<Scalar: BinaryFloatingPoint>: Sendable {
        @usableFromInline
        internal init() {}

        /// 180 degrees (a straight angle).
        @inlinable
        public var full: Degree<Scalar> { Degree(__unchecked: (), 180) }

        /// 90 degrees (half a straight angle).
        @inlinable
        public var half: Degree<Scalar> { Degree(__unchecked: (), 90) }

        /// 60 degrees (a third of a straight angle).
        @inlinable
        public var third: Degree<Scalar> { Degree(__unchecked: (), 60) }

        /// 45 degrees (a quarter of a straight angle).
        @inlinable
        public var quarter: Degree<Scalar> { Degree(__unchecked: (), 45) }

        /// Typealias for compile-time fraction of 180°.
        public typealias Fraction<let Numerator: Int, let Denominator: Int> = Numeric.Fraction<Numerator, Denominator, Degree<Scalar>>

        /// Access arbitrary fraction of 180° with compile-time integer parameters.
        @inlinable
        public func fraction<let Numerator: Int, let Denominator: Int>() -> Fraction<Numerator, Denominator> {
            .init(Degree(__unchecked: (), 180 * Scalar(Numerator) / Scalar(Denominator)))
        }
    }
}

// MARK: - Full Rotation Accessor (360°)

extension Angle.Degree {
    /// Accessor for full rotation (360°) based values with compile-time fraction support.
    public struct Full<Scalar: BinaryFloatingPoint>: Sendable {
        @usableFromInline
        internal init() {}

        /// 360 degrees (a full rotation).
        @inlinable
        public var full: Degree<Scalar> { Degree(__unchecked: (), 360) }

        /// 180 degrees (half a rotation).
        @inlinable
        public var half: Degree<Scalar> { Degree(__unchecked: (), 180) }

        /// 120 degrees (a third of a rotation).
        @inlinable
        public var third: Degree<Scalar> { Degree(__unchecked: (), 120) }

        /// 90 degrees (a quarter of a rotation).
        @inlinable
        public var quarter: Degree<Scalar> { Degree(__unchecked: (), 90) }

        /// 60 degrees (a sixth of a rotation).
        @inlinable
        public var sixth: Degree<Scalar> { Degree(__unchecked: (), 60) }

        /// Typealias for compile-time fraction of 360°.
        public typealias Fraction<let Numerator: Int, let Denominator: Int> = Numeric.Fraction<Numerator, Denominator, Degree<Scalar>>

        /// Access arbitrary fraction of 360° with compile-time integer parameters.
        ///
        /// ```swift
        /// Degree<Double>.full.fraction<1, 12>()()  // 30°
        /// Degree<Double>.full.fraction<5, 6>()()   // 300°
        /// ```
        @inlinable
        public func fraction<let Numerator: Int, let Denominator: Int>() -> Fraction<Numerator, Denominator> {
            .init(Degree(__unchecked: (), 360 * Scalar(Numerator) / Scalar(Denominator)))
        }
    }
}

// MARK: - Arithmetic

extension Tagged where Tag == Angle.Degree, RawValue: AdditiveArithmetic {
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(__unchecked: (), lhs.rawValue + rhs.rawValue)
    }

    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(__unchecked: (), lhs.rawValue - rhs.rawValue)
    }
}

extension Tagged where Tag == Angle.Degree, RawValue: Swift.Numeric {
    @_disfavoredOverload
    @inlinable
    public static func * (lhs: Self, rhs: RawValue) -> Self {
        Self(__unchecked: (), lhs.rawValue * rhs)
    }

    @_disfavoredOverload
    @inlinable
    public static func * (lhs: RawValue, rhs: Self) -> Self {
        Self(__unchecked: (), lhs * rhs.rawValue)
    }
}

extension Tagged where Tag == Angle.Degree, RawValue: FloatingPoint {
    @inlinable
    public static func / (lhs: Self, rhs: RawValue) -> Self {
        Self(__unchecked: (), lhs.rawValue / rhs)
    }
}

// MARK: - Negation

extension Tagged where Tag == Angle.Degree, RawValue: SignedNumeric {
    @inlinable
    public static prefix func - (value: Self) -> Self {
        value.map { -$0 }
    }
}

// MARK: - Conversion

extension Tagged where Tag == Angle.Degree, RawValue: BinaryFloatingPoint {
    /// Creates a degree angle from radians.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let rad = Radian(.pi / 2)
    /// let deg = Degree(radians: rad)  // Degree(90.0)
    /// ```
    @inlinable
    public init(radians: Radian<RawValue>) {
        self.init(__unchecked: (), radians.rawValue * 180 / .pi)
    }
}

extension Tagged where Tag == Angle.Degree, RawValue: BinaryFloatingPoint {
    /// Converts to radians.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let deg = Degree(__unchecked: (), 180)
    /// print(deg.radians)  // Radian(π)
    /// ```
    @inlinable
    public var radians: Radian<RawValue> {
        Radian(degrees: self)
    }
}

// MARK: - Trigonometry (via Radians)

// MARK: Double

extension Tagged where Tag == Angle.Degree, RawValue == Double {
    /// Sine of the angle.
    @inlinable
    public var sin: Scale<1, RawValue> { radians.sin }

    /// Cosine of the angle.
    @inlinable
    public var cos: Scale<1, RawValue> { radians.cos }

    /// Tangent of the angle.
    @inlinable
    public var tan: Scale<1, RawValue> { radians.tan }
}

// MARK: Float

extension Tagged where Tag == Angle.Degree, RawValue == Float {
    /// Sine of the angle.
    @inlinable
    public var sin: Scale<1, RawValue> { radians.sin }

    /// Cosine of the angle.
    @inlinable
    public var cos: Scale<1, RawValue> { radians.cos }

    /// Tangent of the angle.
    @inlinable
    public var tan: Scale<1, RawValue> { radians.tan }
}
