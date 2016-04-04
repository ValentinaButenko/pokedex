//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Valentina Butenko on 4/1/16.
//  Copyright © 2016 Valentina Butenko. All rights reserved.
//

import UIKit
import Alamofire

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var pokemonNameLbl: UILabel!
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var pokemonDetailsLbl: UILabel!
    @IBOutlet weak var pokemonTypeLbl: UILabel!
    @IBOutlet weak var pokemonDefLbl: UILabel!
    @IBOutlet weak var pokemonHeightLbl: UILabel!
    @IBOutlet weak var pokemonWeightLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var pokemonBaseAttLbl: UILabel!
    @IBOutlet weak var nextEvoLbl: UILabel!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var next1EvoImg: UIImageView!
    
    var pokemon: Pokemon!
    


    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonNameLbl.text = pokemon.name.uppercaseString
        pokedexIDLbl.text = "\(pokemon.pokedexId)"
        pokemonImg.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.DowloadPokemonDetails { () -> () in
         // this will be called after Download is done 
            
        }
        

    }



}
