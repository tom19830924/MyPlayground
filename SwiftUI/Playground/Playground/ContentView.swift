//
//  ContentView.swift
//  Playground
//
//  Created by user on 2024/3/22.
//

import SwiftUI

struct ContentView: View {
    @State private var counter: Int = 0
    
    var body: some View {
        Button("Tap") {
            counter += 1
        }
        LabelView(counter: $counter)
    }
}

struct LabelView: View {
    @Binding var counter: Int
    
    @ViewBuilder
    var helper1: some View {
        if counter > 0 {
            Text("You've tapped \(counter) times")
        }
    }
    
//    @ViewBuilder
    var helper2: some View {
        if counter > 0 {
            AnyView(Text("You've tapped \(counter) times"))
        } else {
            AnyView(Image(systemName: "lightbulb"))
        }
    }
    
    var body: some View {
        helper1
        helper2
            .debug()
        
    }
}


#Preview {
    ContentView()
}

