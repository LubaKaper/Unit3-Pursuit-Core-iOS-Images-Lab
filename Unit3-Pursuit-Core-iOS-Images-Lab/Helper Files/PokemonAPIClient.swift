//
//  PokemonAPIClient.swift
//  Unit3-Pursuit-Core-iOS-Images-Lab
//
//  Created by Liubov Kaper  on 12/12/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import Foundation

struct PokemonAPIClient {
    
    static func getPokemon(completion: @escaping (Result <PokemonInfo, AppError>) -> ()) {
        let endpointURLString = "https://api.pokemontcg.io/v1/cards"
        
        NetworkHelper.shared.performDataTask(with: endpointURLString) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let pokemons = try JSONDecoder().decode(PokemonInfo.self, from: data)
                    completion(.success(pokemons))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
