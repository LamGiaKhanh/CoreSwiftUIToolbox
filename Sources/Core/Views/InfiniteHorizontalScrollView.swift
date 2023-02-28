//
//  File.swift
//  
//
//  Created by ExecutionLab's Macbook on 08/07/2022.
//

import Foundation
import SwiftUI

public struct InfiniteHorizontalScrollView<Content>: View where Content: View {
    let content: () -> Content
    private var isLoading: Bool
    private var onLoadmore: (() -> Void)?
    @State private var dragViewOffset: CGFloat = .zero
    private var limitOffset: CGFloat = 100
    @Namespace private var scrollSpaceX
    
    public init(isLoading: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.isLoading = isLoading
        self.content = content
    }
    
    public func doOnLoadmore(_ onLoadmore: @escaping () -> Void) -> Self {
        return transform {
            $0.onLoadmore = onLoadmore
        }
    }
    
    func transform(_ action: (inout Self) -> Void) -> Self {
        var _self = self
        action(&_self)
        return _self
    }
    
    public var body: some View {
        buildBody()
    }
    
    func buildBody() -> some View {
        ZStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                ZStack(alignment: .trailing) {
                    content()
                    buildLoadingView()
                }
                .overlay(GeometryReader { geo in
                    let size = geo.frame(in: .named(scrollSpaceX))
                    
                    let value = MinMaxXOffser(minX: size.minX, maxX: size.maxX)
                    Color.clear
                        .preference(key: ScrollViewXOffsetPreferenceKey.self,
                                    value: value)
                })
            }
            .coordinateSpace(name: scrollSpaceX)
            .onPreferenceChange(ScrollViewXOffsetPreferenceKey.self) { geo in
                // loadmore
                if geo.maxX < UIScreen.main.bounds.height && abs(geo.minX) > 100 {
                    onLoadmore?()
                }
            }
        }
    }
    
    @ViewBuilder
    func buildLoadingView() -> some View {
        if isLoading {
            ProgressView()
                .offset(x: 0, y: limitOffset)
        }
    }
}

struct ScrollViewXOffsetPreferenceKey: PreferenceKey {
    static var defaultValue = MinMaxXOffser(minX: 0, maxX: 0)
    
    static func reduce(value: inout MinMaxXOffser, nextValue: () -> MinMaxXOffser) {
        value.minX = nextValue().minX
        value.maxX = nextValue().maxX
    }
}

struct MinMaxXOffser: Equatable {
    var minX: CGFloat
    var maxX: CGFloat
}
