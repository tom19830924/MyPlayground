import SwiftUI

enum CookError: Error, LocalizedError {
    case 切到手
    var errorDescription: String? {
        switch self {
        case .切到手:
            "切到手"
        }
    }
}
extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}

struct ChaoCodeView: View {
    @State var items: [String] = []
    @State private var message: String = ""
    @State var 切到手 = false
    @State var code: 語法 = .asyncLet
    
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
            Button("HTTP Fetch") {
                clear()
                Task {
                    await fetch()
                }
            }
            List($items) { $item in
                Text(item)
            }
            Text(message)
        }.padding()
    }
    func clear() {
        message = ""
        items = []
    }
    func fetch() async {
        switch code {
        case .asyncLet:
            await asyncLetCooking()
        case .task:
            await taskCooking()
        }
    }
    func log(_ content: String) {
        items.append(content)
    }
    func fetchEcho(echo: String) async throws -> String {
        let url = URL(string: "http://localhost:8080/\(echo)")!
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = String(data: data, encoding: .utf8)
        return result ?? ""
    }
}

extension ChaoCodeView {
    @discardableResult
    func 煮飯() async throws -> String {
        log("電鍋煮飯...")
        _ = try await fetchEcho(echo: "煮飯")
        log("🍚 飯煮好了")
        return "🍚"
    }
    @discardableResult
    func 蒸魚() async throws -> String {
        log("電鍋蒸魚...")
        _ = try await fetchEcho(echo: "蒸魚")
        log("🐟 魚煮好了")
        return "🐟"
    }
    @discardableResult
    func 切菜() async throws -> String {
        try log(await fetchEcho(echo: "切菜"))
        if 切到手 {
            log("⚠️ 我切到手了 馬上去醫院")
            throw CookError.切到手
        }
        return "切菜"
    }
    @discardableResult
    func 炒菜() async throws -> String {
        log("炒菜")
        _ = try await fetchEcho(echo: "炒菜")
        log("🥗 菜炒好了")
        return "🥗"
    }
    
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
        
//        var dishes = ""
//        let callback = { @MainActor (dish: String) -> Void in
//            dishes += dish
//            if (dishes.count == 3) {
//                log("上菜囉 \(dishes)")
//            }
//        }
//        let rice = Task {
//            do {
//                let rice = try await 煮飯()
//                await callback(rice)
//            } catch {
//                log("停止煮飯，原因：\(error.localizedDescription)")
//            }
//        }
//        
//        let fish = Task {
//            do {
//                let fish = try await 蒸魚()
//                await callback(fish)
//            } catch {
//                log("停止蒸魚，原因：\(error.localizedDescription)")
//            }
//            
//        }
//        Task {
//            do {
//                try await 切菜()
//                let vegetable = try await 炒菜()
//                await callback(vegetable)
//            } catch {
//                log("停止切菜，原因：\(error.localizedDescription)")
//                rice.cancel()
//                fish.cancel()
//            }
//        }
    }
}

#Preview {
    ChaoCodeView()
}
