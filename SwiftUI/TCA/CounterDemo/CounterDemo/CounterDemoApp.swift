import ComposableArchitecture
import SwiftUI

@main
struct CounterDemoApp: App {
    static let store = Store(initialState: GameFeature.State()) {
        GameFeature()
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                GameView(store: CounterDemoApp.store)
            }
        }
    }
}
