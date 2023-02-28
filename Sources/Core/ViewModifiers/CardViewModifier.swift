//
//  CardViewModifier.swift
//  Core
//
//  Created by ExecutionLab's Macbook on 09/06/2022.
//

import Foundation
import SwiftUI

public struct CardViewModifier: ViewModifier {

    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    let cornerRadius: CGFloat
    
    public init(horizontalPadding: CGFloat, verticalPadding: CGFloat, cornerRadius: CGFloat) {
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.cornerRadius = cornerRadius
    }

    public func body(content: Content) -> some View {
        content
            .padding(.init(top: verticalPadding, leading: horizontalPadding, bottom: verticalPadding, trailing: horizontalPadding))
            .background(Color.white)
            .cornerRadius(cornerRadius)
            .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 8)
    }
}

public extension View {
    func concardify(space: CGFloat = 16, cornerRadius: CGFloat = 8) -> some View {
        self.modifier(CardViewModifier(horizontalPadding: space, verticalPadding: space, cornerRadius: cornerRadius))
    }
    
    func concardify(horizontalPadding: CGFloat, verticalPadding: CGFloat, cornerRadius: CGFloat = 8) -> some View {
        self.modifier(CardViewModifier(horizontalPadding: horizontalPadding, verticalPadding: verticalPadding, cornerRadius: cornerRadius))
    }
}
