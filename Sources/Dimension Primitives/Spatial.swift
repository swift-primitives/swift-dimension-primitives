// Spatial.swift
// Phantom type tag protocol for coordinate space membership.

/// A phantom type tag that belongs to a coordinate space.
///
/// All dimension tags (coordinates, displacements, magnitudes) conform to this protocol,
/// exposing their `Space` parameter for compile-time dispatch and quantization support.
public protocol Spatial {
    associatedtype Space
}
