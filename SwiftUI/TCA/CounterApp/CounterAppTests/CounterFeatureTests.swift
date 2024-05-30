import ComposableArchitecture
import XCTest
@testable import CounterApp

@MainActor
final class CounterFeatureTests: XCTestCase {
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.incrementButtonTapped) { state in
            state.count = 1
        }
        await store.send(.decrementButtonTapped) { state in
            state.count = 0
        }
    }
    
    func testEffect() async {
//        let store = TestStore(initialState: CounterFeature.State()) {
//            CounterFeature()
//        }
//        await store.send(.toggleTimerButtonTapped) { $0.isTimerRunning = true }
//        await store.send(.toggleTimerButtonTapped) { $0.isTimerRunning = false }
      
        let mainQueue = DispatchQueue.test
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.mainQueue = mainQueue.eraseToAnyScheduler()
        }
        let task = await store.send(.toggleTimerButtonTapped) { $0.isTimerRunning = true }
        await mainQueue.advance(by: .seconds(3))
        await store.receive(\.timerTick) { $0.count = 1 }
        await store.receive(\.timerTick) { $0.count = 2 }
        await store.receive(\.timerTick) { $0.count = 3 }
        await store.send(.toggleTimerButtonTapped) { $0.isTimerRunning = false }
        await task.cancel()
        
        // iOS 16 使用 clock測試
//        let clock = TestClock()
//        let store = TestStore(initialState: CounterFeature.State()) {
//            CounterFeature()
//        } withDependencies: {
//            $0.continuousClock = clock
//        }
//        await store.send(.toggleTimerButtonTapped) { $0.isTimerRunning = true }
//        await clock.advance(by: .seconds(1))
//        await store.receive(\.timerTick) { $0.count = 1 }
//        await store.send(.toggleTimerButtonTapped) { $0.isTimerRunning = false }
    }
    
    func testNumberFact() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { "\($0) is a good number" }
        }
        
        await store.send(.factButtonTapped) {
            $0.isLoading = true
        }
        await store.receive(\.factResponse, timeout: .seconds(1)) {
            $0.isLoading = false
            $0.fact = "0 is a good number" // 不應該預期server回應什麼
        }
    }
}
