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
        case delegate(Delegate)
        case saveButtonTapped
        case setName(String)
        
        enum Delegate: Equatable {
//            case cancel
            case saveContact(Contact)
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .cancelButtonTapped:
//                    return .send(.delegate(.cancel))
                    return .run { _ in await dismiss() }
                case .saveButtonTapped:
//                    return .send(.delegate(.saveContact(state.contact)))
                return .run { [contact = state.contact] send in
                    await send(.delegate(.saveContact(contact)))
                    await dismiss()
                }
                case let .setName(name):
                    state.contact.name = name
                    return .none
                case .delegate:
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
