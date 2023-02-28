//
//  ProcessScrollView.swift
//
//
//  Created by vitran on 17/06/2022.
//

import SwiftUI
import Resources

public struct CustomRefreshableScrollView<Content>: View, Mutation where Content: View {
    let content: () -> Content
    private var isLoading: Bool
    private var isRefreshing: Binding<Bool?>
    private var onRefresh: (() -> Void)?
    private var onLoadmore: (() -> Void)?
    @State private var dragViewOffset: CGFloat = .zero
    private var limitOffset: CGFloat = 100
    @Namespace private var scrollSpace

    public init(isLoading: Bool, isRefreshing: Binding<Bool?> = .constant(nil), @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.isLoading = isLoading
        self.isRefreshing = isRefreshing
    }

    public func doOnRefresh(_ onRefresh: @escaping () -> Void) -> Self {
        return mutate {
            $0.onRefresh = onRefresh
        }
    }

    public func doOnLoadmore(_ onLoadmore: @escaping () -> Void) -> Self {
        return mutate {
            $0.onLoadmore = onLoadmore
        }
    }

    public var body: some View {
        if #available(iOS 15.0, *) {
            buildViewForIOS15()
        } else {
            buildBody()
        }
    }


    @available(iOS 15.0, *)
    func buildViewForIOS15() -> some View {
        List {
            ZStack(alignment: .top) {
                content()

                buildLoadingView()
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .buttonStyle(PlainButtonStyle())
            .overlay(GeometryReader { geo in
                let size = geo.frame(in: .named(scrollSpace))
                let value = MinMaxOffset( min: size.minY, max: size.maxY )
                Color.clear
                    .preference(key: ScrollViewOffsetPreferenceKey.self,
                                value: value)
            })
        }
        .background(Color.clear)
        .refreshable {
            onRefresh?()
        }
        .listStyle(.plain)
        .coordinateSpace(name: scrollSpace)
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { offset in
            if offset.max < UIScreen.main.bounds.height && abs(offset.min) > 100 {
                onLoadmore?()
            }
        }
        .onAppear {
            UITableView.appearance().showsVerticalScrollIndicator = false
        }
    }

    func buildBody() -> some View {
        ZStack(alignment: .top) {
            if isRefreshing.wrappedValue != nil &&
               (dragViewOffset > 10) {
                CircleIndicator(size: 33, value: Double(dragViewOffset + 10), total: limitOffset)
            }

            ScrollView(showsIndicators: false) {
                ZStack(alignment: .top) {
                    content()
                        .animation(isRefreshing.wrappedValue == false ? .default : nil, value: isRefreshing.wrappedValue)
                        .padding(.top, isRefreshing.wrappedValue == true ? 50 : 0 )

                    buildLoadingView()
                }
                .overlay(GeometryReader { geo in
                    let size = geo.frame(in: .named(scrollSpace))

                    let value = MinMaxOffset( min: size.minY, max: size.maxY )
                    Color.clear
                        .preference(key: ScrollViewOffsetPreferenceKey.self,
                                    value: value)
                })
            }
            .coordinateSpace(name: scrollSpace)
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { offset in
                let minOffset = offset.min

                // loadmore
                if offset.max < UIScreen.main.bounds.height && abs(offset.min) > 100 {
                    onLoadmore?()
                }

                // pull to refresh
                guard onRefresh != nil else { return }
                guard minOffset >= 0 else { return }
                guard isRefreshing.wrappedValue == false else { return }

                if minOffset < 10 && dragViewOffset > limitOffset {
                    dragViewOffset = 0
                }

                if minOffset < limitOffset {
                    dragViewOffset = minOffset
                }

                guard minOffset > dragViewOffset else { return }

                if isRefreshing.wrappedValue != nil {
                    dragViewOffset = minOffset
                    if dragViewOffset > limitOffset && isRefreshing.wrappedValue != true {
                        onRefresh?()
                    }
                }
            }
        }
    }

    @ViewBuilder
    func buildLoadingView() -> some View {
        if isLoading {
            ProgressView()
                .offset(x: 0, y: limitOffset)
                .foregroundColor(AppColors.primary())
        }
    }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue = MinMaxOffset(min: 0, max: 0)

    static func reduce(value: inout MinMaxOffset, nextValue: () -> MinMaxOffset) {
        value = nextValue()
    }
}

struct MinMaxOffset: Equatable {
    var min: CGFloat
    var max: CGFloat
}
