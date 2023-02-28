//
//  XBMap.swift
//  
//
//  Created by xuanbach on 13/10/2022.
//

import Foundation

public class MapableList<Key: Hashable, Value> {
    private var dictionary: [Key: Int] = [:]
    public private(set) var values: [Value] = []
    
    public init() {}
    
    public subscript(key: Key) -> Value {
        get {
            let index = dictionary[key]!
            return values[index]
        }
        set(newValue) {
//            guard let newValue else { return }
            appendOrReplace(key: key, value: newValue)
        }
    }
    
    public func appendOrReplace(key: Key, value: Value) {
        if let index = dictionary[key] {
            values[index] = value
        } else {
            dictionary.updateValue(values.count, forKey: key)
            values.append(value)
        }
    }
    
//    public func makeIterator() -> DictionaryIterator<Key, Value> {
//        return dictionary.map { (key: Hashable, value: Int) in
//            (key, values[value])
//        }
////        .makeIterator()
//    }
}
