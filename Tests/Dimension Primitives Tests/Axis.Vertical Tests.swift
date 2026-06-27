// Axis.Vertical Tests.swift

import Axis_Primitive
import Direction_Primitive
import Testing

@testable import Dimension_Primitives

// MARK: - Axis.Vertical Typealias Tests

@Suite
struct `Axis.Vertical - Typealias` {
    // The `Axis<N>.*` orientation typealiases are referenced in expression position
    // only (member access on the typealias spelling). A named local typed as the
    // sugared value-generic typealias — `let v: Axis<2>.Vertical = …` — crashes the
    // +Asserts debug-info mangler (getMangledName / IRGenDebugInfo.cpp:1098). See
    // swift-compiler-bug-catalog §A21. Expression position preserves the
    // existence / identity / API coverage without emitting that variable's debug type.

    @Test
    func `Axis2 Vertical is identical to Vertical`() {
        // Homogeneous `==` across the two spellings type-checks only if they are the
        // same type — proving Axis<2>.Vertical IS Vertical.
        #expect(Axis<2>.Vertical.downward == Vertical.downward)
        #expect(Axis<2>.Vertical.downward.opposite == Vertical.downward.opposite)
    }

    @Test
    func `All Vertical functionality available via Axis2 Vertical`() {
        // Every Vertical member is reachable through the Axis<2>.Vertical typealias
        // spelling and yields the same value.
        #expect(Axis<2>.Vertical.upward.direction == Vertical.upward.direction)
        #expect(Axis<2>.Vertical.upward.opposite == Vertical.upward.opposite)
        #expect(Axis<2>.Vertical.upward.isUpward == Vertical.upward.isUpward)
        #expect(Axis<2>.Vertical.upward.isDownward == Vertical.upward.isDownward)
        #expect(Axis<2>.Vertical.downward.direction == Vertical.downward.direction)
        #expect(Axis<2>.Vertical.downward.opposite == Vertical.downward.opposite)
        #expect(Axis<2>.Vertical.downward.isUpward == Vertical.downward.isUpward)
        #expect(Axis<2>.Vertical.downward.isDownward == Vertical.downward.isDownward)
    }

    @Test
    func `Vertical available for 2D`() {
        // Compile-time verification that the Axis<2>.Vertical typealias exists.
        _ = Axis<2>.Vertical.upward
    }
}
