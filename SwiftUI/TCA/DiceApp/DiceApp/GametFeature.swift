import SwiftUI
import ComposableArchitecture

@Reducer
struct GameFeature {
    @ObservableState
    struct State: Equatable {
        var color = Color.white
        var dice = DiceFeature.State()
    }
    
    enum Action {
        case changeColor
        case dice(DiceFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.dice, action: \.dice) {
            DiceFeature()
        }
        Reduce { state, action in
            switch action {
                case .changeColor:
                    state.color = Color(
                        red: .random(in: 0 ... 1),
                        green: .random(in: 0 ... 1),
                        blue: .random(in: 0 ... 1)
                    )
                    return .none
                case .dice:
                    return .none
            }
        }
    }
}

struct GameView: View {
    var store: StoreOf<GameFeature>
    
    var body: some View {
        ZStack {
            store.color.ignoresSafeArea()
            VStack {
                DiceView(store: store.scope(state: \.dice, action: \.dice))
                Button("Random Background Color") {
                    store.send(.changeColor)
                }
            }
            .font(.title)
            .padding()
        }
    }
}

#Preview {
    let state = GameFeature.State()
    let reducer = { GameFeature() }
    let store = Store(initialState: state, reducer: reducer)
    
    return GameView(store: store)
}
