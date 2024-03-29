//
//  ShapeStyleView.swift
//  FoodPicker
//
//  Created by user on 2024/1/23.
//

import SwiftUI

struct ShapeStyleView: View {
    var body: some View {
        VStack {
            Circle().fill(.teal)
            Circle().fill(.teal.gradient)
            
            Circle().fill(.yellow)
            
            Circle().fill(.image(.init(.dinner), scale: 0.2))
                .zIndex(1)
            
            Text("Hello")
                .font(.system(size: 100).bold())
                .foregroundStyle(.linearGradient(colors: [.pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
                .background { Color.bg2.scaleEffect(x: 1.5, y: 1.3).blur(radius: 20) }
            
            Circle().fill(.teal)
            Circle().fill(.teal.gradient)
            Circle().fill(.teal)
            Circle().fill(.teal.gradient)
            Circle().fill(.teal)
            Circle().fill(.teal.gradient)
        }
    }
}

#Preview {
    ShapeStyleView()
}
