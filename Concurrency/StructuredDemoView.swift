//
//  StructuredDemoView.swift
//  MyPlayground
//
//  Created by user on 2023/12/28.
//

import SwiftUI

// MARK: - 不同語法寫法
extension StructuredDemoView {
    func asyncLetCooking() async {
        async let rice = 煮飯()
        async let fish = 蒸魚()
        do {
            try await 切菜()
            let vegetable = try await 炒菜()
            log("上菜囉 \(vegetable)\(try await rice)\(try await fish)")
        } catch {
            log("停止切菜，原因 \(error)")
        }
    }
    

    //    func taskCooking() async {
    //        var dishes = ""
    //        let callback = { @MainActor (dish: String) -> Void in
    //            dishes += dish
    //            if dishes.count == 3 {
    //                log("上菜囉 \(dishes)")
    //            }
    //        }
    //
    //        let rice = Task {
    //            do {
    //                let rice = try await 煮飯()
    //                await callback(rice)
    //            } catch {
    //                log("停止煮飯，原因:\(error)")
    //            }
    //        }
    //
    //        let fish = Task {
    //            do {
    //                let fish = try await 蒸魚()
    //                await callback(fish)
    //            } catch {
    //                log("停止蒸魚，原因:\(error)")
    //            }
    //        }
    //        Task {
    //            do {
    //                try await 切菜()
    //                let vegetable = try await 炒菜()
    //                await callback(vegetable)
    //            } catch {
    //                log("停止切菜，原因:\(error)")
    //                rice.cancel()
    //                fish.cancel()
    //            }
    //        }
    //    }
    
    func taskCooking() async {
        let rice = Task { try await 煮飯() }
        let fish = Task { try await 蒸魚() }
        let vegetable = Task {
            try await 切菜()
            return try await 炒菜()
        }
        do {
            log("上菜囉 \(try await vegetable.value)\(try await rice.value)\(try await fish.value)")
        } catch CookError.切到手 {
            rice.cancel()
            fish.cancel()
            log("已經取消蒸魚和煮飯")
        } catch {
            log("無法完成晚餐")
        }
    }
}

// MARK: - 料理相關方法
extension StructuredDemoView {
    enum CookError: Error, LocalizedError {
        case 切到手
        var errorDescription: String? {
            switch self {
            case .切到手:
                "切到手"
            }
        }
    }
    
    func 切菜() async throws {
        log("切菜")
        try await Task.sleep(seconds: 0.5)
        if 切到手 {
            log("⚠️ 我切到手了 馬上去醫院")
            throw CookError.切到手
        }
    }
    
    @discardableResult
    func 煮飯() async throws -> String {
        log("電鍋煮飯...")
        try await Task.sleep(seconds: 2)
        log("🍚 飯煮好了")
        return "🍚"
    }
    @discardableResult
    func 蒸魚() async throws -> String {
        log("電鍋蒸魚...")
        try await Task.sleep(seconds: 1)
        log("🐟 魚煮好了")
        return "🐟"
    }
    @discardableResult
    func 炒菜() async throws -> String {
        log("炒菜...")
        try await Task.sleep(seconds: 0.3)
        log("🥗 菜炒好了")
        return "🥗"
    }
}

struct StructuredDemoView: View {
    @State var 切到手 = false
    @State var logs: [String] = []
    @State var code: 語法 = .task
    
    enum 語法: String, CaseIterable {
        case asyncLet, task
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Toggle("切到手", isOn: $切到手)
            Picker("", selection: $code) {
                Text(語法.asyncLet.rawValue).tag(語法.asyncLet)
                Text(語法.task.rawValue).tag(語法.task)
            }
            .pickerStyle(.segmented)
            Button("Cook") {
                Task {
                    await cook()
                }
            }
            List($logs) { $item in
                Text(item)
            }
        }.padding()
    }
    
    func log(_ message: String) {
        Task { @MainActor in
            logs.append("\(logs.count + 1). \(message)")
        }
    }
    
    @Sendable func cook() async {
        logs = []
        switch code {
            case .asyncLet:
                await asyncLetCooking()
            case .task:
                await taskCooking()
        }
    }
}

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}

#Preview {
    StructuredDemoView()
}


