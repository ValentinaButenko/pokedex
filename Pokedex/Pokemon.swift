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
    private var _nextEvoTxt: String!
    private var _nextEvoId: String!
    private var _pokemonUrl: String!
    private var _level: String!
    
    
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
    
    var description: String{
        get {
            if _description == nil{
                _description = ""
                }
            return _description
            }
    }
    
    var type: String{
        get{
            if _type == nil{
                _type = ""
                }
            return _type
            }
    }
    
    
    var defense: String{
        get{
            if _defence == nil{
                _defence = ""
            }
            return _defence
            }
    }
    
    var height: String{
        get{
            if _height == nil{
                _height = ""
            }
            return _height
        }
    }
    
    var weight: String{
        get{
            if _weight == nil {
                _weight = ""
            }
            return _weight
        }
    }
    
    var attack: String{
        get{
            if _attack == nil{
                _attack = ""
            }
            return _attack
        }
    }
    
    var nextEvoTxt: String{
        get{
            if _nextEvoTxt == nil{
                _nextEvoTxt = ""
            }
            return _nextEvoTxt
        }
    }
    
    var nextEvoId: String{
        get{
            if _nextEvoId == nil{
                _nextEvoId = ""
            }
            return _nextEvoId
        }
    }
    
    var pokemonUrl: String{
        
        get{
            if _pokemonUrl == nil{
                _pokemonUrl = ""
            }
            return _pokemonUrl
        }
    }
    
    var level: String{
        get{
            if _level == nil{
                _level = ""
            }
            return _level
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
                    
                    // ------------------------------------------
                    
                    if let descriptions = dict["descriptions"] as? [Dictionary<String,String>]{
                        if let desc = descriptions[0]["resource_uri"]{
                            
                            if let pokemonDescUrl = NSURL(string: "\(BASE_URL)\(desc)"){
                                Alamofire.request(.GET,pokemonDescUrl).responseJSON(completionHandler: {response in
                                
                                
                                    let result = response.result
                                    
                                    if let descDict = result.value as? Dictionary<String, AnyObject>{
                                    
                                        if let descript = descDict["description"] as? String{
                                            self._description = descript
                                        }
                                    }
                                    
                                  completed()
                                
                                })
                            }
                            
                        }
                    } else {
                        
                        self._description = ""
                    }
                    
                    // -------------------------------------------
                    
                    if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0{
                        
                        if let to = evolutions[0]["to"] as? String{
                            
                            // Mega wasn't found
                            if to.rangeOfString("mega") == nil {
                                
                                if let uri = evolutions[0]["resource_uri"] as? String{
                                    let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                    let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                    
                                    self._nextEvoId = num
                                    self._nextEvoTxt = to
                                    
                                    }
                                
                                if let level = evolutions[0]["level"] as? Int{
                                        
                                        self._level = "\(level)"
                                    }
                                    
                                
                            }
                        }
                        

                    }
                }
                
            })
        
        }
        
        
        
    }

}