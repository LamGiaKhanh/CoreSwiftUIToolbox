//
//  Dictionary++.swift
//  Common
//
//  Created by Phat Le on 05/04/2022.
//

import Foundation

public extension Dictionary {
    mutating func append(_ dic: [Key: Value]?) {
        guard let dic = dic else { return }
        for (k, v) in dic {
            updateValue(v, forKey: k)
        }
    }
    
    mutating func appendSafety(key: Key, value: Value?) {
        guard let value = value else { return }
        self.updateValue(value, forKey: key)
    }
    
    mutating func appendSafety(_ dic: [Key: Value?]) {
        for (k, v) in dic {
            if let v = v {
                updateValue(v, forKey: k)
            }
        }
    }
    
    init(_ optionalValueDic: [Key: Value?]) {
        self.init()
        for (k, v) in optionalValueDic {
            if let v = v {
                self.updateValue(v, forKey: k)
            }
        }
    }
}
