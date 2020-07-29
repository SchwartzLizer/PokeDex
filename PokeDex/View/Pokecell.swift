//
//  Pokecell.swift
//  PokeDex
//
//  Created by Tanatip Denduangchai on 7/25/20.
//  Copyright © 2020 Tanatip Denduangchai. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxAlamofire

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImage : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    var pokemon: PokemonSearchItem!
    
    var pokemonService = PokemonService.Shared
    
    var _disposeBag = DisposeBag()
    
    func configureCell(pokemon: PokemonSearchItem){
        
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        
        pokemonService.getPokemonDefaultSprite(pokemonId: self.pokemon.id)
        .subscribe(onNext: {uiImage in
            self.pokemonImage.image = uiImage
            }, onError: {_ in }).disposed(by: _disposeBag)
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemon = nil
        nameLabel.text = nil
        pokemonImage.image = nil
        _disposeBag = DisposeBag()
    }
    
    /*
    
    func dequeueReusableCell(withReuseIdentifier identifier: String,
                             for indexPath: IndexPath) -> UICollectionViewCell{
        
    }
 */
}
