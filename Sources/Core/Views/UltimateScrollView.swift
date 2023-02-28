//
//  File.swift
//  
//
//  Created by ExecutionLab's Macbook on 24/08/2022.
//

import Foundation
import SwiftUIPullToRefresh
import SwiftUI

public struct UltimateScrollView<Content: View>: View, Mutation {
    let content: () -> Content
    let spacing: CGFloat
    private var onRefresh: VoidCallback?
    private var onLoadmore: VoidCallback?
    @Namespace private var ultimateScrollSpace
    
    
    @Binding public var canLoadmore: Bool
    
    public init(spacing: CGFloat = 12, canLoadmore: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._canLoadmore = canLoadmore
        self.content = content
        self.spacing = spacing
    }
    
    public func doOnRefresh(_ onRefresh: @escaping VoidCallback) -> Self {
        return mutate {
            $0.onRefresh = onRefresh
        }
    }
    
    public func doOnLoadmore(_ onLoadmore: @escaping VoidCallback) -> Self {
        return mutate {
            $0.onLoadmore = onLoadmore
        }
    }
    
    public var body: some View {
        if #available(iOS 15.0, *) {
            buildAsyncBody()
        } else {
            buildBody()
        }
    }
    
    @ViewBuilder
    private func buildBody() -> some View {
        RefreshableScrollView { done in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                onRefresh?()
                done()
            }
        } content: {
            content()
                .overlay(GeometryReader { geo in
                    let size = geo.frame(in: .named(ultimateScrollSpace))
                    
                    let value = MinMaxOffset(min: size.minY, max: size.maxY )
                    Color.clear
                        .preference(key: ScrollViewOffsetPreferenceKey.self,
                                    value: value)
                })
        }
        .coordinateSpace(name: ultimateScrollSpace)
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { offset in
            if offset.max < UIScreen.main.bounds.height && abs(offset.min) > 10 {
                onLoadmore?()
            }
        }
    }
    
    @available(iOS 15.0, *)
    @ViewBuilder
    private func buildAsyncBody() -> some View {
        RefreshableScrollView(action: { // HERE
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            onRefresh?()
        }, progress: { state in
            RefreshActivityIndicator(isAnimating: state == .loading) {
                $0.hidesWhenStopped = false
            }
        }) {
            content()
                .overlay(GeometryReader { geo in
                    let size = geo.frame(in: .named(ultimateScrollSpace))
                    
                    let value = MinMaxOffset( min: size.minY, max: size.maxY )
                    Color.clear
                        .preference(key: ScrollViewOffsetPreferenceKey.self,
                                    value: value)
                })
        }
        .coordinateSpace(name: ultimateScrollSpace)
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { offset in
            if offset.max < UIScreen.main.bounds.height && abs(offset.min) > 10 {
                onLoadmore?()
            }
        }
    }
}
