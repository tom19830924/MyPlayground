import ComposableArchitecture
import SwiftUI

@Reducer
struct CounterFeature {
    @ObservableState
    struct State: Equatable, Identifiable {
        var count = 0
        var secret = Int.random(in: -100 ... 100)
        var id = UUID()
        
        // TextField binding使用
        var countString: String {
            get {
                String(count)
            }
            set {
                count = Int(newValue) ?? count
            }
        }
        // Slider binding使用
        var countFloat: Float {
            get { Float(count) }
            set { count = Int(newValue) }
        }
        
        var checkResult: CheckResult {
            if count < secret {
                return .lower
            }
            if count > secret {
                return .higher
            }
            return .equal
        }
    }
    
    enum CheckResult {
        case lower
        case equal
        case higher
    }
    
    enum Action: BindableAction {
        case increment
        case decrement
        case playNext
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.random) var environment
    
    var body: some ReducerOf<Self> {
        BindingReducer()    // Binding
        
        Reduce { state, action in
            switch action {
                case .increment:
                    state.count += 1
                    return .none
                case .decrement:
                    state.count -= 1
                    return .none
                case .playNext:
                    state.count = 0
                    state.secret = environment.generateRandom(-100 ... 100)
                    state.id = environment.uuid()
                    return .none
                case .binding:
                    return .none
            }
        }
    }
}

struct CounterView: View {
    @Perception.Bindable var store: StoreOf<CounterFeature>
    var body: some View {
        VStack {
            checkLabel(with: store.checkResult)
            HStack {
                Button("-") {
                    store.send(.decrement)
                }
                TextField(String(store.count), text: $store.countString)
                    .frame(width: 40)
                    .multilineTextAlignment(.center)
                    .foregroundColor(colorOfCount(store.count))
                Button("+") {
                    store.send(.increment)
                }
            }
            Slider(value: $store.countFloat, in: -100...100)
            Button("Next") {
                store.send(.playNext)
            }
        }
        .frame(width: 150)
    }
    
    func checkLabel(with checkResult: CounterFeature.CheckResult) -> some View {
        switch checkResult {
            case .lower:
                Label("Lower", systemImage: "lessthan.circle")
                    .foregroundColor(.red)
            case .higher:
                Label("Higher", systemImage: "greaterthan.circle")
                    .foregroundColor(.red)
            case .equal:
                Label("Correct", systemImage: "checkmark.circle")
                    .foregroundColor(.green)
        }
    }
    
    func colorOfCount(_ value: Int) -> Color? {
        if value == 0 {
            return nil
        }
        return value < 0 ? .red : .green
    }
}

#Preview {
    CounterView(
        store: Store(
            initialState: CounterFeature.State(),
            reducer: {
                CounterFeature()
            }
        )
    )
}
