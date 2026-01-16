// Axis+CaseIterable.swift
// CaseIterable conformance for Axis<N> via Finite.Enumerable.

// MARK: - Axis: Finite.Enumerable

extension Axis: Finite.Enumerable {
    /// Number of axes in N-dimensional space.
    @inlinable
    public static var caseCount: Int { N }

    /// Index of this axis (0 to N-1).
    @inlinable
    public var caseIndex: Int { rawValue }

    /// Creates an axis from its index.
    ///
    /// - Precondition: `caseIndex` must be in 0..<N
    @inlinable
    public init(caseIndex: Int) {
        self.init(unchecked: caseIndex)
    }
}
