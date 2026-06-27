// Axis.Temporal Tests.swift

import Axis_Primitive
import Direction_Primitive
import Testing

@testable import Dimension_Primitives

// MARK: - Axis.Temporal Typealias Tests

@Suite
struct `Axis.Temporal - Typealias` {
    // The `Axis<N>.*` orientation typealiases are referenced in expression position
    // only. A named local typed as the sugared value-generic typealias —
    // `let t: Axis<4>.Temporal = …` — crashes the +Asserts debug-info mangler
    // (getMangledName / IRGenDebugInfo.cpp:1098). See swift-compiler-bug-catalog §A21.

    @Test
    func `Axis Temporal is identical to Temporal`() {
        #expect(Axis<4>.Temporal.future == Temporal.future)
        #expect(Axis<4>.Temporal.future.opposite == Temporal.future.opposite)
    }

    @Test
    func `All Temporal functionality available via Axis Temporal`() {
        #expect(Axis<4>.Temporal.future.direction == Temporal.future.direction)
        #expect(Axis<4>.Temporal.future.opposite == Temporal.future.opposite)
        #expect(Axis<4>.Temporal.future.isFuture == Temporal.future.isFuture)
        #expect(Axis<4>.Temporal.future.isPast == Temporal.future.isPast)
        #expect(Axis<4>.Temporal.past.direction == Temporal.past.direction)
        #expect(Axis<4>.Temporal.past.opposite == Temporal.past.opposite)
        #expect(Axis<4>.Temporal.past.isFuture == Temporal.past.isFuture)
        #expect(Axis<4>.Temporal.past.isPast == Temporal.past.isPast)
    }

    @Test
    func `Temporal available for 4D`() {
        // Compile-time verification that the Axis<4>.Temporal typealias exists.
        _ = Axis<4>.Temporal.future
    }
}
