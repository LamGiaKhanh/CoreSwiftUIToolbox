//
//  UnstableView.swift
//  Core
//
//  Created by xuanbach on 10/06/2022.
//

import SwiftUI

public struct UnstableView<Content: View, Empty: View, Failure: View>: View {
    public init(state: LoadingState, isLoading: Bool, contentView: @escaping () -> Content, emptyView: @escaping () -> Empty, failureView: @escaping (Error) -> Failure) {
        self.state = state
        self.isLoading = isLoading
        self.contentView = contentView
        self.emptyView = emptyView
        self.failureView = failureView
    }
    
    public let state: LoadingState
    public let isLoading: Bool
    public let contentView: () -> Content
    public let emptyView: () -> Empty
    public let failureView: (Error) -> Failure
    
    public var body: some View {
        ZStack {
            switch state {
            case .initial:
                emptyView()
            case .loaded:
                contentView()
            case .failure(let error):
                failureView(error)
            }
            
            if isLoading {
                Color.black.opacity(0.66).ignoresSafeArea()
                ProgressView()
                    .scaleEffect(1.5)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
        }
    }
}

public extension UnstableView where Empty == Text, Failure == Text {
    init(state: LoadingState, isLoading: Bool, contentView: @escaping () -> Content) {
        self.init(
            state: state,
            isLoading: isLoading,
            contentView: contentView,
            emptyView: { Text("") },
            failureView: { error in Text(error.localizedDescription) }
        )
    }
}

public extension UnstableView where Failure == Text {
    init(state: LoadingState, isLoading: Bool, contentView: @escaping () -> Content, emptyView: @escaping () -> Empty) {
        self.init(
            state: state,
            isLoading: isLoading,
            contentView: contentView,
            emptyView: emptyView,
            failureView: { error in Text(error.localizedDescription) }
        )
    }
}

public extension UnstableView where Empty == Text {
    init(state: LoadingState, isLoading: Bool, contentView: @escaping () -> Content, failureView: @escaping (Error) -> Failure) {
        self.init(
            state: state,
            isLoading: isLoading,
            contentView: contentView,
            emptyView: { Text("") },
            failureView: failureView
        )
    }
}


public struct UnstableModifier<Empty: View>: ViewModifier {
    
    public let state: LoadingState
    public let isLoading: Bool
    public let emptyView: () -> Empty
    
    public func body(content: Content) -> some View {
        UnstableView(state: state, isLoading: isLoading) {
            content
        } emptyView: {
            emptyView()
        }
    }
}

public extension View {
    func unstable(state: LoadingState, isLoading: Bool) -> some View {
        self.modifier(UnstableModifier(state: state, isLoading: isLoading, emptyView: { Text("") }))
    }
    
    func unstable<Empty: View>(state: LoadingState, isLoading: Bool, emptyView: @escaping () -> Empty) -> some View {
        self.modifier(UnstableModifier(state: state, isLoading: isLoading, emptyView: emptyView))
    }
}
