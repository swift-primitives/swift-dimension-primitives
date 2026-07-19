// Tagged+Quantized.swift
// Quantization support and affine arithmetic for Tagged types.

import Numeric_Primitives_Core

// MARK: - Canonical Quantization

extension Tagged where Underlying: BinaryFloatingPoint {
    /// Finalizes an arithmetic result, quantizing to the grid when `Space`
    /// conforms to `Numeric.Quantized`, and passing the value through
    /// unchanged otherwise.
    ///
    /// Every arithmetic call site (`Tagged+Arithmetic.swift`) is generic over
    /// `Space` with no static `Numeric.Quantized` constraint — that is the
    /// whole point of those operators working for both quantized and
    /// unquantized spaces alike. A pair of statically-overloaded siblings
    /// (one unconstrained, one `where S: Numeric.Quantized`) is therefore
    /// **never** resolved to the constrained overload from those sites:
    /// overload resolution for a generic function's body is fixed once,
    /// against the abstract type parameter `Space`, which never itself
    /// conforms to `Numeric.Quantized` no matter what concrete type it is
    /// later instantiated with. That made quantization statically
    /// unreachable. This single entry point instead performs the conformance
    /// check at runtime via a conditional cast to the existential metatype,
    /// which is evaluated per call against the concrete `S` and therefore
    /// stays reachable from every generic context.
    @inlinable
    public static func _quantize<S>(_ value: Underlying, in space: S.Type) -> Self {
        guard let quantized = S.self as? any Numeric.Quantized.Type else {
            return Self(_unchecked: value)
        }
        return _quantize(value, quantizedBy: quantized)
    }

    /// Quantizes `value` to the grid defined by `space`'s conformance to
    /// `Numeric.Quantized`.
    ///
    /// Produces canonical representation: the same tick always yields
    /// identical bits. `space` arrives pre-opened as an existential metatype
    /// from `_quantize(_:in:)`'s runtime conformance check; passing it to a
    /// generic parameter here triggers implicit existential opening
    /// (SE-0352) so `Q` binds to the concrete underlying type.
    @inlinable
    public static func _quantize<Q: Numeric.Quantized>(_ value: Underlying, quantizedBy space: Q.Type) -> Self {
        let q = Q.quantum(as: Underlying.self)
        let ticks = Int64((value / q).rounded())
        return Self(_unchecked: Underlying(ticks) * q)
    }
}

// MARK: - Tick Access

extension Tagged where Tag: Spatial, Tag.Space: Numeric.Quantized, Underlying: BinaryFloatingPoint {
    /// The integer tick representing this quantized value.
    ///
    /// The tick is the canonical representation: `value ≈ tick × quantum`.
    /// Two values with equal ticks represent the same grid point.
    @inlinable
    public var ticks: Int64 {
        let q = Tag.Space.quantum(as: Underlying.self)
        return Int64((underlying / q).rounded())
    }

    /// Creates a tagged value from an integer tick count.
    ///
    /// - Parameter ticks: The grid point index
    @inlinable
    public init(ticks: Int64) {
        let q = Tag.Space.quantum(as: Underlying.self)
        self.init(_unchecked: Underlying(ticks) * q)
    }
}

// MARK: - Tick-Based Equality

extension Tagged where Tag: Spatial, Tag.Space: Numeric.Quantized, Underlying: BinaryFloatingPoint {
    /// Compares two quantized values by their tick (grid point).
    ///
    /// This is the mathematically correct equality for quantized types:
    /// two values are equal iff they represent the same grid point,
    /// regardless of floating-point representation differences.
    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.ticks == rhs.ticks
    }

    /// Compares two quantized values by their tick (grid point).
    @inlinable
    public static func != (lhs: Self, rhs: Self) -> Bool {
        lhs.ticks != rhs.ticks
    }
}
