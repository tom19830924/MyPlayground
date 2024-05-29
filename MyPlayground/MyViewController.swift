//
//  MyViewController.swift
//  MyPlayground
//
//  Created by user on 2024/3/29.
//

import UIKit
import SwiftUI

struct MyView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return MyViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        let button = UIButton(type: .system)
        button.setTitle("Button", for: .normal)
        view.addSubview(button) { view, button in
            [
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ]
        }
    }
}

extension UIView {
    func addSubview(_ view: UIView, constraints: (UIView, UIView) -> [NSLayoutConstraint]) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        NSLayoutConstraint.activate(constraints(view, self))
    }
}

#Preview {
    MyViewController()
}
