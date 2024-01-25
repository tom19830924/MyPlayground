//: [Previous](@previous)
import Foundation
import Combine
import UIKit
import SwiftUI

func printElapsedTime(from: Date) {
    print(String(format: "完成任務時間過過 %.6f 秒", Date.now.timeIntervalSince(from)))
}

let startTime = Date.now
let totolWorkers = 10
var finishWorking = 0

func work(name: String) async throws {
    print(Thread.current)
    print("\(name) 1️⃣ 開始工作")
    try await Task.sleep(for: .seconds(0))
    Task {
        print("\(name) 2️⃣ 午休時間")
        try await Task.sleep(for: .seconds(0))
        print("\(name) 3️⃣ 睡飽了")
    }
    print("\(name) 4️⃣ 繼續工作")
    try await Task.sleep(for: .seconds(0))
    print("\(name) 5️⃣ 下班")
    
    await MainActor.run {
        finishWorking += 1
        print(Thread.current, finishWorking)
        if finishWorking == totolWorkers {
            printElapsedTime(from: startTime)
        }
    }
    
}

for number in 1...totolWorkers {
    Task {
        try! await work(name: "員工 \(number) 號")
    }
}

//: [Next](@next)
