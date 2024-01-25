//
//  CalculatorApp.swift
//  Calculator
//
//  Created by user on 2024/1/4.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(CalculatorModel())
        }
    }
}
