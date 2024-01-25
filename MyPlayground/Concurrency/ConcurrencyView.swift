import SwiftUI

struct ConcurrencyView: View {
    var webSocketTask: URLSessionWebSocketTask = {
        let url = URL(string: "ws://0.0.0.0:8080/ws/echo")!
        let urlSession = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let request = URLRequest(url: url)
        let websocket = urlSession.webSocketTask(with: request)
        return websocket
    }()
    @State var items: [String] = []
    @State private var message: String = ""
    @State var 切到手: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
            }
            Text(message)
            HStack {
                VStack {
                    Button("HTTP Fetch") {
                        clear()
                        Task {
                            try await fetchData()
                        }
                    }
                    HStack {
                        Toggle("切到手", isOn: $切到手)
                    }
                }
                
                .buttonStyle(.bordered)
                VStack {
                    Button("WebSocket connection") {
                        clear()
                        webSocketConnection()
                    }
                    .buttonStyle(.bordered)
                    Button("WebSocket Send") {
                        clear()
                        Task {
                            let elem = ["1","2","3","4","5"].randomElement()!
                            try? await sendMessage(message: elem)
                        }
                    }
                    .buttonStyle(.bordered)
                }
                
            }
        }
    }
    func clear() {
        message = ""
        items = []
    }
    func webSocketConnection() {
        webSocketTask.resume()
    }
    
    func 依序送出＿每個Request等待上一個完成() async throws {
        // 依序等待, async serialQueue 的概念
        let startTime = Date.now
        log(try await fetchEcho(echo: "1"))
        log(try await fetchEcho(echo: "2"))
        log(try await fetchEcho(echo: "3"))
        log(try await fetchEcho(echo: "4"))
        log(try await fetchEcho(echo: "5"))
        message = getElapsedTime(from: startTime)
    }
    func 同時送出_但時間顯示會有問題() async throws {
        // async concurrentQueue 概念, 但時間會有問題
        let startTime = Date.now
        Task { log(try await fetchEcho(echo: "1")) }
        Task { log(try await fetchEcho(echo: "2")) }
        Task { log(try await fetchEcho(echo: "3")) }
        Task { log(try await fetchEcho(echo: "4")) }
        Task { log(try await fetchEcho(echo: "5")) }
        message = getElapsedTime(from: startTime)
    }
    func fetchData() async throws {
//        try await 依序送出＿每個Request等待上一個完成()
//        try await 同時送出_但時間顯示會有問題()

        
        // Structured Concurrency, group wait, 全部做完才會往下走
        // 但這也有個問題, 先好的沒辦法先顯示, 雖然是全部一起開始, 但是後面的await是依賴關係, b要等a好, c要等b好, etc.
        // 舉例來說 假設b先完成了 但是不會立刻顯示, 要等a也完成, 畫面才會同時顯示a,b
//        let startTime = Date.now
//        async let a = fetchEcho(echo: "1")
//        async let b = fetchEcho(echo: "2")
//        async let c = fetchEcho(echo: "3")
//        async let d = fetchEcho(echo: "4")
//        async let e = fetchEcho(echo: "5")
//        try await log(a)
//        try await log(b)
//        try await log(c)
//        try await log(d)
//        try await log(e)
////        try await items = [a,b,c,d,e]  // 這是要全部完成才會顯示, 跟上面略有不同
//        message = getElapsedTime(from: startTime)
        
        
        // Structured Concurrency
//        let startTime = Date.now
//        await withThrowingTaskGroup(of: Void.self) { group in
//            group.addTask {
//                log(try await fetchEcho(echo: "1"))
//            }
//            group.addTask {
//                log(try await fetchEcho(echo: "2"))
//            }
//            group.addTask {
//                log(try await fetchEcho(echo: "3"))
//            }
//            group.addTask {
//                log(try await fetchEcho(echo: "4"))
//            }
//            group.addTask {
//                log(try await fetchEcho(echo: "5"))
//            }
//        }
//        message = getElapsedTime(from: startTime)
        
//        let startTime = Date.now
//        try await withThrowingTaskGroup(of: String.self) { group in
//            ["1","2","3","4","5"].forEach { s in
//                group.addTask {
//                    async let r = fetchEcho(echo: s)
//                    return try await r
//                }
//            }
//            for try await s in group {
//                items += [s]
//            }
//        }
//        message = getElapsedTime(from: startTime)
    }
    func fetchEcho(echo: String) async throws -> String {
        let url = URL(string: "http://localhost:8080/\(echo)")!
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = String(data: data, encoding: .utf8)
        return result ?? ""
    }
    func sendMessage(message: String) async throws {
        let startTime = Date.now
        
        let message = URLSessionWebSocketTask.Message.string(message)
        try await webSocketTask.send(message)
        
        let result = try await webSocketTask.receive()
        switch result {
        case .string(let message):
            log(message)
        case .data(let data):
            let m = String(data: data, encoding: .utf8) ?? ""
            log(m)
        @unknown default:
            fatalError()
        }
        
        self.message = getElapsedTime(from: startTime)
    }
}

extension ConcurrencyView {
    func log(_ content: String) {
        items.append(content)
    }
    func getElapsedTime(from: Date) -> String {
        String(format: "%.10f", Date.now.timeIntervalSince(from))
    }
}

#Preview {
    ConcurrencyView()
}

