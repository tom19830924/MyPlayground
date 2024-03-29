//
//  CalculatorButton.swift
//  Calculator
//
//  Created by user on 2024/1/4.
//

import SwiftUI

struct CalculatorButton: View {
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let foregroundColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundStyle(foregroundColor)
                .frame(width: size.width, height: size.height)
                .background(Color(backgroundColorName))
                .clipShape(RoundedRectangle(cornerRadius: size.width / 2))
        }
    }
}

#Preview {
    let digit0 = CalculatorButtonItem.digit(0)
    let digit1 = CalculatorButtonItem.digit(1)
    let clear = CalculatorButtonItem.command(.clear)
    let divide = CalculatorButtonItem.op(.divide)
    
    return Group {
        CalculatorButton(title: digit0.title, size: digit0.size, backgroundColorName: digit0.backgroundColorName, foregroundColor: digit0.foregroundColor, action: {})
        CalculatorButton(title: digit1.title, size: digit1.size, backgroundColorName: digit1.backgroundColorName, foregroundColor: digit1.foregroundColor,action: {})
        CalculatorButton(title: clear.title, size: clear.size, backgroundColorName: clear.backgroundColorName, foregroundColor: clear.foregroundColor,action: {})
        CalculatorButton(title: divide.title, size: divide.size, backgroundColorName: divide.backgroundColorName, foregroundColor: divide.foregroundColor,action: {})
    }
}
