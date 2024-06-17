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
        @Presents var destination: Destination.State?
        
    }
    
    enum Action {
        case addButtonTapped
        case deleteButtonTapped(id: Contact.ID)
        case destination(PresentationAction<Destination.Action>)
        enum Alert: Equatable {
            case confirmDeletion(id: Contact.ID)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .addButtonTapped:
                    state.destination = .addContact(
                        AddContactFeature.State(
                            contact: Contact(id: UUID(), name: "")
                        )
                    )
                    return .none
                case let .deleteButtonTapped(id: id):
//                    state.destination = .alert(
//                        AlertState {
//                            TextState("Are you sure?")
//                        } actions: {
//                            ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
//                                TextState("Delete")
//                            }
//                        }
//                    )
                    state.destination = .alert(
                        AlertState(
                            title: TextState("Are you sure?"),
                            message: nil,
                            dismissButton: ButtonState(
                                role: .destructive,
                                action: .confirmDeletion(id: id)
                            ) {
                                TextState("Delete")
                            }
                        )
                    )
                    return .none
                case let .destination(.presented(.addContact(.delegate(.saveContact(contact))))):
                    state.contacts.append(contact)
                    return .none
                case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
                    state.contacts.remove(id: id)
                    return .none
                case .destination:
                    return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension ContactsFeature {
    @Reducer(state: .equatable)
    enum Destination {
        case addContact(AddContactFeature)
        case alert(AlertState<ContactsFeature.Action.Alert>)
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
                item: $store.scope(state: \.destination?.addContact, action: \.destination.addContact)
            ) { addContactStore in
                NavigationView {
                    AddContactView(store: addContactStore)
                }
            }
//            .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
            
            .alert(item: $store.scope(state: \.destination?.alert, action: \.destination.alert)) { store in
                store.withState { state in
                    Alert(state) { _ in
//                        store.send(.confirmDeletion(id: state.id))
                    }
                }
            }
        }
    }
    
    @Binding var qq: String?
    init(store: StoreOf<ContactsFeature>, qq: Binding<String?> = .constant(nil)) {
        self.store = store
        self._qq = qq
    }
    
    var list: some View {
        List {
            ForEach(store.contacts) { contact in
                NavigationLink("123", tag: "QQ", selection: $qq) {
                    Text("GG")
                }
//                HStack {
//                    Text(contact.name)
//                    Spacer()
//                    Button {
//                        store.send(.deleteButtonTapped(id: contact.id))
//                    } label: {
//                        Image(systemName: "trash")
//                            .foregroundColor(.red)
//                    }
//                }
            }
        }
        .navigationTitle("Contacts")
        .toolbar {
            ToolbarItem {
                Button {
                    qq = "QQ"
//                    store.send(.addButtonTapped)
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
