// Direction+Orientation.swift
// Re-attaches the binary-orientation surface to the extracted Direction atom.
//
// Direction was extracted to swift-direction-primitives WITHOUT its Orientation conformance:
// extracting the protocol too would form a direction <-> dimension package cycle ([MOD-032]).
// dimension owns the Orientation protocol, so it re-adds the conformance here. Per
// [API-IMPL-018] the Orientation conformance is NOT @retroactive (the protocol is local to
// THIS package — @retroactive is package-scoped, not module-scoped, and turns on the
// PROTOCOL's package). The CaseIterable conformance IS @retroactive: CaseIterable is stdlib
// and Direction is external, so dimension owns neither.

public import Direction_Primitive

extension Direction: @retroactive CaseIterable {
    /// All direction cases, in canonical order.
    public static var allCases: [Direction] { [.positive, .negative] }
}

extension Direction: Orientation {
    /// Returns self — `Direction` is the canonical orientation.
    @inlinable
    public var direction: Direction { self }

    /// Creates a direction (identity conversion).
    @inlinable
    public init(direction: Direction) { self = direction }
}
