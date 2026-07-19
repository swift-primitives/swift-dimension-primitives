//
//  Tagged+Quantized Tests.swift
//  swift-standards
//
//  Tests for Tagged quantized arithmetic and tick-based equality.
//

@_spi(Internal) import Dimension_Primitives
import Numeric_Primitives_Core
import Testing

// MARK: - Test Space

private enum TestSpace: Numeric.Quantized {}

extension TestSpace {
    typealias Scalar = Double
    static var quantum: Double { 0.01 }
}

// MARK: - Type Aliases

private typealias QX = Coordinate.X<TestSpace>.Value<Double>
private typealias QY = Coordinate.Y<TestSpace>.Value<Double>
private typealias QDx = Displacement.X<TestSpace>.Value<Double>
private typealias QDy = Displacement.Y<TestSpace>.Value<Double>

// MARK: - Generic-Context Equality Probe

/// Compares through the `Equatable` protocol requirement in a generic
/// context, exactly as `Set`, `Dictionary`, `Array.contains`, and any
/// `func f<T: Equatable>` do — dispatched via the protocol witness table
/// rather than a concrete-type static `==` lookup.
private func genericEqual<T: Equatable>(_ lhs: T, _ rhs: T) -> Bool {
    lhs == rhs
}

// MARK: - Tests

@Suite
struct `Tagged+Quantized` {

    @Suite
    struct `Tick Representation` {

        @Test
        func `ticks property returns correct grid index`() {
            let x: QX = .init(1.234)
            #expect(x.ticks == 123)
        }

        @Test
        func `init from ticks creates correct value`() {
            let x = QX(ticks: 14940)
            #expect(x.ticks == 14940)
        }

        @Test
        func `same tick produces identical bits`() {
            let x1 = QX(ticks: 14940)
            let x2 = QX(ticks: 14940)
            #expect(x1 == x2)
            #expect(x1.underlying.bitPattern == x2.underlying.bitPattern)
        }
    }

    @Suite
    struct `Tick Equality` {

        @Test
        func `equal ticks are equal`() {
            let x1: QX = .init(149.4)
            let x2: QX = .init(149.4000000001)  // Same tick after quantization
            #expect(x1 == x2)
            #expect(x1.ticks == x2.ticks)
        }

        @Test
        func `different ticks are not equal`() {
            let x1: QX = .init(149.4)
            let x2: QX = .init(149.5)
            #expect(x1 != x2)
        }
    }

    @Suite
    struct `X Axis` {

        @Test
        func `coordinate + displacement`() {
            let x: QX = .init(100.0)
            let dx: QDx = .init(21.8)
            let result = x + dx
            #expect(result.ticks == 12180)
        }

        @Test
        func `coordinate + displacement accumulation`() {
            let x: QX = .init(84.0)
            let dx: QDx = .init(21.8)
            let row1 = x + dx
            let row2 = row1 + dx
            let row3 = row2 + dx

            #expect(row1.ticks == 10580)
            #expect(row2.ticks == 12760)
            #expect(row3.ticks == 14940)
        }

        @Test
        func `coordinate - coordinate`() {
            let x1: QX = .init(149.4)
            let x2: QX = .init(84.0)
            let dx: QDx = x1 - x2
            #expect(dx.ticks == 6540)
        }

        @Test
        func `coordinate - displacement`() {
            let x: QX = .init(149.4)
            let dx: QDx = .init(21.8)
            let result = x - dx
            #expect(result.ticks == 12760)
        }

        @Test
        func `displacement + displacement`() {
            let dx1: QDx = .init(21.8)
            let dx2: QDx = .init(21.8)
            let dx3: QDx = .init(21.8)
            let sum = dx1 + dx2 + dx3
            #expect(sum.ticks == 6540)
        }

        @Test
        func `displacement - displacement`() {
            let dx1: QDx = .init(65.4)
            let dx2: QDx = .init(21.8)
            let result = dx1 - dx2
            #expect(result.ticks == 4360)
        }
    }

    @Suite
    struct `Y Axis` {

