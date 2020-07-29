//
//  Service.swift
//  PokeDex
//
//  Created by Tanatip Denduangchai on 7/22/20.
//  Copyright © 2020 Tanatip Denduangchai. All rights reserved.
//

import Foundation
import RxSwift

public class Pokemon : Codable {
    var id: Int
    var name: String
    var order: Int
    var baseExperience: Int
    var height: Int
    var weight: Int
    var sprites: Sprites
    var stats : [Stat]
    var types : [Type]
    
    }

class PokemonStatVM {
    var HP: Int = 0
    var attack: Int = 0
    var defend: Int = 0
    var speed: Int = 0
    var spattack: Int = 0
    var spdefend: Int = 0

    func GetTotal()->Int{
        return HP+attack+defend+speed+spattack+spdefend
    }
}

class PokemonTypeVM {
    var type1 : String?
    var type2 : String?
}

class Type : Codable {
    var slot : Int
    var type : Pokemontype
}

class Pokemontype : Codable{
    var name : String = ""
}

class NamedAPIResource : Decodable {
    var id:Int
    var name: String
    /*var isLoaded = BehaviorSubject<Bool>(value:false)*/
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    required public init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        var url:URL = try values.decode(URL.self, forKey: .url)
        id = Int(url.lastPathComponent)!
    }
}

/*

class Stat : NamedAPIResource{
    var gameIndex : Int
    var isBattleOnly : Int
    
    enum CodingKeys: String, CodingKey {
        case gameIndex
        case isBattleOnly
    }
    
    required public init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gameIndex = try values.decode(Int.self, forKey: .gameIndex)
        isBattleOnly = try values.decode(Int.self, forKey: .isBattleOnly)
        try super.init(from: decoder)
    }
}
*/

class Stat: Codable {
    var baseStat : Int
    var stat : StatURL
	
}

class StatURL: Codable {
    var name : String
}

class Sprites: Codable {
    var backDefault : URL?
    var backFemale : URL?
    var frontDefault : URL?
    var frontFemale : URL?
    var backShiny : URL?
    var backShinyFemale : URL?
    var frontShiny : URL?
    var frontShinyFemale : URL?
}
/*

class queryableBase : Codable{
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    var name:String;
    var url:String;
}
*/
