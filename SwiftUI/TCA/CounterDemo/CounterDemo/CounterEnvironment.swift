import ComposableArchitecture
import Foundation

struct CounterEnvironment {
    var generateRandom: (ClosedRange<Int>) -> Int
    var uuid: () -> UUID
}

extension CounterEnvironment: DependencyKey {
    static var liveValue: CounterEnvironment {
        Self {
            Int.random(in: $0)
        } uuid: {
            UUID()
        }
    }
}

extension DependencyValues {
    var random: CounterEnvironment {
        get { self[CounterEnvironment.self] }
        set { self[CounterEnvironment.self] = newValue }
    }
}
