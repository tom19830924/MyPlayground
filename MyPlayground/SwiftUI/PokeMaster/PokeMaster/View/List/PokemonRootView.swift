//
//  PokemonRootView.swift
//  PokeMaster
//
//  Created by user on 2024/2/22.
//

import SwiftUI

struct PokemonRootView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationView {
            if store.appState.pokemonList.pokemons == nil {
                if store.appState.pokemonList.pokemonsLoadingError != nil {
                    RetryButton {
                        self.store.dispatch(.loadPokemons)
                    }.offset(y: -40)
                }
                else {
                    Text("Loading...").onAppear {
                        self.store.dispatch(.loadPokemons)
                    }
                }
            }
            else {
                PokemonList().navigationBarTitle("寶可夢列表")
            }
        }
    }
    
    struct RetryButton: View {
        let block: () -> Void
        
        var body: some View {
            Button(action: block) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("Retry")
                }
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.gray)
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                )
            }
        }
    }
}

#Preview {
    PokemonRootView()
        .environmentObject(Store())
}
