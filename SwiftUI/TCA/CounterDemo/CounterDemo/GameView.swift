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
                    let result = GameResult(counter: state.counter, timeSpent: 10 - state.timer.duration)
                    state.listResult.rows.append(result)
                    state.lastTimestamp = state.timer.duration
                    return .send(.timer(.setDuration(10)))
                case .timer(.delegate(.endOfCountdown)):
                    return .send(.counter(.playNext))
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
                Text("Result: \(store.listResult.rows.elements.filter(\.correct).count)/\(store.listResult.rows.elements.count) correct")
                
                Divider()
                
                TimerLabelView(store: store.scope(state: \.timer, action: \.timer))
                    .border(Color.red)
                
                Divider()
                
                CounterView(store: store.scope(state: \.counter, action: \.counter))
                    .border(Color.red)
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
            .border(Color.red)
        }
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
