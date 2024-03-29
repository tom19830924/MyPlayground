//
//  MainTab.swift
//  PokeMaster
//
//  Created by user on 2024/2/22.
//

import SwiftUI

struct MainTab: View {
    @EnvironmentObject var store: Store
//    private var pokemonList: AppState.PokemonList {
//        store.appState.pokemonList
//    }
//    
//    private var pokemonListBinding: Binding<AppState.PokemonList> {
//        $store.appState.pokemonList
//    }
//    private var selectedPanelIndex: Int? {
//        pokemonList.selectionState.panelIndex
//    }
    
    var body: some View {
        TabView(selection: $store.appState.mainTab.selection) {
            PokemonRootView()
                .tabItem {
                    Image(systemName: "list.bullet.below.rectangle")
                    Text("列表")
                }
                .tag(AppState.MainTab.Index.list)
            SettingRootView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("設置")
                }
                .tag(AppState.MainTab.Index.settings)
        }
        .ignoresSafeArea(edges: .top)
//        .overlaySheet(isPresented: pokemonListBinding.selectionState.panelPresented) {
//            if selectedPanelIndex != nil && pokemonList.pokemons != nil {
//                PokemonInfoPanel(model: pokemonList.pokemons![selectedPanelIndex!]!)
//            }
//        }
    }
}

#Preview {
    MainTab()
        .environmentObject(Store.sample)
}
