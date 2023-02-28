//
//  AssuranceValidation.swift
//  
//
//  Created by xuanbach on 13/10/2022.
//

import Foundation
import UIKit

public protocol AssuranceValidation {
    var label: String { get }
        
    var placeholder: String? { get }
        
    var navigatable: Bool { get }
        
    var keyboardType: UIKeyboardType { get }
        
    var rules: [Rule]? { get }
}

public extension AssuranceValidation {
    
    var placeholder: String? { nil }
    
    var navigatable: Bool { false }
    
    var keyboardType: UIKeyboardType { .default }
    
    var rules: [Rule]? { nil }
}
