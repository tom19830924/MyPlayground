//
//  PokemonList.swift
//  PokeMaster
//
//  Created by user on 2024/2/7.
//

import SwiftUI

struct PokemonList: View {
    @State var expandingIndex: Int?
    @State var searchText: String = ""
    
    var body: some View {
        ScrollView {
            LazyVStack {
                TextField("搜索", text: $searchText)
                    .frame(height: 40)
                    .padding(.horizontal, 25)
                ForEach(PokemonViewModel.all) { pokemon in
                    PokemonInfoRow(model: pokemon,
                                   expanded: self.expandingIndex == pokemon.id
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.55, dampingFraction: 0.425, blendDuration: 0)) {
                            if expandingIndex == pokemon.id {
                                expandingIndex = nil
                            } else {
                                expandingIndex = pokemon.id
                            }
                        }
                    }
                }
            }
        }
//        .overlay {
//            VStack {
//                Spacer()
//                PokemonInfoPanel(model: .sample(id: 1))
//            }
//            .ignoresSafeArea(edges: .bottom)
//        }
    }
}

#Preview {
    PokemonList()
}
