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
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .passwordWrong:
            return "密碼錯誤"
        }
    }
}
