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
    
    func configureCell(pokemon: PokemonSearchItem){
        
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        
        RxAlamofire.request(.get, self.pokemon.defaultSpritesURL!)   .validate(statusCode:200..<300)
            .responseData()
            .take(1)
            .map({(httpResponse,data)->UIImage in
                return UIImage(data:data)!
            })
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {uiImage in
                self.pokemonImage.image = uiImage
            }, onError: {_ in })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemon = nil
        nameLabel.text = nil
        pokemonImage.image = nil
    }
    
    /*
    
    func dequeueReusableCell(withReuseIdentifier identifier: String,
                             for indexPath: IndexPath) -> UICollectionViewCell{
        
    }
 */
}
