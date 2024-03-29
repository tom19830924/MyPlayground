//
//  PokeMasterApp.swift
//  PokeMaster
//
//  Created by user on 2024/2/7.
//

import SwiftUI

@main
struct PokeMasterApp: App {
    let store = Store()
    
    var body: some Scene {
        
        WindowGroup {
            MainTab()
                .environmentObject(store)
                .onOpenURL { url in
                    handleURL(url: url)
                }
        }
    }
    
    private func handleURL(url: URL) {
        guard
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return
        }
        
        switch (components.scheme, components.host) { 
            case ("pokemaster", "showPanel"):
                guard 
                    let idQuery = (components.queryItems?.first {
                        $0.name == "id"
                    }),
                    let idString = idQuery.value,
                    let id = Int(idString), id >= 1 && id <= 30 else {
                        break
                }
        
                store.appState.pokemonList.selectionState = .init(expandingIndex: id, panelIndex: id, panelPresented: true)
            default: break
        }
    }
}
