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

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImage : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    var pokemon: PokemonSearchItem!
    
    func configureCell(pokemon: PokemonSearchItem){
        
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        if let data = try? Data(contentsOf:self.pokemon.defaultSpritesURL!){
            let image = UIImage(data:data)
            pokemonImage.image = image
        }
        else{
            // Do something with error such as load a placeholder image
        }
    }	
}
