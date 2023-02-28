//
//  File.swift
//  
//
//  Created by xuanbach on 13/10/2022.
//

import Foundation

public typealias ValidatableField = String
public typealias ValidationError = String

/**
 `ValidationRule` is a class that creates an object which holds validation info of a field.
 */
public class Validator {
    public var value: ValidatableField
    public let rules: [Rule]
    
    // Error will be ignored for the first time the field shows up
    public private(set) var ignoreError: Bool = true
    
    /**
     Initializes `ValidationRule` instance with field, rules, and errorLabel.
     
     - parameter field: field that holds actual text in field.
     - parameter rules: array of Rule objects, which field will be validated against.
     - returns: An initialized `ValidationRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(value: ValidatableField, rules: [Rule]){
        self.value = value
        self.rules = rules
    }
    
    public init(required: ValidatableField){
        self.value = required
        self.rules = [RequiredRule()]
    }
    
    /**
     Used to validate field against its validation rules.
     - returns: `ValidationError` object if at least one error is found. Nil is returned if there are no validation errors.
     */
    public func validate() -> ValidationError? {
        ignoreError = false
        return rules.validate(value: self.value)
    }
}

public extension Array where Element == Rule {
    func validate(value: ValidatableField) -> ValidationError? {
        return filter{
            !$0.validate(value)
        }.map { rule -> ValidationError in
            rule.errorMessage()
        }.first
    }
}

/**
 The `ValidationError` class is used for representing errors of a failed validation. It contains the field, error label, and error message of a failed validation.
 */
//public class ValidationError: NSObject {
//    /// the Validatable field of the field
//    public let field: ValidatableField
//    /// the error message of the field
//    public let errorMessage:String
//
//    /**
//     Initializes `ValidationError` object with a field, errorLabel, and errorMessage.
//
//     - parameter field: Validatable field that holds field.
//     - parameter errorMessage: String that holds error message.
//     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
//     */
//    public init(field:ValidatableField, error: String){
//        self.field = field
//        self.errorMessage = error
//    }
//}
