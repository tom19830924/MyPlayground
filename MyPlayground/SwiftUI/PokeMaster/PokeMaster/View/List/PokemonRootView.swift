//
//  PokemonRootView.swift
//  PokeMaster
//
//  Created by user on 2024/2/22.
//

import SwiftUI

struct PokemonRootView: View {
    var body: some View {
        NavigationView {
            PokemonList().navigationBarTitle("寶可夢列表")
        }
    }
}

#Preview {
    PokemonRootView()
}
