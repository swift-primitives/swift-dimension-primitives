// Axis.Horizontal Tests.swift

import Axis_Primitive
import Direction_Primitive
import Testing

@testable import Dimension_Primitives

// MARK: - Axis.Horizontal Typealias Tests

@Suite
struct `Axis.Horizontal - Typealias` {
    // The `Axis<N>.*` orientation typealiases are referenced in expression position
    // only. A named local typed as the sugared value-generic typealias —
    // `let h: Axis<2>.Horizontal = …` — crashes the +Asserts debug-info mangler
    // (getMangledName / IRGenDebugInfo.cpp:1098). See swift-compiler-bug-catalog §A21.

    @Test
    func `Axis2 Horizontal is identical to Horizontal`() {
        #expect(Axis<2>.Horizontal.leftward == Horizontal.leftward)
        #expect(Axis<2>.Horizontal.leftward.opposite == Horizontal.leftward.opposite)
    }

    @Test
    func `All Horizontal functionality available via Axis2 Horizontal`() {
        #expect(Axis<2>.Horizontal.rightward.direction == Horizontal.rightward.direction)
        #expect(Axis<2>.Horizontal.rightward.opposite == Horizontal.rightward.opposite)
        #expect(Axis<2>.Horizontal.rightward.isRightward == Horizontal.rightward.isRightward)
        #expect(Axis<2>.Horizontal.rightward.isLeftward == Horizontal.rightward.isLeftward)
        #expect(Axis<2>.Horizontal.leftward.direction == Horizontal.leftward.direction)
        #expect(Axis<2>.Horizontal.leftward.opposite == Horizontal.leftward.opposite)
        #expect(Axis<2>.Horizontal.leftward.isRightward == Horizontal.leftward.isRightward)
        #expect(Axis<2>.Horizontal.leftward.isLeftward == Horizontal.leftward.isLeftward)
    }

    @Test
    func `Horizontal available for 2D`() {
        // Compile-time verification that the Axis<2>.Horizontal typealias exists.
        _ = Axis<2>.Horizontal.rightward
    }
}
