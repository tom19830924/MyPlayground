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
            Image(systemName: "person.fill")
                .font(.system(size: 30))
                .foregroundColor(.blue)
            Image(systemName: "house.fill")
                .font(.system(size: 30))
                .foregroundColor(.blue)
            MyView()
        }
    }
}

#Preview {
    ContentView()
}
