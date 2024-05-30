import ComposableArchitecture
import SwiftUI

@main
struct ContactsApp: App {
    static let store = Store(
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

    var body: some Scene {
        WindowGroup {
            ContactsView(store: ContactsApp.store)
        }
    }
}
