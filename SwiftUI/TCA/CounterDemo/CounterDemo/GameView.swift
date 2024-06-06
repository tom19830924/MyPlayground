import ComposableArchitecture
import SwiftUI

struct GameResult: Equatable, Identifiable {
    let counter: CounterFeature.State
    let timeSpent: TimeInterval
    var correct: Bool { counter.secret == counter.count }
    var id: UUID { counter.id }
}

@Reducer
struct GameFeature {
    @ObservableState
    struct State: Equatable {
        var counter = CounterFeature.State()
        var timer = TimerLabelFeature.State()
        var listResult = GameResultListFeature.State()
        var lastTimestamp = 0.0
    }
    
    enum Action {
        case counter(CounterFeature.Action)
        case timer(TimerLabelFeature.Action)
        case listResult(GameResultListFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .counter(.playNext):
                    let result = GameResult(counter: state.counter, timeSpent: state.timer.duration - state.lastTimestamp)
                    state.listResult.rows.append(result)
                    state.lastTimestamp = state.timer.duration
                    return .none
                case .counter:
                    return .none
                case .timer:
                    return .none
                case .listResult:
                    return .none
            }
        }
        
        Scope(state: \.counter, action: \.counter) {
            CounterFeature()
        }
        Scope(state: \.timer, action: \.timer) {
            TimerLabelFeature()
        }
        Scope(state: \.listResult, action: \.listResult) {
            GameResultListFeature()
        }
    }
}

struct GameView: View {
    let store: StoreOf<GameFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                resultLabel(store.listResult.rows.elements)
                Divider()
                TimerLabelView(store: store.scope(state: \.timer, action: \.timer))
                CounterView(store: store.scope(state: \.counter, action: \.counter))
            }
            .onAppear {
                store.send(.timer(.start))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink("Detail") {
                        GameResultListView(store: store.scope(state: \.listResult, action: \.listResult))
                    }
                }
            }
        }
    }
    
    func resultLabel(_ results: [GameResult]) -> some View {
        Text("Result: \(results.filter(\.correct).count)/\(results.count) correct")
    }
}

#Preview {
    NavigationView {
        GameView(
            store: Store(
                initialState: GameFeature.State(),
                reducer: {
                    GameFeature()
                }
            )
        )
    }
}
