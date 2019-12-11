//
//  PokemonModel.swift
//  Unit3-Pursuit-Core-iOS-Images-Lab
//
//  Created by Liubov Kaper  on 12/10/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import Foundation

struct PokemonInfo: Decodable {
    let card: [Card]
}
struct Card: Decodable {
    let name: String
    let imageUrl: String
    let imageUrlHiRes: String
    let types: [String]
    let weaknesses: [Weakness]?
    let set: String
}

struct Weakness: Decodable {
    let type: String
    let value: String
}
