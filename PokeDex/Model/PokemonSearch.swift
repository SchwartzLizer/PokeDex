//
//  PokemonSearch.swift
//  PokeDex
//
//  Created by Tanatip Denduangchai on 7/24/20.
//  Copyright © 2020 Tanatip Denduangchai. All rights reserved.
//

import Foundation

class PokemonSearchResult : Decodable{
    var count : Int
    var previous : URL?
    var next : URL?
    var results : [PokemonSearchItem]
}

class PokemonSearchItem : NamedAPIResource{
    var defaultSpritesURL : URL?
    
    required public init(from decoder:Decoder) throws {
        try super.init(from: decoder)
        defaultSpritesURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
}

class Pokemon2 : NamedAPIResource {
    var order: Int?
    var baseExperience: Int?
    var height: Int?
    var weight: Int?
    var sprites: Sprites?
    
    enum CodingKeys: String, CodingKey {
        case order
        case baseExperience
        case height
        case weight
        case sprites
    }
    
    required public init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order = try values.decode(Int.self, forKey: .order)
        baseExperience = try values.decode(Int.self, forKey: .baseExperience)
        height = try values.decode(Int.self, forKey: .height)
        weight = try values.decode(Int.self, forKey: .weight)
        sprites = try values.decode(Sprites.self, forKey: .sprites)
        try super.init(from: decoder)
    }
}
