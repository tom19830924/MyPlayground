import ComposableArchitecture
import SwiftUI

@Reducer
struct ContactDetailFeature {
    @ObservableState
    struct State: Equatable {
        let contact: Contact
    }
    
    enum Action {}
    
    var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {}
        }
    }
}

struct ContactDetailView: View {
    let store: StoreOf<ContactDetailFeature>
    init(store: StoreOf<ContactDetailFeature>) {
        self.store = store
    }
    var body: some View {
        Form {}
            .navigationTitle(Text(store.contact.name))
    }
}

#Preview {
    NavigationView {
        ContactDetailView(
            store: Store(
                initialState: ContactDetailFeature.State(
                    contact: Contact(id: UUID(), name: "Blob")
                )
            ) {
                ContactDetailFeature()
            }
        )
    }
}
