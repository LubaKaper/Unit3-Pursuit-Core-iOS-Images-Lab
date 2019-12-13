//
//  PokemonViewController.swift
//  Unit3-Pursuit-Core-iOS-Images-Lab
//
//  Created by Liubov Kaper  on 12/10/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    var pokemons = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
//    var weakness = [Weakness]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    var searchQuary = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        loadData()
       //searchPokemons(searchQ: searchQuary)
    }
    
    func loadData() {
        PokemonAPIClient.getPokemon ( completion: { [weak self](result) in
            switch result {
                case .failure(let appError):
                    print("error: \(appError)")
                    
                case .success(let pokemons):
                    DispatchQueue.main.async {
                        
                        self?.pokemons = pokemons.cards
                        //dump(pokemons)
                }
                }
            })
    }
        
        func searchPokemons(searchQ: String) {
            
            pokemons = pokemons.filter { $0.name?.first?.lowercased().contains(searchQ.lowercased()) ?? false}
//            PokemonAPIClient.getPokemon( completion:  { [weak self] (result) in
//                switch result {
//                case .failure(let appError):
//                    print("error: \(appError)")
//                    // TODO: alert controller
//                case .success(let pokemons):
//                    self?.pokemons = pokemons.cards.filter {($0.name?.lowercased().contains(self?.searchQuary.lowercased()) ?? false)}
//                }
//            })
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailPokemonVC = segue.destination as? DetailPokemonViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("error")
        }
        let allPokemonInfo = pokemons[indexPath.row]
        detailPokemonVC.pokemonInfo = allPokemonInfo
       // let wealnessInfo = weakness[indexPath.row]
       // detailPokemonVC.weakness = wealnessInfo
        
    }
    }
   


extension PokemonViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonCell else {
            fatalError("could not dequeue pokemonCell")
        }
        let pokemon = pokemons[indexPath.row]
        cell.configureCell(for: pokemon)
        cell.backgroundColor = .black
        return cell
    }
}

extension PokemonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        
        searchPokemons(searchQ: searchText)
    }

}
