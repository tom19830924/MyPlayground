//
//  ContentView.swift
//  ThinkingInSwiftUI
//
//  Created by user on 2024/4/22.
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    
    var body: some View {
        VStack {
            Button(action: {
                counter += 1
            }, label: {
                Text("Tap me!")
                    .padding()
                    .background(Color(.tertiarySystemFill))
                    .cornerRadius(5)
            })
            
            if counter > 0 {
                Text("You've tapped \(counter) times")
            } else {
                Text("You've not yet tapped")
            }
        }.debug()
    }
}

#Preview {
    ContentView()
}
