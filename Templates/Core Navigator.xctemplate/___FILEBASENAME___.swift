//  ___VARIABLE_name:identifier___Navigator.swift
//  ___PACKAGENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import Combine
import Core

public enum ___VARIABLE_name:identifier___Step: Step {
    // Define steps
}

public protocol ___VARIABLE_name:identifier___Navigator: NavigatorModel, Stepper {
    // Define ViewModel/Navigators
    
}

public class ___VARIABLE_name:identifier___NavigatorImpl: ___VARIABLE_name:identifier___Navigator, ObservableObject, Resolving {
    // MARK: - Stored Properties
    
    // Stepper
    @Published public var rootViewId: UUID = .init()

    public var cancellables = Set<AnyCancellable>()
    public let steps = PassthroughSubject<Step, Never>()
    
    
    // MARK: - Initialization
    public init() {
        // - Example:
        // contribute(InitialViewModel)
    }
    
    // MARK: - Methods
    
    public func go(to step: Step) {
        guard let step = step as? ___VARIABLE_name:identifier___Step else { return }
        
//        - Example:
//        switch step {
//        case .fakeDetailStep:
//            detailNavigator = resolve(DetailNavigator.self, argument: some_id)
//            contribute(detailNavigator)
//            return
//        }
    }
}
