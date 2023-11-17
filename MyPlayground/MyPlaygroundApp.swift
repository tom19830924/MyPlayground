//
//  MyPlaygroundApp.swift
//  MyPlayground
//
//  Created by user on 2023/8/31.
//

import SwiftUI
import SpriteKit

@main
struct MyPlaygroundApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
