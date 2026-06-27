// Axis.Direction Tests.swift

import Axis_Primitive
import Direction_Primitive
import Testing

@testable import Dimension_Primitives

// MARK: - Axis.Direction Typealias Tests

@Suite
struct `Axis.Direction - Typealias` {
    // `Axis<N>.Direction` is referenced in expression position only. A named local
    // typed as the sugared value-generic typealias — `let d: Axis<3>.Direction = …` —
    // crashes the +Asserts debug-info mangler (getMangledName /
    // IRGenDebugInfo.cpp:1098). See swift-compiler-bug-catalog §A21.

    @Test
    func `Direction is same type across all dimensions`() {
        // Homogeneous `==` across the Axis<N>.Direction spellings type-checks only if
        // they are the same type — proving Direction is identical for every N.
        #expect(Axis<1>.Direction.positive == Axis<2>.Direction.positive)
        #expect(Axis<2>.Direction.positive == Axis<3>.Direction.positive)
        #expect(Axis<3>.Direction.positive == Axis<4>.Direction.positive)
        #expect(Axis<4>.Direction.positive == Direction.positive)
    }

    @Test
    func `Axis Direction is identical to Direction`() {
        #expect(Axis<3>.Direction.negative == Direction.negative)
        #expect(Axis<3>.Direction.negative.opposite == Direction.negative.opposite)
    }

    @Test
    func `All Direction functionality available via Axis Direction`() {
        #expect(Axis<2>.Direction.positive.sign == Direction.positive.sign)
        #expect(Axis<2>.Direction.positive.opposite == Direction.positive.opposite)
        #expect(Axis<2>.Direction.positive.direction == Direction.positive.direction)
        #expect(Axis<2>.Direction.negative.sign == Direction.negative.sign)
        #expect(Axis<2>.Direction.negative.opposite == Direction.negative.opposite)
        #expect(Axis<2>.Direction.negative.direction == Direction.negative.direction)
    }
}
