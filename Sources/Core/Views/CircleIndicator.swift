//
//  File.swift
//  
//
//  Created by ExecutionLab's Macbook on 04/07/2022.
//

import SwiftUI

public struct CircleIndicator: View {
    var size: CGFloat = 50
    var value: Double
    var total: Double

    public var body: some View {
        ZStack {
            ForEach(0...7, id: \.self) { index in
                let rotation = Double(index) * 45.0 / 180
                let x = sin(rotation * Double.pi) * size / 3
                let y = -cos(rotation * Double.pi) * size / 3
                if value / total > Double(index) / 8.0 {
                    ActivityIndicator(delay: 0.1 * Double(index), duration: 0.8, isBlinking: value >= total)
                        .frame(width: size * 0.1, height: size * 0.3)
                        .rotationEffect(.init(degrees: Double(index * 45)))
                        .offset(x: x, y: y)
                }
            }
        }
        .frame(width: size, height: size)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CircleIndicator(value: 10, total: 100)
    }
}

struct ActivityIndicator: View {
    let delay: Double
    let duration: Double
    var isBlinking = false

    var body: some View {
        Capsule()
            .fill(.gray)
            .opacity(!isBlinking ? 0.8 : 0.0)
            .animation(.easeInOut(duration: duration).repeat(while: isBlinking).delay(delay), value: isBlinking)
    }
}
