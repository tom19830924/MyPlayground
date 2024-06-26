import ComposableArchitecture
import SwiftUI

@Reducer
struct TimerLabelFeature {
    @ObservableState
    struct State: Equatable {
        var started: Date?
        var duration: TimeInterval = 10
    }
    
    enum Action: Equatable {
        case start
        case stop
        case countdown
        case setDuration(TimeInterval)
        case delegate(Delegate)
    }
    
    enum Delegate: Equatable {
        case endOfCountdown
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
                            await send(.countdown)
                        }
                    }
                    .cancellable(id: TimerId.timer)
                case .stop:
                    return .cancel(id: TimerId.timer)
                case .countdown:
                    if state.duration <= 0 {
                        state.duration = 10
                        return .send(.delegate(.endOfCountdown))
                    }
                    state.duration -= 0.01
                    return .none
                case let .setDuration(duration):
                    state.duration = duration
                    return .none
                case .delegate:
                    return .none
            }
        }
    }
}

struct TimerLabelView: View {
    let store: StoreOf<TimerLabelFeature>
    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .leading) {
                Label(store.started == nil ? "-" : "\(store.started!.myFormat)", systemImage: "clock")
                Label("\(store.duration.myFormat)s", systemImage: "timer")
            }
        }
    }
}

extension Date {
    var myFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}

extension TimeInterval {
    var myFormat: String {
        let time = NSInteger(self)
        let ms = Int(truncatingRemainder(dividingBy: 1) * 100)
        let seconds = time % 60
        return String(format: "%0.2d.%0.2d", seconds, ms)
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
