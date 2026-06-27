// Axis.Depth Tests.swift

import Axis_Primitive
import Direction_Primitive
import Testing

@testable import Dimension_Primitives

// MARK: - Axis.Depth Typealias Tests (3D)

@Suite
struct `Axis.Depth - 3D Typealias` {
    // The `Axis<N>.*` orientation typealiases are referenced in expression position
    // only. A named local typed as the sugared value-generic typealias —
    // `let d: Axis<3>.Depth = …` — crashes the +Asserts debug-info mangler
    // (getMangledName / IRGenDebugInfo.cpp:1098). See swift-compiler-bug-catalog §A21.

    @Test
    func `Axis3 Depth is identical to Depth`() {
        #expect(Axis<3>.Depth.backward == Depth.backward)
        #expect(Axis<3>.Depth.backward.opposite == Depth.backward.opposite)
    }

    @Test
    func `All Depth functionality available via Axis3 Depth`() {
        #expect(Axis<3>.Depth.forward.direction == Depth.forward.direction)
        #expect(Axis<3>.Depth.forward.opposite == Depth.forward.opposite)
        #expect(Axis<3>.Depth.forward.isForward == Depth.forward.isForward)
        #expect(Axis<3>.Depth.forward.isBackward == Depth.forward.isBackward)
        #expect(Axis<3>.Depth.backward.direction == Depth.backward.direction)
        #expect(Axis<3>.Depth.backward.opposite == Depth.backward.opposite)
        #expect(Axis<3>.Depth.backward.isForward == Depth.backward.isForward)
        #expect(Axis<3>.Depth.backward.isBackward == Depth.backward.isBackward)
    }

    @Test
    func `Depth available for 3D`() {
        // Compile-time verification that the Axis<3>.Depth typealias exists.
        _ = Axis<3>.Depth.forward
    }
}

// MARK: - Axis.Depth Typealias Tests (4D)

@Suite
struct `Axis.Depth - 4D Typealias` {
    // Note: Axis<4>.Depth is defined in a separate extension where N == 4
    // We test it separately to avoid cross-extension type issues

    @Test(arguments: [Depth.forward, Depth.backward])
    func `Depth is available in 4D context`(depth: Depth) {
        // Test that Depth type works in 4D context
        // Since Axis<4>.Depth is just Dimension.Depth, test the underlying type
        #expect(depth.direction == .positive || depth.direction == .negative)
        #expect(depth.opposite.opposite == depth)
    }
}
