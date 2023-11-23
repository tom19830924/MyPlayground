//
//  File.swift
//  MyPlayground
//
//  Created by user on 2023/11/6.
//

import SwiftUI

struct UIViewControllerWrapper<T: UIViewController>: UIViewControllerRepresentable {
    let viewController: T
        
    init(_ viewControllerBuilder: @escaping () -> T) {
        self.viewController = viewControllerBuilder()
    }
    func makeUIViewController(context: Context) -> some UIViewController {
        return viewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
