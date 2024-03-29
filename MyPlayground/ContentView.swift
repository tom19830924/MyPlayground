//
//  ContentView.swift
//  AAAA
//
//  Created by user on 2023/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 25) {
            sfSymbolWithLabel("person.fill")
            sfSymbolWithLabel("house.fill")
        }
    }
    
    private func sfSymbolWithLabel(_ name: String) -> some View {
        HStack {
            Group {
                Image(systemName: name)
                Text(name)
            }
            .font(.system(size: 30))
            .foregroundColor(.blue)
        }
    }
}

#Preview {
    ContentView()
}
