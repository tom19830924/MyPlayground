//
//  OverlaySheet.swift
//  PokeMaster
//
//  Created by user on 2024/3/4.
//

import SwiftUI

struct OverlaySheet<Content: View>: ViewModifier {
    private let isPresented: Binding<Bool>
    private let makeContent: () -> Content
    @GestureState private var translation = CGPoint.zero
    
    init(isPresented: Binding<Bool>, makeContent: @escaping () -> Content) {
        self.isPresented = isPresented
        self.makeContent = makeContent
    }
    
    func body(content: Self.Content) -> some View {
        content
            .overlay {
                VStack {
                    Spacer()
                    makeContent()
                }
                .offset(y: (isPresented.wrappedValue ? 0 : UIScreen.main.bounds.height) + max(0, translation.y))
                .animation(.interpolatingSpring(stiffness: 70, damping: 12), value: isPresented.wrappedValue)
                .ignoresSafeArea(edges: .bottom)
                .gesture(panelDraggingGesture)
            }
    }
    
    var panelDraggingGesture: some Gesture {
        DragGesture()
            .updating($translation) { current, state, _ in
                print(state)
                state.y = current.translation.height
            }
            .onEnded { state in
                if state.translation.height > 250 {
                    isPresented.wrappedValue = false
                }
            }
    }
}

extension View {
    func overlaySheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping() -> Content) -> some View {
        modifier(OverlaySheet(isPresented: isPresented, makeContent: content))
    }
}
