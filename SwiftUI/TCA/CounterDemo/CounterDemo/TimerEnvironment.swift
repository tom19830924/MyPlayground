import ComposableArchitecture
import Foundation

struct TimerEnvironment {
    var date: () -> Date
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

extension TimerEnvironment: DependencyKey {
    static var liveValue: TimerEnvironment {
        Self(
            date: Date.init,
            mainQueue: .main
        )
    }
}

extension DependencyValues {
    var timer: TimerEnvironment {
        get { self[TimerEnvironment.self] }
        set { self[TimerEnvironment.self] = newValue }
    }
}
