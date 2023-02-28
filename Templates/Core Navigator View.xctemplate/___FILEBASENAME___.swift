//  ___VARIABLE_name:identifier___NavigatorView.swift
//  ___PACKAGENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//


import SwiftUI
import Core

public struct ___VARIABLE_name:identifier___NavigatorView: View {
    @Store public var navigator: ___VARIABLE_name:identifier___Navigator
    
    public init(navigator: ___VARIABLE_name:identifier___Navigator) {
        _navigator = Store(wrappedValue: navigator)
    }
    
    public var body: some View {
        
    }
}
