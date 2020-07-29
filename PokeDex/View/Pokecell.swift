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

class PokeCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImage : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    var pokemon: PokemonSearchItem!
    
    var pokemonService = PokemonService.Shared
    
    var _disposeBag = DisposeBag()
    
    func configureCell(pokemon: PokemonSearchItem){
        loadingIndicator.startAnimating()
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        
        pokemonService.getPokemonDefaultSprite(pokemonId: self.pokemon.id)
            .subscribe(onNext: {uiImage in
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
                self.pokemonImage.image = uiImage
            }, onError: {_ in
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
                self.pokemonImage.image = #imageLiteral(resourceName: "error")
            }).disposed(by: _disposeBag)
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemon = nil
        nameLabel.text = nil
        pokemonImage.image = nil
        _disposeBag = DisposeBag()
        self.loadingIndicator.isHidden = false
        self.loadingIndicator.startAnimating()
    }
}
