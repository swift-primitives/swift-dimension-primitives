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

// Re-export Finite Primitives (includes Finite.Enumerable, Ordinal, Cardinal)
@_exported import Finite_Primitives
@_exported import Ordinal_Primitives

@_exported import enum Numeric_Primitives_Core.Numeric
// Re-export Pair from Pair Primitives
@_exported import struct Pair_Primitives.Pair
// Re-export Tagged from Identity Primitives so consumers don't need to import separately
@_exported import struct Tagged_Primitives.Tagged
