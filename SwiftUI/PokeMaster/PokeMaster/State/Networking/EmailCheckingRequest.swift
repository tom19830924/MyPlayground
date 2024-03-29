//
//  EmailCheckingRequest.swift
//  PokeMaster
//
//  Created by user on 2024/3/1.
//

import Foundation
import Combine

struct EmailCheckingRequest {
    let email: String
    
    var publisher: AnyPublisher<Bool, Never> {
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
                if self.email.lowercased() == "onevcat@gmail.com" {
                    promise(.success(false))
                }
                else {
                    promise(.success(true))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
