//
//  AppState.swift
//  PokeMaster
//
//  Created by user on 2024/2/23.
//

import Foundation
import Combine

struct AppState {
    var settings = Settings()
    var pokemonList = PokemonList()
    var mainTab = MainTab()
}

extension AppState {
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }
        enum AccountBehavior: CaseIterable {
            case register, login
        }
        
        class AccountChecker {
            @Published var accountBehavior = AccountBehavior.login
            @Published var email = ""
            @Published var password = ""
            @Published var verifyPassword = ""
            
            var isEmailValid: AnyPublisher<Bool, Never> {
                let emailLocalValid = $email.map { $0.isValidEmailAddress }
                let canSkipRemoteVerify = $accountBehavior.map { $0 == .login }
                let remoteVerify = $email
                    .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                    .removeDuplicates()
                    .flatMap { email -> AnyPublisher<Bool, Never> in
                        let validEmail = email.isValidEmailAddress
                        let canSkip = (self.accountBehavior == .login)
                        
                        switch (validEmail, canSkip) {
                            
                        case (false, _):
                            return Just(false).eraseToAnyPublisher()
                        case (true, false):
                            return EmailCheckingRequest(email: email)
                                .publisher
                                .eraseToAnyPublisher()
                        case (true, true):
                            return Just(true).eraseToAnyPublisher()
                        }
                    }
                return Publishers.CombineLatest3(remoteVerify, emailLocalValid, canSkipRemoteVerify)
                    .map { $0 && ($1 || $2) }
                    .eraseToAnyPublisher()
            }
            
            var isPasswordValid: AnyPublisher<Bool, Never> {
                return Publishers.CombineLatest($password, $verifyPassword)
                    .map { password, verifyPassword in
                        guard !password.isEmpty || !verifyPassword.isEmpty else {
                            return false
                        }
                        return password == verifyPassword
                    }
                    .eraseToAnyPublisher()
            }
        }
        
        var isEmailValid: Bool = false
        
        var checker = AccountChecker()
        
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
        
        @FileStorage(directory: .documentDirectory, fileName: "user.json") var loginUser: User?
        
        var loginRequesting: Bool = false
        var loginError: AppError?
    }
}

extension AppState {
    struct PokemonList {
        @FileStorage(directory: .cachesDirectory, fileName: "pokemons.json") var pokemons: [Int: PokemonViewModel]?
        var abilities: [Int: AbilityViewModel]?
        
        func abilityViewModels(for pokemon: Pokemon) -> [AbilityViewModel]? {
            guard let abilities = abilities else { return nil }
            return pokemon.abilities.compactMap { abilities[$0.ability.url.extractedID!] }
        }
        
        var loadingPokemons = false
        var pokemonsLoadingError: AppError?
        var isSFViewActive = false
        
        var searchText = ""
        
        struct SelectionState {
            var expandingIndex: Int?
            var panelIndex: Int? = nil
            var panelPresented = false
            
            func isExpanding(_ id: Int) -> Bool {
                expandingIndex == id
            }
        }
        var selectionState = SelectionState()
        
        var allPokemonsById: [PokemonViewModel] {
            guard let pokemons = pokemons?.values else {
                return []
            }
            return pokemons.sorted { $0.id < $1.id }
        }
    }
}

extension AppState {
    struct MainTab {
        enum Index: Hashable {
            case list, settings
        }
        
        var selection: Index = .list
    }
}
