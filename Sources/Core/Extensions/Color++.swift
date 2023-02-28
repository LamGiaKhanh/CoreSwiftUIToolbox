//
//  Color++.swift
//  Core
//
//  Created by xuanbach on 09/06/2022.
//

import SwiftUI

public extension Color {
    init(_ hex: UInt32, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    static func randomColors(length: Int) -> [Color] {
        var colors: [Color] = []
        for _ in 0..<length {
            let randomRed = Double(arc4random()) / Double(UInt32.max)
            let randomGreen = Double(arc4random()) / Double(UInt32.max)
            let randomBlue = Double(arc4random()) / Double(UInt32.max)
            colors.append(Color(red: randomRed, green: randomGreen, blue: randomBlue))
        }
        return colors
    }
}
