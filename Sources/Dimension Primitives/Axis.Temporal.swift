// Axis.Temporal.swift
// Typealias for temporal orientation on 4D+ axes.

public import Axis_Primitive

extension Axis where N == 4 {
    /// Time-axis orientation convention.
    public typealias Temporal = Dimension_Primitives.Temporal
}
