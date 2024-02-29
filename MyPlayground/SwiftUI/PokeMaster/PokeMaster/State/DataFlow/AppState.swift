//
//  AppState.swift
//  PokeMaster
//
//  Created by user on 2024/2/23.
//

import Foundation

struct AppState {
    var settings = Settings()
}

extension AppState {
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }
        enum AccountBehavior: CaseIterable {
            case register, login
        }
        
        var accountBehavior = AccountBehavior.login
        var email = ""
        var password = ""
        var verifyPassword = ""
        
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
        
        @FileStorage(directory: .documentDirectory, fileName: "user.json") var loginUser: User?
        
        var loginRequesting: Bool = false
        var loginError: AppError?
    }
}
