//
//  ContentView.swift
//  Calculator
//
//  Created by user on 2024/1/4.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: CalculatorModel
    @State private var editingHistory = false
    
    var body: some View {
        VStack(spacing: 12) {
            
            Spacer()
            Button("操作歷程: \(model.history.count)") {
                self.editingHistory = true
            }.sheet(isPresented: self.$editingHistory) {
                HistoryView(model: self.model)
            }
            Text(model.brain.output)
                .font(.system(size: 76))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .trailing)
            CalculatorButtonPad()
                .padding(.bottom)
        }
    }
}

#Preview {
    ContentView().environmentObject(CalculatorModel())
}
