//
//  Array++.swift
//  Core
//
//  Created by xuanbach on 19/06/2022.
//

import Foundation

public extension Array {
    mutating func appendSafely(_ newElement: Element?) {
        if let newElement = newElement {
            self.append(newElement)
        }
    }
    
//    func has(_ element: Element) -> Bool where Element: Equatable {
//        return contains { e in
//            e == element
//        }
//    }
}

public extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
    
    func has(_ element: Element) -> Bool {
        return contains { e in
            e == element
        }
    }
    
    mutating func removeFirst(where predicate: (Element) -> Bool) {
        if let index = firstIndex(where: predicate) {
            remove(at: index)
        }
    }
}
