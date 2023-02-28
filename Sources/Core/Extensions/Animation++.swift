//
//  File.swift
//  
//
//  Created by ExecutionLab's Macbook on 07/07/2022.
//

import SwiftUI

extension Animation {
    public func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}
