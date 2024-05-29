//
//  Builder.swift
//  ResultBuilder
//
//  Created by user on 2024/3/29.
//

import Foundation

@resultBuilder
struct Builder {
    static func buildBlock(_ components: String...) -> String {
        components.reduce("", +)
    }
}
