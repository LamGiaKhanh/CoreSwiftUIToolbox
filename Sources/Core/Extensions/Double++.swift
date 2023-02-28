//
//  File.swift
//  
//
//  Created by ExecutionLab's Macbook on 05/08/2022.
//

import Foundation

extension Locale {
    static let br = Locale(identifier: "pt_BR")
    static let us = Locale(identifier: "en_US")
    static let uk = Locale(identifier: "en_GB") // ISO Locale
}

public extension Double {
    var usdFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .us
        formatter.maximumFractionDigits = 2

        let number = NSNumber(value: self)
        var formattedValue = formatter.string(from: number) ?? ""
        
        while formattedValue.last == "0" {
            formattedValue.removeLast()
        }

        if formattedValue.last == "." {
            formattedValue.removeLast()
        }
        return formattedValue
        
    }
}

public extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

public extension Double {
    func calculateDiscount(original: Double) -> Double {
        return Double(((original - self) / original) * 100).rounded(.toNearestOrAwayFromZero)
    }
    
    func stringDiscount(original: Double) -> String {
        return self.calculateDiscount(original: original).removeZerosFromEnd()
    }
}
