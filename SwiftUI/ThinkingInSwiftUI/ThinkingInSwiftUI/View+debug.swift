//
//  View+debug.swift
//  ThinkingInSwiftUI
//
//  Created by user on 2024/4/22.
//

import SwiftUI

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
