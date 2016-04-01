//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Valentina Butenko on 4/1/16.
//  Copyright © 2016 Valentina Butenko. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var testLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        testLbl.text = pokemon.name

    }



}
