//
//  HistoryView.swift
//  Calculator
//
//  Created by user on 2024/1/5.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var model: CalculatorModel
    
    var body: some View {
        VStack {
            if model.totalCount == 0 {
                Text("沒有歷程")
            }
            else {
                HStack {
                    Text("歷程").font(.headline)
                    Text("\(model.historyDetail)").lineLimit(nil)
                }
                HStack {
                    Text("显示").font(.headline)
                    Text("\(model.brain.output)")
                }
                Slider(value: $model.slidingIndex, 
                       in: 0...Float(model.totalCount),
                       step: 1
                )
            }
        }.padding()
    }
}

#Preview {
    let model = CalculatorModel()
    return HistoryView(model: model)
}
