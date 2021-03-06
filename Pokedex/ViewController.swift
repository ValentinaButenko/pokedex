//
//  ViewController.swift
//  Pokedex
//
//  Created by Valentina Butenko on 3/30/16.
//  Copyright © 2016 Valentina Butenko. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var toggleState = 1
    
    
    var inSearchMode = false
    var pokemonSearch = [Pokemon]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        parsePokemonCsv()
        playMusic()

    }
    
    func playMusic(){
        
        do{
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("pokemonMusic", ofType: "mp3")!))
                musicPlayer.prepareToPlay()
                musicPlayer.numberOfLoops = -1
                musicPlayer.play()
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
            }
    
    
    
    func parsePokemonCsv(){
    
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            
            let rows = csv.rows
            
            for row in rows{
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeID)
                pokemon.append(poke)
            }
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
    
    }
    
    @IBAction func stopMusic(sender: UIButton!) {
        
        if toggleState == 1{
            musicPlayer.pause()
            sender.alpha = 0.2
            toggleState = 2
        }else{
            musicPlayer.play()
            sender.alpha = 1.0
            toggleState = 1
        }

    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell{
            
            let poke:Pokemon!
            
            if inSearchMode{
                poke = pokemonSearch[indexPath.row]
            }else{
                poke = pokemon[indexPath.row]
            }

            cell.configureCell(poke)
            
            return cell
        }else{
            
            return UICollectionViewCell()
        }
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let poke: Pokemon!
        
        if inSearchMode{
            poke = pokemonSearch[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode{
            return pokemonSearch.count
        }
        
        return pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collectionView.reloadData()
        } else {
            inSearchMode = true
            // taking the word from searchBar 
            let word = searchBar.text!.lowercaseString
            pokemonSearch = pokemon.filter({$0.name.rangeOfString(word) != nil})
            collectionView.reloadData()
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // check for segue name
        if segue.identifier == "PokemonDetailVC"{
            
            // check for segue destination VC
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC{
                
                // check for sender
                if let tappedPoke = sender as? Pokemon{
                    
                    // transfer tapped object to the called VC
                    detailsVC.pokemon = tappedPoke
                    musicPlayer.pause()
                }
            }
        }
    }

}

