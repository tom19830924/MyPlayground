//
//  MainTab.swift
//  PokeMaster
//
//  Created by user on 2024/2/22.
//

import SwiftUI

struct MainTab: View {
    @EnvironmentObject var store: Store
    private var pokemonList: AppState.PokemonList {
        store.appState.pokemonList
    }

    private var pokemonListBinding: Binding<AppState.PokemonList> {
        $store.appState.pokemonList
    }
    private var selectedPanelIndex: Int? {
        pokemonList.selectionState.panelIndex
    }
    
    var body: some View {
        TabView {
            PokemonRootView()
                .tabItem {
                    Image(systemName: "list.bullet.below.rectangle")
                    Text("列表")
                }
            SettingRootView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("設置")
                }
        }
        .ignoresSafeArea(edges: .top)
        .overlaySheet(isPresented: pokemonListBinding.selectionState.panelPresented) {
            if self.selectedPanelIndex != nil && self.pokemonList.pokemons != nil {
                PokemonInfoPanel(
                    model: self.pokemonList.pokemons![self.selectedPanelIndex!]!
                )
            }
        }
    }
}

#Preview {
    MainTab()
        .environmentObject(Store.sample)
}
