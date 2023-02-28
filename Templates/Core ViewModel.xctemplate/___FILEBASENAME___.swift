//  ___VARIABLE_name:identifier___ViewModel.swift
//  ___PACKAGENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Combine
import Core

public protocol ___VARIABLE_name:identifier___ViewModel {
    
}

public class ___VARIABLE_name:identifier___ViewModelImpl: ___VARIABLE_name:identifier___ViewModel, ObservableObject {
    
    // MARK: - Stored Properties
    
    // Services
    
    // Stepper
    public var cancellables = Set<AnyCancellable>()
    public let steps = PassthroughSubject<Step, Never>()
    
    // State
    @Published public var state: LoadingState  = .loaded
    @Published public var isLoading: Bool = false
    
    // Toast
    public var toastMessage: String?
    @Published public var shouldShowToast: Bool = false
    
    // MARK: - Initialization
    public init() {}
    
    // MARK: - Methods
}
