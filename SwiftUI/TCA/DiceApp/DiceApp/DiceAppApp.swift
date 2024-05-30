import SwiftUI

@main
struct DiceAppApp: App {
    var body: some Scene {
        WindowGroup {
            GameView(store: .init(initialState: GameFeature.State(), reducer: {
                GameFeature()
            }))
        }
    }
}
