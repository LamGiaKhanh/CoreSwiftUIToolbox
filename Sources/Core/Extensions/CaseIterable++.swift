//
//  File.swift
//  
//
//  Created by khanh-lam on 06/02/2023.
//

import Foundation

public extension CaseIterable where Self: Equatable {
    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
}
