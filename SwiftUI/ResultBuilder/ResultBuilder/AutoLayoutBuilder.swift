//
//  AutoLayoutBuilder.swift
//  ResultBuilder
//
//  Created by user on 2024/3/29.
//

import UIKit

@resultBuilder
class AutoLayoutBuilder {
    //    static func buildBlock(_ components: NSLayoutConstraint...) -> [NSLayoutConstraint] {
    //        components
    //    }
    
    static func buildBlock(_ components: [NSLayoutConstraint]...) -> [NSLayoutConstraint] {
        components.flatMap { $0 }
    }
    
    static func buildExpression(_ expression: NSLayoutConstraint) -> [NSLayoutConstraint] {
        [expression]
    }
    
    static func buildExpression(_ expression: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        expression
    }
    
    static func buildOptional(_ component: [NSLayoutConstraint]?) -> [NSLayoutConstraint] {
        component ?? []
    }
    
    static func buildEither(first components: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        components
    }
    
    static func buildEither(second components: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        components
    }
    
    static func buildArray(_ components: [[NSLayoutConstraint]]) -> [NSLayoutConstraint] {
        components.flatMap { $0 }
    }
}

extension NSLayoutConstraint {
    static func activate(@AutoLayoutBuilder constraints: () -> [NSLayoutConstraint]) {
        activate(constraints())
    }
}

protocol Subviewcontaining {}
extension UIView: Subviewcontaining {}

extension Subviewcontaining where Self == UIView {
    func addSubview<View: UIView>(_ view: View, @AutoLayoutBuilder constraints: (Self, View) -> [NSLayoutConstraint]) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate(constraints(self, view))
    }
}
