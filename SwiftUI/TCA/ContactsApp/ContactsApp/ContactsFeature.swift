import ComposableArchitecture
import SwiftUI

struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

@Reducer
struct ContactsFeature {
    @ObservableState
    struct State: Equatable {
        var contacts: IdentifiedArrayOf<Contact> = []
        @Presents var alert: AlertState<Action.Alert>?
        @Presents var addContact: AddContactFeature.State?
    }
    
    enum Action {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)
        case alert(PresentationAction<Alert>)
        case deleteButtonTapped(id: Contact.ID)
        enum Alert: Equatable {
            case confirmDeletion(id: Contact.ID)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .addButtonTapped:
                    state.addContact = AddContactFeature.State(
                        contact: Contact(id: UUID(), name: "")
                    )
                    return .none
                    
                case let .addContact(.presented(.delegate(.saveContact(contact)))):
                    state.contacts.append(contact)
                    return .none
                case let .alert(.presented(.confirmDeletion(id: id))):
                    state.contacts.remove(id: id)
                    return .none
                case .alert:
                    return .none
                case .addContact:
                    return .none
                case let .deleteButtonTapped(id: id):
                    state.alert = AlertState(
                        title: TextState("Are you sure?"),
                        message: nil,
                        dismissButton: ButtonState(
                            role: .destructive,
                            action: .confirmDeletion(id: id)
                        ) {
                            TextState("Delete")
                        }
                    )
                    return .none
            }
        }
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactFeature()
        }
        .ifLet(\.$alert, action: \.alert)
    }
}

struct ContactsView: View {
    @Perception.Bindable var store: StoreOf<ContactsFeature>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationView {
                list
            }
            .sheet(
                item: $store.scope(state: \.addContact, action: \.addContact)
            ) { addContactStore in
                NavigationView {
                    AddContactView(store: addContactStore)
                }
            }
            .alert(item: $store.scope(state: \.alert, action: \.alert)) { store in
                return store.withState { state in
                    Alert(state) { action in
//                        store.send(.confirmDeletion(id: state.id))
                    }
                }
            }
        }
    }
    
    var list: some View {
        List {
            ForEach(store.contacts) { contact in
                HStack {
                    Text(contact.name)
                    Spacer()
                    Button {
                        store.send(.deleteButtonTapped(id: contact.id))
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .navigationTitle("Contacts")
        .toolbar {
            ToolbarItem {
                Button {
                    store.send(.addButtonTapped)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ContactsView(
        store: Store(
            initialState: ContactsFeature.State(
                contacts: [
                    Contact(id: UUID(), name: "Blob"),
                    Contact(id: UUID(), name: "Blob Jr"),
                    Contact(id: UUID(), name: "Blob Sr"),
                ]
            )
        ) {
            ContactsFeature()
        }
    )
}
