//
//  CalculatorButtonRow.swift
//  Calculator
//
//  Created by user on 2024/1/4.
//

import SwiftUI

struct CalculatorButtonRow: View {
    let row: [CalculatorButtonItem]
    @EnvironmentObject var model: CalculatorModel
    
    var body: some View {
        HStack {
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title, 
                                 size: item.size,
                                 backgroundColorName: item.backgroundColorName,
                                 foregroundColor: item.foregroundColor) {
                    model.apply(item)
                }
            }
        }
    }
}

#Preview {
    let row: [CalculatorButtonItem] = [.digit(1), .digit(2), .digit(3), .op(.plus)]
    return CalculatorButtonRow(row: row)
}
