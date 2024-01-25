import Foundation
import Combine
import UIKit
import SwiftUI
import PlaygroundSupport

PlaygroundPage.current.setLiveView(ContentView())

struct ContentView: View {
    @SecondsFormat("ss") private var t1: String = "43200"
    
    
    var body: some View{
        Text($t1)
    }
}

let interval = TimeInterval(43200)
let formatter = DateComponentsFormatter()
formatter.allowedUnits = [.second]
formatter.zeroFormattingBehavior = .pad
//formatter.collapsesLargestUnit = true
print(formatter.string(from: interval) ?? "nil")

@propertyWrapper
struct SecondsFormat {
    
    var wrappedValue: String
    
    var projectedValue: String {
        guard var seconds = Float(wrappedValue) else {
            return ""
        }
        
        var res = format
        var minutes = floor(Float(seconds / 60))
        seconds -= minutes * 60
        
        let hours = floor(Float(minutes / 60))
        minutes -= hours * 60

        if res.contains("hh") {
            res = res.replacingOccurrences(of: "hh", with: prefix(.init(hours)))
        }
        else {
            minutes += hours * 60
        }
        
        if res.contains("mm") {
            res = res.replacingOccurrences(of: "mm", with: prefix(.init(minutes)))
        }
        else {
            seconds += minutes * 60
        }
        
        res = res.replacingOccurrences(of: "ss", with: prefix(.init(seconds)))
        return res
    }
    
    private let format: String
    
    init(wrappedValue: String, _ format: String = "mm:ss") {
        self.wrappedValue = wrappedValue
        self.format = format
    }
    
    private func prefix(_ value: Int) -> String {
        value > 9 ? "\(value)" : "0\(value)"
    }
}
