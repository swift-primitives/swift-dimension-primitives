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
    /// Two values with equal ticks represent the same grid point, and — as
    /// long as both were produced by this package's construction paths
    /// (the `init(_:)` on `Tag: Spatial` spaces, `init(ticks:)`, or the
    /// quantizing arithmetic operators) — also carry identical underlying
    /// bits, so `Self`'s inherited bitwise `Equatable`/`Hashable`
    /// conformance already agrees with tick equality. Compare `.ticks`
    /// explicitly (rather than `==`) when a value may have been constructed
    /// through `init(_unchecked:)` or a literal, which bypass quantization
    /// and are not guaranteed to hold canonical bits for their tick.
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

// Note on Equatable/Hashable (F-002 remediation): earlier revisions shadowed
// `==`/`!=` here with a tick-based comparison constrained to
// `Tag.Space: Numeric.Quantized`. Because `Tagged`'s `Equatable`/`Hashable`
// conformances are declared unconditionally upstream in
// swift-tagged-primitives (bitwise over `underlying`), Swift does not permit
// a second, more specific conditional conformance to the same protocol for
// an overlapping constraint set — so those operators could only ever shadow
// `==`/`!=` as ordinary static functions, not replace the protocol witness.
// That split equality into two incompatible notions depending on call site:
// a *direct* context (`x == y` with both operands' concrete types known)
// resolved to this tick-based overload, while any *generic* context
// (`Set`, `Dictionary`, `Array.contains`, or any `func f<T: Equatable>`)
// dispatched through the protocol witness table to the unmodified bitwise
// `==` — and `hash(into:)` was never overridden at all, so it always hashed
// bits. A value pair that compared equal directly could compare unequal
// generically and hash unequally, violating the Hashable contract's spirit
// even though the compiler's own witness-table dispatch stayed internally
// consistent for each individual context.
//
// F-001's fix guarantees canonical bits (same tick => identical bits) at
// every construction path this package controls, so removing the shadow
// operators makes the single upstream bitwise Equatable/Hashable conformance
// the one, coherent notion of equality in both direct and generic contexts —
// see the `ticks` doc comment above for the residual `_unchecked`/literal
// caveat this does not (and cannot, from this package) close.
