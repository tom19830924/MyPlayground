//
//  LoadAbilitiesRequest.swift
//  PokeMaster
//
//  Created by user on 2024/3/4.
//

import Foundation
import Combine

struct LoadAbilityRequest {
    let pokemonAbility: Pokemon.AbilityEntry

    var publisher: AnyPublisher<AbilityViewModel, AppError> {
        URLSession.shared
            .dataTaskPublisher(for: pokemonAbility.ability.url)
            .map { $0.data }
            .decode(type: Ability.self, decoder: appDecoder)
            .map { AbilityViewModel(ability: $0) }
            .mapError { AppError.networkingFailed($0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
