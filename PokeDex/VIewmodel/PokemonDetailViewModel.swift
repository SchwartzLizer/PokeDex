//
//  PokemonDetailViewModel.swift
//  PokeDex
//
//  Created by Tanatip Denduangchai on 7/24/20.
//  Copyright © 2020 Tanatip Denduangchai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class PokemonDetailViewModel{
    private let _disposeBag = DisposeBag()
    private let _pokemonService:PokemonService
    
    let selectedPokemon = PublishSubject<PokemonSearchItem>()
    
    let pokemon: PublishSubject<Pokemon> = PublishSubject<Pokemon>()
    
    let pokemonBaseStat: PublishSubject<PokemonStatVM> = PublishSubject<PokemonStatVM>()
    
    let pokemonType: PublishSubject<PokemonTypeVM> = PublishSubject <PokemonTypeVM>()
    
    
    init(){
        self._pokemonService = PokemonService()
        
        let selectedPokeObs = selectedPokemon.map({p in
            self._pokemonService.GetPokemonByName(pokemonName: p.name)
            })
            .switchLatest().publish().refCount()
            
        selectedPokeObs.map { (HTTPURLResponse, Pokemon) -> Pokemon in
                return Pokemon
            }.subscribe(onNext:{result in
                self.pokemon.onNext(result)
            }, onError: {error in
                
            })
            .disposed(by:_disposeBag)
        
        selectedPokeObs.map { (HTTPURLResponse, Pokemon) -> Pokemon in
                 return Pokemon
             }.subscribe(onNext:{pokemon in
                let pokemonStatVM = PokemonStatVM()
                for stat in pokemon.stats {
                    switch stat.stat.name {
                    case "hp":
                        pokemonStatVM.HP = stat.baseStat
                    case "attack":
                        pokemonStatVM.attack = stat.baseStat
                    case "defense":
                        pokemonStatVM.defend = stat.baseStat
                    case "special-attack":
                        pokemonStatVM.spattack = stat.baseStat
                    case "special-defense":
                        pokemonStatVM.spdefend = stat.baseStat
                    case "speed":
                        pokemonStatVM.speed = stat.baseStat
                    default:
                        break
                    }
                    self.pokemonBaseStat.onNext(pokemonStatVM)
                }
                
                
                
             }, onError: {error in
                 
             })
             .disposed(by:_disposeBag)
        selectedPokeObs.map { (HTTPURLResponse, Pokemon) -> Pokemon in
                return Pokemon
        }.subscribe(onNext:{pokemon in
            let pokemonType = PokemonTypeVM()
                if pokemon.types.count == 2
                {
                    pokemonType.type1 = pokemon.types[0].type.name
                    pokemonType.type2 = pokemon.types[1].type.name
                }
                else if pokemon.types.count == 1
                {
                    pokemonType.type2 = pokemon.types[0].type.name
                }
            self.pokemonType.onNext(pokemonType)
            }, onError: {error in
            
        })
        .disposed(by:_disposeBag)
        selectedPokeObs.map { (HTTPURLResponse, Pokemon) -> Pokemon in
                return Pokemon
        }.subscribe(onNext:{pokemon in
            let pokemonType = PokemonTypeVM()
                if pokemon.types.count == 2
                {
                    pokemonType.type1 = pokemon.types[0].type.name
                    pokemonType.type2 = pokemon.types[1].type.name
                }
                else if pokemon.types.count == 1
                {
                    pokemonType.type2 = pokemon.types[0].type.name
                }
            self.pokemonType.onNext(pokemonType)
            }, onError: {error in
            
        })
        .disposed(by:_disposeBag)
        
        selectedPokeObs.map { (HTTPURLResponse, Pokemon) -> Pokemon in
                return Pokemon
        }.subscribe(onNext:{pokemon in
            let pokemonType = PokemonTypeVM()
                if pokemon.types.count == 2
                {
                    pokemonType.type1 = pokemon.types[0].type.name
                    pokemonType.type2 = pokemon.types[1].type.name
                }
                else if pokemon.types.count == 1
                {
                    pokemonType.type2 = pokemon.types[0].type.name
                }
            self.pokemonType.onNext(pokemonType)
            }, onError: {error in
            
        })
        .disposed(by:_disposeBag)
    }
}
