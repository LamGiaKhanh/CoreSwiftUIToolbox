//
//  GlobalStep.swift
//  Core
//
//  Created by ExecutionLab's Macbook on 19/06/2022.
//

import Foundation

public enum GlobalStep: Step {
    case noneStep
    case cart
    case signIn
    case signUp
    case dismissCart
    case dismissSignIn
    case signInSuccess
    case popToRoot
    case switchTab(Int)
    case navigateToProfile
}

public enum GlobalPreStep: Step {
    case initial
    case products
    case detailedProduct
    case shops
    case account
}
