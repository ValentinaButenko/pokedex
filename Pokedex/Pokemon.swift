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
    private var _description: String!
    private var _type: String!
    private var _defence: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvo: String!
    
    
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