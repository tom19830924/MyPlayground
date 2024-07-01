import SwiftUI
import ComposableArchitecture

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        var tab1 = CounterFeature.State()
        var tab2 = CounterFeature.State()
    }
    
    enum Action {
        case tab1(CounterFeature.Action)
        case tab2(CounterFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.tab1, action: \.tab1) {
            CounterFeature()
        }
        Scope(state: \.tab2, action: \.tab2) {
            CounterFeature()
        }
        Reduce { _, _ in
            .none
        }
    }
}

struct AppView: View {
    let store: StoreOf<AppFeature>
    
    var body: some View {
        WithPerceptionTracking {
            TabView {
                CounterView(store: store.scope(state: \.tab1, action: \.tab1))
                    .tabItem {
                        Text("Counter 1")
                    }
                CounterView(store: store.scope(state: \.tab2, action: \.tab2))
                    .tabItem {
                        Text("Counter 2")
                    }
            }
        }
    }
}

#Preview {
    let store = Store(initialState: AppFeature.State(), reducer: { AppFeature() })
    return AppView(store: store)
}
