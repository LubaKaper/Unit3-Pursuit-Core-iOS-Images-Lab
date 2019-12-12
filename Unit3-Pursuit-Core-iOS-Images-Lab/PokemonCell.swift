//
//  PokemonCell.swift
//  Unit3-Pursuit-Core-iOS-Images-Lab
//
//  Created by Liubov Kaper  on 12/12/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {

   
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    func configureCell(for pokemon: Card) {
        
       // print(pokemon.imageUrl)
        
        pokemonImageView.getImage(with: pokemon.imageUrlHiRes ) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.pokemonImageView.image = UIImage(systemName: "excaimationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.pokemonImageView.image = image
                }
            }
        }
    }
    
    
}

//NetworkHelper.shared.performDataTask(with: pokemon.imageUrl ?? "") { [weak self] (result) in
//           switch result {
//           case .failure
//
//           }
//       }
