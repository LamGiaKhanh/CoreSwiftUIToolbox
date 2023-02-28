//
//  File.swift
//  
//
//  Created by xuanbach on 05/10/2022.
//

import Foundation

public extension Optional where Wrapped == Int {
    var unwrap: Wrapped {
        self ?? 0
    }
}

public extension Optional where Wrapped == Double {
    var unwrap: Wrapped {
        self ?? 0.0
    }
}
