import SwiftUI

@main
struct ThinkingInSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class LifeMonitor {
    let name: String

    init(type: (some Any).Type) {
        self.name = String(describing: type.self)
    }

    deinit {
        print("\(name) deinit")
    }
}
