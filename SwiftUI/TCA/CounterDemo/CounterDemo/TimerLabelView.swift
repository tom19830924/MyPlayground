import ComposableArchitecture
import SwiftUI

@Reducer
struct TimerLabelFeature {
    @ObservableState
    struct State: Equatable {
        var started: Date?
        var duration: TimeInterval = 0
    }
    
    enum Action {
        case start
        case stop
        case timeUpdated
    }
    
    enum TimerId { case timer }
    @Dependency(\.timer) var environment
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .start:
                    if state.started == nil {
                        state.started = environment.date()
                    }
                    return .run { send in
                        for await _ in environment.mainQueue.timer(interval: .milliseconds(10)) {
                            await send(.timeUpdated)
                        }
                    }
                    .cancellable(id: TimerId.timer)
                case .stop:
                    return .cancel(id: TimerId.timer)
                case .timeUpdated:
                    state.duration += 0.01
                    return .none
            }
        }
    }
}

struct TimerLabelView: View {
    let store: StoreOf<TimerLabelFeature>
    var body: some View {
        VStack(alignment: .leading) {
            Label(store.started == nil ? "-" : "\(store.started!.formatted(date: .omitted, time: .standard))", systemImage: "clock")
            Label("\(store.duration, format: .number)s", systemImage: "timer")
        }
    }
}

#Preview {
    let store = Store(
        initialState: TimerLabelFeature.State(),
        reducer: {
            TimerLabelFeature()
        }
    )
    return VStack {
        TimerLabelView(store: store)
        HStack {
            Button("Start") { store.send(.start) }
            Button("Stop") { store.send(.stop) }
        }
        .padding()
    }
}
