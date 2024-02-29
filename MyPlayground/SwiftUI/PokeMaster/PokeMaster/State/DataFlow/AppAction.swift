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
}
