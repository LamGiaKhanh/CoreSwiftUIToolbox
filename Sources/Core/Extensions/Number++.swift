//
//  Int++.swift
//  Core
//
//  Created by xuanbach on 09/06/2022.
//

import Foundation

public typealias HourMinuteSecond = (Int, Int, Int)

public extension Int {
    func toString() -> String {
        String(self)
    }

    func toString(_ numberOfDigit: Int = 2) -> String {
        String(format: "%02d", self)
    }
    
    func toQuantityString(unit: String, suffix: String = "s") -> String {
        "\(self) \(unit)\(self > 1 ? suffix : "")"
    }
    
    var data: Data {
        withUnsafeBytes(of: self.littleEndian) { Data($0) }
    }
    
    func toTimeString() -> HourMinuteSecond {
        let second = (self % 3600) % 60
        let minute = (self % 3600) / 60
        let hour = self / 3600
        
        return HourMinuteSecond(hour, minute, second)
    }
}

public extension Double {
    func toData() -> Data {
        withUnsafeBytes(of: self) { Data($0) }
    }
}
