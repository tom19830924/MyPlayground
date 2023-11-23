//
//  PreviewWrapper.swift
//  MyPlayground
//
//  Created by user on 2023/11/6.
//

import SwiftUI

struct UIViewPreviewWrapper<T: UIView>: UIViewRepresentable {
    let view: T
    init(_ viewBuilder: @escaping () -> T) {
        view = viewBuilder()
    }
    
    func makeUIView(context: Context) -> UIView {
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
