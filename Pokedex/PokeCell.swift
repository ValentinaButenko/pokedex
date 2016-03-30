//
//  PokeCell.swift
//  Pokedex
//
//  Created by Valentina Butenko on 3/30/16.
//  Copyright © 2016 Valentina Butenko. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var pokemonNameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    
    
    
    func configureCell(pokemon: Pokemon){
        
        self.pokemon = pokemon
        pokemonNameLbl.text = self.pokemon.name.capitalizedString
        pokemonImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
    }
    
}
