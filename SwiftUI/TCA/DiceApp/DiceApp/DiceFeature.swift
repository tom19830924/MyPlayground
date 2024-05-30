import ComposableArchitecture
import SwiftUI

struct DiceState: Equatable {
    var value = 1
}

enum DiceAction: Equatable {
    case roll
}

struct DiceFeature: Reducer {
    func reduce(into state: inout DiceState, action: DiceAction) -> Effect<DiceAction> {
        switch action {
            case .roll:
                state.value = Int.random(in: 1 ... 6)
                return .none
        }
    }
}

struct DiceView: View {
    var store: StoreOf<DiceFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                Image(systemName: "die.face.\(viewStore.value).fill")
                    .resizable()
                    .scaledToFit()
                Button("Play") {
                    store.send(.roll)
                }
            }
        }
    }
}

#Preview {
    DiceView(
        store: .init(
            initialState: DiceState(),
            reducer: {
                DiceFeature()
            }
        )
    )
}
