//
//  Pokemon.swift
//  Pokedex
//
//  Created by Valentina Butenko on 3/30/16.
//  Copyright © 2016 Valentina Butenko. All rights reserved.
//

import Foundation

class Pokemon{
    
    private var _name: String!
    private var _pokedexId:Int!
    
    
    var name:String{
        get{
            return _name
        }
    }
    
    var pokedexId:Int{
        get{
            return _pokedexId
        }
    }
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
    }

}