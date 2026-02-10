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

// Re-export Finite Primitives (includes Finite.Enumerable, Ordinal, Cardinal)
@_exported import Finite_Primitives

// Re-export Pair from Algebra Primitives
@_exported import struct Algebra_Primitives.Pair
