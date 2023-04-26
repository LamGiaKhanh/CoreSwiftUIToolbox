//  ___VARIABLE_name:identifier___ViewModel.swift
//  ___PACKAGENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Combine
import Core

public class ___VARIABLE_name:identifier___ViewModel: StepperViewModel & StateViewModel, ObservableObject{
    
    // MARK: - Stored Properties
    
    // Services
    
    // Stepper
    public var cancellables = Set<AnyCancellable>()
    public let steps = PassthroughSubject<Step, Never>()
    
    // State
    @Published public var state: LoadingState  = .loaded
    @Published public var isLoading: Bool = false
    
    // Toast
    @Published public var toastMessage: String?
    
    // MARK: - Initialization
    public init() {}
    
    // MARK: - Methods
}
