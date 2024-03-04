//
//  AppError.swift
//  PokeMaster
//
//  Created by user on 2024/2/23.
//

import Foundation

enum AppError: Error, Identifiable {
    var id: String { localizedDescription }
    
    case passwordWrong
    case networkingFailed(Error)
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .passwordWrong:
            return "密碼錯誤"
        case .networkingFailed(let error):
            return error.localizedDescription
        }
    }
}
