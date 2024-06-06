import ComposableArchitecture
import SwiftUI

@Reducer
struct AddContactFeature {
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action {
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
    }
    
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .cancelButtonTapped:
                    return .none
                case .saveButtonTapped:
                    return .none
                case let .setName(name):
                    state.contact.name = name
                    return .none
            }
        }
    }
}

struct AddContactView: View {
    @Perception.Bindable var store: StoreOf<AddContactFeature>
    
    var body: some View {
        WithPerceptionTracking {
            Form {
                TextField("Name", text: $store.contact.name.sending(\.setName))
                Button("Save") {
                    store.send(.saveButtonTapped)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Cancel") {
                        store.send(.cancelButtonTapped)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        AddContactView(
            store: Store(
                initialState: AddContactFeature.State(
                    contact: Contact(
                        id: UUID(),
                        name: "Blob"
                    )
                )
            ) {
                AddContactFeature()
            }
        )
    }
}
