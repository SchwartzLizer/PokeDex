//
//  PokemonService.swift
//  PokeDex
//
//  Created by Tanatip Denduangchai on 7/25/20.
//  Copyright © 2020 Tanatip Denduangchai. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire


class Helper{
    
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }()
}


class PokemonService{
    private var _imageCache = NSCache<NSString,UIImage>()
    
    static var Shared = PokemonService()
    
    func getPokemonByName(pokemonName:String) -> Observable<(HTTPURLResponse,Pokemon)>{
        return RxAlamofire.request(.get, "https://pokeapi.co/api/v2/pokemon/\(pokemonName)")
            .validate(statusCode:200..<300)
            .responseData()
            .map { (HTTPURLResponse, data) -> (HTTPURLResponse, Pokemon) in
                let pokemon = try? Helper.decoder.decode(Pokemon.self, from: data)
            return (HTTPURLResponse,pokemon!)
        };
    }
    
    func getPokemons()-> Observable<(HTTPURLResponse,PokemonSearchResult)>{
        return RxAlamofire.requestDecodable(.get, "https://pokeapi.co/api/v2/pokemon?limit=2000");
    }
    
    func getPokemonDefaultSprite(pokemonId:Int)-> Observable<UIImage>{
        let key = String(pokemonId)
        let defaultSpritesURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonId).png")!
        // Check image in cache first
        if let cachedImage = _imageCache.object(forKey: NSString(string:key)){
            return Observable.just(cachedImage)
        }else{
            return RxAlamofire.request(.get, defaultSpritesURL)
                .validate(statusCode:200..<300)
                .responseData()
                .take(1)
                .map({(httpResponse,data)->UIImage in
                    let image = UIImage(data:data)!
                    self._imageCache.setObject(image, forKey: NSString(string:key))
                    return image
                })
                .observeOn(MainScheduler.instance)
        }
    }
    /*
    
    func GetEntityById<T: NamedAPIResource>(id: Int) -> Observable<T>{
        return RxAlamofire.request(.get, "https://pokeapi.co/api/v2/\(PokemonService.GetEndpointName(t: T.self))/\(id)")
            .validate(statusCode: 200..<300)
            .responseData()
            .map { (HTTPURLResponse, data) -> T in
              let entity = try Helper.decoder.decode(T.self, from: data)
              entity.isLoaded.onNext(true)
              return entity
            }
            .debug();
    }
    */
    
    /*
    private static func GetEndpointName(t: AnyClass) -> String{
        var endPointName : String = ""
        switch (t) {
        case is Stat.Type:
            endPointName = "stat"
            break
        case is Pokemon.Type:
            endPointName = "pokemon"
            break
        default:
            print("WrongType")
            break
        }
        return endPointName
    }
    
    private static func GetEndpointName(entity: AnyObject) -> String{
        return PokemonService.GetEndpointName(t: type(of:entity))
    }
    */
    
   /* func GetEntity<T: NamedAPIResource>(entity: T) -> Observable<T>{
        return RxAlamofire.request(.get, "https://pokeapi.co/api/v2/\(PokemonService.GetEndpointName(entity: entity))/\(entity.id)")
            .validate(statusCode: 200..<300)
            .responseData()
            .map { (HTTPURLResponse, data) -> T in
              let entity = try Helper.decoder.decode(T.self, from: data)
              entity.isLoaded.onNext(true)
              return entity
            }
            .debug();
    }*/
}
