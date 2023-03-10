//
//  Binding++.swift
//  Common
//
//  Created by Phat Le on 28/04/2022.
//

import SwiftUI

public extension Binding {
    func objectIdentifiable<T>() -> Binding<ObjectIdentifiable?> where Value == T? {
        .init(
            get: {
                wrappedValue.map { value in
                    ObjectIdentifiable(value)
                }
            },
            set: { newValue in
                if newValue == nil {
                    wrappedValue = nil
                }
            }
        )
    }
    
    func asBool<T>() -> Binding<Bool> where Value == T? {
        .init(
            get: { wrappedValue != nil },
            set: { value in
                if !value {
                    wrappedValue = nil
                }
            }
        )
    }
}

public extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

public struct ObjectIdentifiable: Identifiable {
    public var id: ObjectIdentifier

    public init(_ object: Any) {
        self.id = ObjectIdentifier(object as AnyObject)
    }
}
