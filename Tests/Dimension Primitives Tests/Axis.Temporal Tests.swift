// Axis.Temporal Tests.swift

import Test_Primitives
import Testing

@testable import Dimension_Primitives

// MARK: - Axis.Temporal Typealias Tests

@Suite
struct `Axis.Temporal - Typealias` {
    @Test
    func `Axis Temporal is identical to Temporal`() {
        let axisTemporal: Axis<4>.Temporal = .future
        let temporal: Temporal = .future

        #expect(axisTemporal == temporal)
        #expect(axisTemporal.opposite == temporal.opposite)
    }

    @Test(arguments: [Temporal.future, Temporal.past])
    func `All Temporal functionality available via Axis Temporal`(temporal: Temporal) {
        let axisTemporal: Axis<4>.Temporal = temporal

        #expect(axisTemporal.direction == temporal.direction)
        #expect(axisTemporal.opposite == temporal.opposite)
        #expect(axisTemporal.isFuture == temporal.isFuture)
        #expect(axisTemporal.isPast == temporal.isPast)
    }

    @Test
    func `Temporal available for 4D`() {
        // Compile-time verification that typealias exists
        let _: Axis<4>.Temporal = .future
    }
}
