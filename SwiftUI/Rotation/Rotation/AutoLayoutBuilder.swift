//
//  AutoLayoutBuilder.swift
//  Rotation
//
//  Created by user on 2024/3/29.
//

import UIKit

@resultBuilder
struct AutoLayoutBuilder {
    static func buildBlock(_ components: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        return components
    }
}
