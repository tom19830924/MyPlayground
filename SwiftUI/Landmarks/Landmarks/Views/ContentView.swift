//
//  ContentView.swift
//  Landmarks
//
//  Created by user on 2024/1/3.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
