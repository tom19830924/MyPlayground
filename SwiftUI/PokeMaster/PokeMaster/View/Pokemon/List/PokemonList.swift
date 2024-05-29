//
//  PokemonList.swift
//  PokeMaster
//
//  Created by user on 2024/2/7.
//

import SwiftUI

struct PokemonList: View {
    @EnvironmentObject var store: Store
    var pokemonList: AppState.PokemonList {
        store.appState.pokemonList
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                TextField("搜索", text: $store.appState.pokemonList.searchText)
                    .frame(height: 40)
                    .padding(.horizontal, 25)
                ForEach(pokemonList.allPokemonsById) { pokemon in
                    PokemonInfoRow(model: pokemon, expanded: store.appState.pokemonList.selectionState.isExpanding(pokemon.id))
                        .onTapGesture {
                            withAnimation(.spring(response: 0.55, dampingFraction: 0.425, blendDuration: 0)) {
                                store.dispatch(.toggleListSelection(index: pokemon.id))
                            }
                            store.dispatch(.loadAbilities(pokemon: pokemon.pokemon))
                        }
                }
            }
        }
        .onAppear {
            store.dispatch(.loadPokemons)
        }
        .refreshable {
            print("GG")
        }
    }
}

#Preview {
    PokemonList()
}
