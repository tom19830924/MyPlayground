import ComposableArchitecture
import Foundation
import SwiftUI
import Combine

let sampleRequest = URLSession.shared
    .dataTaskPublisher(for: URL(string: "https://reqres.in/api/users/2")!)
    .map { element -> String in
        String(data: element.data, encoding: .utf8) ?? ""
    }

struct SampleTextEnvironment {
    var loadText: () -> AnyPublisher<String, URLError>
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

extension SampleTextEnvironment: DependencyKey {
    static var liveValue: SampleTextEnvironment {
        SampleTextEnvironment(loadText: {
            sampleRequest.eraseToAnyPublisher()
        }, mainQueue: .main)
    }
}

extension DependencyValues {
    var apiClient: SampleTextEnvironment {
        get { self[SampleTextEnvironment.self] }
        set { self[SampleTextEnvironment.self] = newValue }
    }
}

@Reducer
struct SampleFeature {
    @ObservableState
    struct State: Equatable {
        var loading: Bool
        var text: String
    }
    
    enum Action {
        case load
        case loaded(Result<String, URLError>)
    }
    
    @Dependency(\.apiClient) var environment
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .load:
                    state.loading = true
                return .publisher {
                    environment
                        .loadText()
                        .receive(on: environment.mainQueue)
                        .replaceError(with: "")
                        .map {
                            .loaded(.success($0))
                        }
                        .eraseToAnyPublisher()
                }
                case let .loaded(result):
                    state.loading = false
                    do {
                        state.text = try result.get()
                    }
                    catch {
                        state.text = "Error: \(error)"
                    }
                    return .none
            }
        }
    }
}

struct SampleView: View {
    let store: StoreOf<SampleFeature>
    var body: some View {
        ZStack {
            VStack {
                Button("Load") { store.send(.load) }
                Text(store.text)
            }
            if store.loading {
                ProgressView().progressViewStyle(.circular)
            }
        }
    }
}

#Preview {
    let store = Store(initialState: SampleFeature.State(loading: false, text: "")) {
        SampleFeature()
    }
    return SampleView(store: store)
}
