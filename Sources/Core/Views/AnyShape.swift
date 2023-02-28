//
//  File.swift
//  
//
//  Created by ExecutionLab's Macbook on 11/08/2022.
//

import SwiftUI

public struct AnyShape: Shape {
    private let builder: (CGRect) -> Path

    public init<S: Shape>(_ shape: S) {
        builder = { rect in
            let path = shape.path(in: rect)
            return path
        }
    }

    public func path(in rect: CGRect) -> Path {
        return builder(rect)
    }
}
