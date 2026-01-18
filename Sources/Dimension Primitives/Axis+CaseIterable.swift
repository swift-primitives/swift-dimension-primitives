// Axis+CaseIterable.swift
// CaseIterable conformance for Axis<N> via Finite.Enumerable.

// MARK: - Axis: Finite.Enumerable

extension Axis: Finite.Enumerable {
    /// Number of axes in N-dimensional space.
    @inlinable
    public static var count: Int { N }

    /// Ordinal of this axis (0 to N-1).
    @inlinable
    public var ordinal: Int { rawValue }

    /// Creates an axis from its ordinal without bounds checking.
    @inlinable
    public init(__unchecked: Void, ordinal: Int) {
        self.init(__unchecked: (), ordinal)
    }
}
