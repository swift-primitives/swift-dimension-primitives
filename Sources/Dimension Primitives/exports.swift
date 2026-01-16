// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-primitives open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

// Re-export Tagged from Identity Primitives so consumers don't need to import separately
@_exported import struct Identity_Primitives.Tagged
@_exported import enum Numeric_Primitives.Numeric

// Re-export algebraic types from Algebra Primitives for backwards compatibility
@_exported import protocol Algebra_Primitives.Enumerable
@_exported import struct Algebra_Primitives.Enumeration
@_exported import struct Algebra_Primitives.Ordinal
@_exported import typealias Algebra_Primitives.Fin
@_exported import struct Algebra_Primitives.Pair
