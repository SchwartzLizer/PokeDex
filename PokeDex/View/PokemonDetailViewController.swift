//
//  ViewControllerDetail.swift
//  PokeDex
//
//  Created by Tanatip Denduangchai on 7/25/20.
//  Copyright © 2020 Tanatip Denduangchai. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PokemonDetailViewController: UIViewController {
//    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var order: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var defend: UILabel!
    @IBOutlet weak var specialAttack: UILabel!
    @IBOutlet weak var specialDefend: UILabel!
    @IBOutlet weak var hp: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var Type1: UILabel!
    @IBOutlet weak var Type2: UILabel!
    
    private let _disposeBag = DisposeBag()
    //RxSwift : dispose
    let _viewModel = PokemonDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpNavBar()

        
        _viewModel.pokemon  //height show in details
            .map{pokemon->String? in
            return Optional(String(pokemon.height))}
        .bind(to: self.height.rx.text)
        .disposed(by: _disposeBag)
        
        _viewModel.pokemon //Weight show in details
            .map{pokemon->String? in
                return Optional(String(pokemon.weight))}
        .bind(to: self.weight.rx.text)
        .disposed(by: _disposeBag)
        
        _viewModel.pokemon //Pokemon ID show in details
            .map{pokemon->String? in
                return Optional("\(String(pokemon.order))#")}
        .bind(to: self.order.rx.text)
        .disposed(by: _disposeBag)
        
        // MARK: Stat
        
        _viewModel.pokemonBaseStat
            .map{stat->String? in
                return String(stat.speed ?? 0)}
        .bind(to: self.speed.rx.text)
        .disposed(by: _disposeBag)
        
        _viewModel.pokemonBaseStat
            .map{stat->String? in
                return String(stat.attack ?? 0)}
            .bind(to: self.attack.rx.text)
        .disposed(by: _disposeBag)
        
        _viewModel.pokemonBaseStat
            .map{stat->String? in
                return String(stat.defend ?? 0)}
            .bind(to: self.defend.rx.text)
        .disposed(by: _disposeBag)
        
        _viewModel.pokemonBaseStat
            .map{stat->String? in
                return String(stat.spattack ?? 0)}
            .bind(to: self.specialAttack.rx.text)
        .disposed(by: _disposeBag)
        
        _viewModel.pokemonBaseStat
            .map{stat->String? in
                return String(stat.spdefend ?? 0)}
            .bind(to: self.specialDefend.rx.text)
        .disposed(by: _disposeBag)
        
        _viewModel.pokemonBaseStat
            .map{stat->String? in
                return String(stat.HP ?? 0)}
        .bind(to: self.hp.rx.text)
        .disposed(by: _disposeBag)
        
        _viewModel.pokemonType
            .map{type->String? in
                return String(type.type1 ?? "")}
        .bind(to: self.Type1.rx.text)
        .disposed(by: _disposeBag)
        
        _viewModel.pokemonType
            .map{type->String? in
                return String(type.type2 ?? "")}
        .bind(to: self.Type2.rx.text)
        .disposed(by: _disposeBag)
        
        _viewModel.pokemonBaseStat
            .map{stat->String? in
                return String(stat.GetTotal())}
        .bind(to: self.total.rx.text)
        .disposed(by: _disposeBag)
        
        _viewModel.pokemonBaseStat
            .map{stat->String? in
                return String(stat.GetTotal())}
        .bind(to: self.total.rx.text)
        .disposed(by: _disposeBag)
        
        _viewModel.pokemon.subscribe(onNext:{pokemon in
            if let data = try? Data(contentsOf:pokemon.sprites.frontDefault!){
                let image = UIImage(data:data)
                self.image.image = image
            }
            else{
                // Do something with error such as load a placeholder image
            }
            }).disposed(by: _disposeBag)
    }
    func setUpNavBar() {
        self.navigationController?.view.backgroundColor = UIColor.white
        /*self.navigationController?.view.tintColor = UIColor.orange*/
        _viewModel.pokemon.subscribe(onNext:{
            n in self.navigationItem.title = n.name.capitalized
            
        })
            .disposed(by: _disposeBag)
        
        
        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

