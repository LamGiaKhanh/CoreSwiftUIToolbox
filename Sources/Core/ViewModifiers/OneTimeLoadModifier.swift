//
//  OneTimeLoadModifier.swift
//  Core
//
//  Created by xuanbach on 01/07/2022.
//

import SwiftUI

public struct OneTimeLoadModifier: ViewModifier {
    
    public var onFirstAppear: () -> Void
    @State private var isLoaded = false
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                if !isLoaded {
                    onFirstAppear()
                    self.isLoaded = true
                }
            }
    }
}

public extension View {
    func onFirstAppear(_ onFirstAppear: @escaping () -> Void) -> some View {
        self.modifier(OneTimeLoadModifier(onFirstAppear: onFirstAppear))
    }
}
