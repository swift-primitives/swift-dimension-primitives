// Axis+CaseIterable.swift
// CaseIterable conformance for Axis<N> via Finite.Enumerable.

// MARK: - Axis: Finite.Enumerable

import Ordinal_Primitives

extension Axis: Finite.Enumerable {
    /// Number of axes in N-dimensional space.
    @inlinable
    public static var count: Cardinal { Cardinal.init(integerLiteral: UInt(N)) }

    /// Ordinal of this axis (0 to N-1).
    @inlinable
    public var ordinal: Ordinal { .init(UInt8(rawValue)) }

    /// Creates an axis from its ordinal without bounds checking.
    @inlinable
    public init(__unchecked: Void, ordinal: Ordinal) {
        self.init(__unchecked: (), Int(bitPattern: ordinal))
    }
}