        @Test
        func `coordinate + displacement`() {
            let y: QY = .init(100.0)
            let dy: QDy = .init(21.8)
            let result = y + dy
            #expect(result.ticks == 12180)
        }

        @Test
        func `coordinate - coordinate`() {
            let y1: QY = .init(149.4)
            let y2: QY = .init(84.0)
            let dy: QDy = y1 - y2
            #expect(dy.ticks == 6540)
        }

        @Test
        func `displacement + displacement`() {
            let dy1: QDy = .init(21.8)
            let dy2: QDy = .init(21.8)
            let dy3: QDy = .init(21.8)
            let sum = dy1 + dy2 + dy3
            #expect(sum.ticks == 6540)
        }
    }

    @Suite
    struct `Canonical Quantization` {

        // F-001 regression: the constrained `_quantize<S: Numeric.Quantized>`
        // overload was never reachable from the generic `+`/`-` operators in
        // Tagged+Arithmetic.swift (Space carries no static Quantized
        // constraint at those call sites), so arithmetic results stored the
        // raw floating-point sum instead of the canonical
        // `Underlying(ticks) * quantum` bit pattern. `.ticks` re-quantizes on
        // read and so masked the bug for tick-based comparisons; only the
        // raw `.underlying` bits exposed it. These specific tick values were
        // chosen because IEEE 754 double addition of their quantized
        // representations (8867 * 0.01) + (-5951 * 0.01) does not bit-for-bit
        // equal the canonically reconstructed (2916 * 0.01) — deterministic
        // under IEEE 754, not a flaky proximity check.
        @Test
        func `coordinate + displacement produces canonical bit pattern, not raw float sum`() {
            let x: QX = .init(ticks: 8867)
            let dx: QDx = .init(ticks: -5951)
            let result = x + dx
            let canonical = QX(ticks: 2916)

            #expect(result.ticks == 2916)
            #expect(result.underlying.bitPattern == canonical.underlying.bitPattern)
        }
    }

    @Suite
    struct `Equatable Hashable Coherence` {

        // F-002 regression: a tick-based `==`/`!=` shadowed (but did not
        // replace) the upstream bitwise `Equatable` conformance. That
        // shadow was selected at a *direct* call site (concrete types
        // known, as below) but never at a *generic* one (Set, Dictionary,
        // Array.contains, or any `func f<T: Equatable>`), which always
        // dispatches through the protocol witness table to the unmodified
        // bitwise conformance. `_unchecked` construction (public, and used
        // by `ExpressibleByFloatLiteral` upstream) bypasses quantization,
        // so two values can share a tick while holding different bits —
        // exactly the case that used to make direct and generic equality
        // disagree.
        @Test
        func `direct and generic equality contexts agree for same-tick, different-bit values`() {
            let x1 = QX(_unchecked: 123.401)
            let x2 = QX(_unchecked: 123.404)

            // Precondition for the regression to be meaningful: same grid
            // point, distinguishable bits.
            #expect(x1.ticks == x2.ticks)
            #expect(x1.underlying.bitPattern != x2.underlying.bitPattern)

            #expect((x1 == x2) == genericEqual(x1, x2))
        }
    }

    @Suite
    struct `Boundary Alignment` {

        @Test
        func `accumulated path equals direct path`() {
            let start: QY = .init(84.0)
            let step: QDy = .init(21.8)

            // Path 1: Add step by step
            let row1End = start + step
            let row2End = row1End + step
            let row3End = row2End + step

            // Path 2: Add total directly
            let total: QDy = .init(65.4)  // 3 * 21.8
            let spanEnd = start + total

            // Both should be tick 14940
            #expect(row3End == spanEnd)
            #expect(row3End.ticks == spanEnd.ticks)
            #expect(row3End.ticks == 14940)
        }

        @Test
        func `different computation paths produce same bits`() {
            let start: QY = .init(84.0)
            let step: QDy = .init(21.8)
            let total: QDy = .init(65.4)

            let accumulated = start + step + step + step
            let direct = start + total

            // Same tick means identical IEEE 754 bits
            #expect(accumulated.underlying.bitPattern == direct.underlying.bitPattern)
        }
    }
}
