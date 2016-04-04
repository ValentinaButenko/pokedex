//
//  Pokemon.swift
//  Pokedex
//
//  Created by Valentina Butenko on 3/30/16.
//  Copyright © 2016 Valentina Butenko. All rights reserved.
//

import Foundation
import Alamofire

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
    private var _pokemonUrl: String!
    
    
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
        
        _pokemonUrl = "\(BASE_URL)\(POKEMON_URL)\(self._pokedexId)/"
    }
    
    
    func DowloadPokemonDetails(completed: DownloadComplete) {
        
        if let url = NSURL(string: _pokemonUrl){
            
            Alamofire.request(.GET, url).responseJSON(completionHandler: { response in
                let result = response.result
                
                if let dict = result.value as? Dictionary<String, AnyObject>{
                    if let weight = dict["weight"] as? String{
                        self._weight = weight
                    }
                    
                    if let height = dict["height"] as? String{
                        self._height = height
                    }
                    
                    if let attack = dict["attack"] as? Int{
                        self._attack = "\(attack)"
                    }
                    
                    if let defence = dict["defense"] as? Int{
                        self._defence = "\(defence)"
                    }
                    
                    if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                        if let type = types[0]["name"]{
                            self._type = type.capitalizedString
                        }
                        
                        if types.count > 1{
                            
                            for x in 1 ..< types.count {
                                if let type = types[x]["name"]{
                                    self._type! += "/\(type)".capitalizedString
                                }
                            }
                        } else {
                            self._type = ""
                        }
                    }
                        
                    }
                
            })
        
        }
        
        
        
    }

}