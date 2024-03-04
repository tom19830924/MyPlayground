//
//  OverlaySheet.swift
//  PokeMaster
//
//  Created by user on 2024/3/4.
//

import SwiftUI

struct OverlaySheet<CustomContent: View>: ViewModifier {
    private let isPresented: Binding<Bool>
    private let makeContent: () -> CustomContent
    @GestureState private var translation = CGPoint.zero
    
    init(isPresented: Binding<Bool>, makeContent: @escaping () -> CustomContent) {
        self.isPresented = isPresented
        self.makeContent = makeContent
    }
    
    
    func body(content: Content) -> some View {
        content
            .overlay {
                VStack {
                    Spacer()
                    makeContent()
                }
                .offset(y: (isPresented.wrappedValue ? 0 : UIScreen.main.bounds.height) + max(0, translation.y))
                .animation(.interpolatingSpring(stiffness: 70, damping: 12))
                .edgesIgnoringSafeArea(.bottom)
                .gesture(panelDraggingGesture)
            }
    }
    
    var panelDraggingGesture: some Gesture {
        DragGesture()
            .updating($translation) { current, state, _ in
                state.y = current.translation.height
            }
            .onEnded { state in
                if state.translation.height > 250 {
                    self.isPresented.wrappedValue = false
                }
            }
    }

}

extension View {
    func overlaySheet<CustomContent: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping() -> CustomContent) -> some View {
        modifier(OverlaySheet(isPresented: isPresented, makeContent: content))
    }
}
