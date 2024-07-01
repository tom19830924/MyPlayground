import ComposableArchitecture
import Foundation
import XCTest
@testable import CounterDemo

final class TimerLabelFeatureTests: XCTestCase {
//    var store: TestStore<TimerLabelFeature.State, TimerLabelFeature.Action>!
    let scheduler = DispatchQueue.test
    
//    override func setUpWithError() throws {
//        store = TestStore(
//            initialState: TimerLabelFeature.State(),
//            reducer: { TimerLabelFeature() },
//            withDependencies: { _ in
//            }
//        )
//    }
    
    @MainActor
    func testTimerUpdate() async throws {
        let store = TestStore(
            initialState: TimerLabelFeature.State(),
            reducer: { TimerLabelFeature() },
            withDependencies: {
                $0.timer = TimerEnvironment(
                    date: { Date(timeIntervalSince1970: 100) },
                    mainQueue: scheduler.eraseToAnyScheduler()
                )
            }
        )
        
        await store.send(.start) {
            $0.started = Date(timeIntervalSince1970: 100)
        }
        
        // 這表示讓時間前進0.35秒
        await scheduler.advance(by: .milliseconds(35))
        // 0.35秒後, 期望收到三次事件, 所以要寫三個receive, 少一個都不行
        await store.receive(.countdown) { $0.duration = 0.01 }
        await store.receive(.countdown) { $0.duration = 0.02 }
        await store.receive(.countdown) { $0.duration = 0.03 }
        await store.send(.stop)
    }
}
