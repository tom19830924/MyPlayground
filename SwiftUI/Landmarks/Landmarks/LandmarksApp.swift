//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by user on 2024/1/3.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
