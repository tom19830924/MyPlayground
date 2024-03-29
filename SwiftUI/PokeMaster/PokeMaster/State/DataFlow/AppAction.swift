//
//  AppAction.swift
//  PokeMaster
//
//  Created by user on 2024/2/23.
//

import Foundation

enum AppAction {
    case login(email: String, password: String)
    case accountBehaviorDone(result: Result<User, AppError>)
    case logout
    case clearCache
    case emailValid(valid: Bool)
    
    case toggleListSelection(index: Int?)
    case togglePanelPresenting(presenting: Bool)
    
    case loadAbilities(pokemon: Pokemon)
    case loadAbilitiesDone(result: Result<[AbilityViewModel], AppError>)
    
    case loadPokemons
    case loadPokemonsDone(result: Result<[PokemonViewModel], AppError>)
    
    case closeSafariView
}
