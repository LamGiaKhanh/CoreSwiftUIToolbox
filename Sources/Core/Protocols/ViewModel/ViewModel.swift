//
//  ViewModel.swift
//  Common
//
//  Created by Phat Le on 27/04/2022.
//

import Combine
import SwiftUI

public protocol AnyObservableObject: AnyObject {
    var objectWillChange: ObservableObjectPublisher { get }
}

public protocol ViewModel: AnyObservableObject {}

public protocol NavigatorModel: Navigator & ViewModel {}

public enum LoadingState: Equatable {
    case initial
//    case loading
    case loaded
    case failure(Error)
}

extension LoadingState {
    public static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
//        case (.loading, .loading):
//            return true
        case (.loaded, .loaded):
            return true
        case (.failure, .failure):
            return true
        default:
            return false
        }
    }
}

public protocol StateViewModel: ViewModel {
    var state: LoadingState { get set }
    var isLoading: Bool { get set }
}

public extension StateViewModel {
    func loaded() {
        state = .loaded
        isLoading = false
    }
    
    func loading() {
        isLoading = true
    }
}

public protocol StepperViewModel: ViewModel & Stepper {}

public protocol Refreshable {
    func reload()
}

public protocol Toastable {
    var toastMessage: String? { get set }
    var shouldShowToast: Bool { get set }
}
