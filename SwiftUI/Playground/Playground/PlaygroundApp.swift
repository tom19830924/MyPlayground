//
//  PlaygroundApp.swift
//  Playground
//
//  Created by user on 2024/3/22.
//

import SwiftUI

@main
struct PlaygroundApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
