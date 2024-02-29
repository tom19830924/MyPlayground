//
//  User.swift
//  PokeMaster
//
//  Created by user on 2024/2/23.
//

import Foundation

struct User: Codable {
    var email: String
    var favoritePokemonIDs: Set<Int>
    
    func isFavoritePokemon(id: Int) -> Bool {
        favoritePokemonIDs.contains(id)
    }
}
