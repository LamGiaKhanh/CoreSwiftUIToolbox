//
//  TabBarModifier.swift
//  Core
//
//  Created by xuanbach on 01/07/2022.
//

import SwiftUI
import UIKit.UITabBar

public struct ShowTabBarModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .onAppear {
                UITabBar.showTabBar()
            }
    }
}

public struct HideTabBarModifier: ViewModifier {
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                UITabBar.hideTabBar()
            }
            .padding(.bottom, AppConstants.safeAreaInsets.bottom)
            .ignoresSafeArea(edges: .bottom)
    }
}

public extension View {
    func showTabBar() -> some View {
        self.modifier(ShowTabBarModifier())
    }
    
    func hideTabBar() -> some View {
        self.modifier(HideTabBarModifier())
    }
}
