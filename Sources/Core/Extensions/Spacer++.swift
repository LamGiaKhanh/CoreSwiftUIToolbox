//
//  Spacer++.swift
//  Core
//
//  Created by xuanbach on 09/06/2022.
//

import SwiftUI

public extension View {
    func width(_ width: CGFloat) -> some View {
        self.frame(width: width)
    }
    
    func width(ratio: CGFloat, alignment: Alignment = .center) -> some View {
        self.frame(width: AppConstants.screenSize.width * ratio, alignment: alignment)
    }
    
    func height(_ height: CGFloat) -> some View {
        self.frame(height: height)
    }
    
    func size(_ size: CGFloat) -> some View {
        self.frame(width: size, height: size)
    }
}

extension Spacer {
    public func onTapGesture(count: Int = 1, perform action: @escaping () -> Void) -> some View {
        ZStack {
            Color.black.opacity(0.001).onTapGesture(count: count, perform: action)
            self
        }
    }
}
