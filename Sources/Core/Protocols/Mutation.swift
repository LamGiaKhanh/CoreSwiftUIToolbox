//
//  File.swift
//  
//
//  Created by ExecutionLab's Macbook on 16/08/2022.
//

import Foundation

public protocol Mutation {
    func mutate(_ action: (inout Self) -> Void) -> Self
}

public extension Mutation {
    func mutate(_ action: (inout Self) -> Void) -> Self {
        var _self = self
        action(&_self)
        return _self
    }
}
