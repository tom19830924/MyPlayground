import ComposableArchitecture
import XCTest
@testable import CounterDemo


final class CounterFeatureTests: XCTestCase {
    var store: TestStore<CounterFeature.State, CounterFeature.Action>!
    
    override func setUpWithError() throws {
        store = TestStore(
            initialState: CounterFeature.State(count: Int.random(in: -100...100)),
            reducer: { CounterFeature() },
            withDependencies: {
                $0.random.generateRandom = { _ in 5 }
            }
        )
    }
    
    @MainActor
    func testCounterIncrement() async throws {
        await store.send(.increment) { state in
            state.count += 1
        }
    }
    
    @MainActor
    func testCounterDecrement() async throws {
        await store.send(.decrement) { state in
            state.count -= 1
        }
    }
    
    @MainActor
    func testReset() async throws {
        await store.send(.playNext) { state in
            state.count = 0
            state.secret = 5
        }
    }
}
