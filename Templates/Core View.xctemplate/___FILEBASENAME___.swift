//  ___VARIABLE_name:identifier___View.swift
//  ___PACKAGENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import SwiftUI
import Core

public struct ___VARIABLE_name:identifier___Screen: View {
    
    // MARK: - Stored Properties
    @Store public var viewModel: ___VARIABLE_name:identifier___ViewModel
    
    // MARK: - Initialization
    public init(viewModel: ___VARIABLE_name:identifier___ViewModel) {
        _viewModel = Store(wrappedValue: viewModel)
    }
    
    // MARK: - Views
    public var body: some View {
        VStack {
            
        }
        .toastify(message: $viewModel.toastMessage)
        .unstable(state: viewModel.state, isLoading: viewModel.isLoading)
    }
}
