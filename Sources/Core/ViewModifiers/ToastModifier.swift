//
//  ToastModifier.swift
//  
//
//  Created by xuanbach on 09/08/2022.
//

import SwiftUI

public struct ToastModifier: ViewModifier {
    // these correspond to Android values f
    // or DURATION_SHORT and DURATION_LONG
    public static let short: TimeInterval = 2
    public static let long: TimeInterval = 3.5
    
    let message: String
    @Binding var isShowing: Bool
    let config: Config
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            toastView
        }
    }
    
    private var toastView: some View {
        VStack {
            Spacer()
            if isShowing {
                Group {
                    Text(message)
                        .multilineTextAlignment(.center)
                        .foregroundColor(config.textColor)
                        .font(config.font)
                        .padding(8)
                }
                .background(config.backgroundColor)
                .cornerRadius(8)
                .onTapGesture {
                    isShowing = false
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + config.duration) {
                        isShowing = false
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 18)
        .animation(config.animation, value: isShowing)
        .transition(config.transition)
    }
    
    public struct Config {
        public let textColor: Color
        public let font: Font
        public let backgroundColor: Color
        public let duration: TimeInterval
        public let transition: AnyTransition
        public let animation: Animation
        
        public init(textColor: Color = .white,
                    font: Font = .system(size: 14),
                    backgroundColor: Color = .black.opacity(0.588),
                    duration: TimeInterval = ToastModifier.short,
                    transition: AnyTransition = .opacity,
                    animation: Animation = .linear(duration: 0.3)) {
            self.textColor = textColor
            self.font = font
            self.backgroundColor = backgroundColor
            self.duration = duration
            self.transition = transition
            self.animation = animation
        }
    }
}

public extension View {
    
    func toastify(message: String,
                  isShowing: Binding<Bool>,
                  config: ToastModifier.Config = .init()) -> some View {
        self.modifier(ToastModifier(message: message,
                                    isShowing: isShowing,
                                    config: config))
    }
    
    func toastify(message: Binding<String?>, config: ToastModifier.Config = .init()) -> some View {
        self.modifier(ToastModifier(
            message: message.wrappedValue ?? "",
            isShowing: Binding(
                get: { message.wrappedValue != nil },
                set: { newValue in
                    if !newValue {
                        message.wrappedValue = nil
                    }
                }
            ),
            config: config))
    }
    
    func errorToastify(message: Binding<String?>) -> some View {
        self.toastify(message: message, config: .init(backgroundColor: .red.opacity(0.88)))
    }
    
    func toastify(message: String,
                  isShowing: Binding<Bool>,
                  duration: TimeInterval) -> some View {
        self.modifier(ToastModifier(message: message,
                                    isShowing: isShowing,
                                    config: .init(duration: duration)))
    }
}
