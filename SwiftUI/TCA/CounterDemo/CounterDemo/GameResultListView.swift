import ComposableArchitecture
import SwiftUI

@Reducer
struct GameResultListFeature {
    @ObservableState
    struct State: Equatable {
        var rows: IdentifiedArrayOf<GameResult> = []
    }
    
    enum Action {
        case remove(offset: IndexSet)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case let .remove(offset: offset):
                    state.rows.remove(atOffsets: offset)
                    return .none
            }
        }
    }
}

struct GameResultListView: View {
    let store: StoreOf<GameResultListFeature>
    var body: some View {
        WithPerceptionTracking {
            List {
                ForEach(store.rows) { result in
                    HStack {
                        Image(systemName: result.correct ? "checkmark.circle" : "x.circle")
                        Text("Secret: \(result.counter.secret)")
                        Text("Answer: \(result.counter.count)")
                        Text("Spent: \(result.timeSpent)")
                    }.foregroundColor(result.correct ? .green : .red)
                }
                .onDelete {
                    store.send(.remove(offset: $0))
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }
}

#Preview {
    NavigationView {
        GameResultListView(
            store: .init(
                initialState: GameResultListFeature.State(rows: [
                    GameResult(counter: .init(count: 20, secret: 20, id: .init()), timeSpent: 100),
                    GameResult(counter: .init(), timeSpent: 100),
                ]),
                reducer: {
                    GameResultListFeature()
                }
            )
        )
    }
}
