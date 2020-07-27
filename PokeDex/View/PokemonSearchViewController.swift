//
//  PokemonSearchViewController.swift
//  PokeDex
//
//  Created by Tanatip Denduangchai on 7/25/20.
//  Copyright © 2020 Tanatip Denduangchai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PokemonSearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let _viewModel = PokemonSearchViewModel()
        
    private let _disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.rx.text.orEmpty.bind(to: _viewModel.text)
        .disposed(by: _disposeBag)
        _viewModel.filteredPokemons.asObservable().bind(to: collectionView.rx.items(cellIdentifier: "pokecell", cellType: PokeCell.self)){index, model, cell in
            cell.configureCell(pokemon: model)
        }.disposed(by: _disposeBag)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "ShowPokemonDetail":
            guard let pokemonDetailViewController = segue.destination as? PokemonDetailViewController else{
                fatalError("Unexpected estination: \(segue.destination)")
            }
            guard let selectedPokemonCell = sender as? PokeCell else{
                fatalError("Unexpected sender: \(sender)")
            }
            guard let indexPath = collectionView.indexPath(for: selectedPokemonCell) else{
                fatalError("The selected cell is not being display by the collectionView")
            }
            pokemonDetailViewController._viewModel.selectedPokemon.onNext(selectedPokemonCell.pokemon)
            //selectedPokemonCell.pokemon
            //collectionView.cellForItem(at: indexPath) as
            
        default:
            break
        }
    }
    

}
