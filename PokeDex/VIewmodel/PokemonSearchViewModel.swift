//
//  PokemonSearchViewModel.swift
//  PokeDex
//
//  Created by Tanatip Denduangchai on 7/25/20.
//  Copyright © 2020 Tanatip Denduangchai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PokemonSearchViewModel{
    private let _disposeBag = DisposeBag()
    private let _pokemonService:PokemonService = PokemonService()
    
    private var _allPokemons = Array<PokemonSearchItem>()
    
    public let filteredPokemons = BehaviorRelay<Array<PokemonSearchItem>>(value: Array<PokemonSearchItem>())
    
    public let text: BehaviorRelay<String> = BehaviorRelay<String>(value:"")
    
    init() {
        // Load All Pokemons
        _pokemonService.GetPokemons().map { (HTTPURLResponse, PokemonSearchResult) -> Array<PokemonSearchItem> in
            return PokemonSearchResult.results
        }.subscribe(onNext:{r in
            self._allPokemons = r
        }).disposed(by: _disposeBag)
        // Handler text searching with throttle
        text.debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance).distinctUntilChanged().map { (t) -> Array<PokemonSearchItem> in
            self._allPokemons.filter { (item) -> Bool in
                if(t.isEmpty) {
                    return true
                }
                else {
                    return item.name.uppercased().contains(t.uppercased())
                }
            }
        }.bind(to:filteredPokemons).disposed(by: _disposeBag)
        
    }
    
}
