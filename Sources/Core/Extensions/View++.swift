//
//  View++.swift
//  Common
//
//  Created by Phat Le on 28/04/2022.
//

import SwiftUI

// MARK: Navigation and present
public extension View {
    func onNavigation(_ action: @escaping () -> Void) -> some View {
        let isActive = Binding(
            get: { false },
            set: { newValue in
                if newValue {
                    action()
                }
            }
        )
        return NavigationLink(
            destination: EmptyView(),
            isActive: isActive
        ) {
            self
        }
    }
    
    func navigation<Model, Destination: View>(
        model: Binding<Model?>,
        condition: Bool = true,
        @ViewBuilder destination: (Model) -> Destination
    ) -> some View {
        let isActive = Binding(
            get: {
                model.wrappedValue != nil && condition
            },
            set: { value in
                if !value {
                    model.wrappedValue = nil
                }
            }
        )
        return navigation(isActive: isActive) {
            model.wrappedValue.map(destination)
        }
    }
    
    func navigation<Destination: View>(
        isActive: Binding<Bool>,
        @ViewBuilder destination: () -> Destination
    ) -> some View {
        overlay(
            NavigationLink(isActive: isActive, destination: {
                isActive.wrappedValue ? destination() : nil
            }, label: {
                EmptyView()
            })
        )
    }
    
    func sheet<Model, Content: View>(
        model: Binding<Model?>,
        @ViewBuilder content: @escaping (Model, Binding<Bool>) -> Content
    ) -> some View {
        let isPresented = model.asBool()
        return sheet(isPresented: isPresented) {
            model.wrappedValue.map {
                content($0, isPresented)
            }
        }
    }
    
    func fullScreenCover<Model, Content: View>(
        model: Binding<Model?>,
        @ViewBuilder content: @escaping (Model) -> Content
    ) -> some View {
        fullScreenCover(item: model.objectIdentifiable()) { _ in
            model.wrappedValue.map(content)
        }
    }
    
    func popover<Model, Content: View>(
        model: Binding<Model?>,
        @ViewBuilder content: @escaping (Model) -> Content
    ) -> some View {
        popover(item: model.objectIdentifiable()) { _ in
            model.wrappedValue.map(content)
        }
    }
}

// MARK: Others
public extension View {
    
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
    func hideNavigationBar(_ isHidden: Bool = true, withBackButton: Bool = true) -> some View {
        navigationBarTitle("") // this must be empty
            .navigationBarHidden(isHidden)
            .navigationBarBackButtonHidden(withBackButton)
    }
    
    func matchParent() -> some View {
        frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
    }

    func matchWidth() -> some View {
        frame(
            minWidth: 0,
            maxWidth: .infinity
        )
    }
    
    func matchWidthWithAlignment(_ alignment: Alignment) -> some View {
        frame(
            minWidth: 0,
            maxWidth: .infinity,
            alignment: alignment)
    }
    
    func matchHeight() -> some View {
        frame(
            minHeight: 0,
            maxHeight: .infinity
        )
    }
    
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
    
    func handleIsPresented(_ isPresented: Binding<Bool>,
                           onActive: @escaping (Binding<Bool>) -> Void,
                           onInactive: @escaping () -> Void) -> some View {
        onAppear {
            onActive(isPresented)
        }
        .onDisappear(perform: onInactive)
    }
}

// MARK: Hide Keyboard

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension UIApplication {
    public func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    public func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

struct ResignKeyboardOnTapGesture: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.endEditing(true)
            }
    }
}

extension View {
    public func resignKeyboardOnTapGesture() -> some View {
        return modifier(ResignKeyboardOnTapGesture())
    }
}
// -- MARK: Transparent background fullscreenCover
public extension View {
    func transparentFullScreenCover<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
        fullScreenCover(isPresented: isPresented) {
            ZStack {
                content()
            }
            .background(TransparentBackground())
        }
    }
    
    func blackoutFullScreenCover<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
        fullScreenCover(isPresented: isPresented) {
            ZStack {
                content()
            }
            .background(DarkBackground())
        }
    }
}

public struct TransparentBackground: UIViewRepresentable {
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {}
}

public struct DarkBackground: UIViewRepresentable {
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        }
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {}
}
