//
//  DetailPokemonViewController.swift
//  Unit3-Pursuit-Core-iOS-Images-Lab
//
//  Created by Liubov Kaper  on 12/12/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var weaknessesLabel: UILabel!
    
    
    @IBOutlet weak var setLabel: UILabel!
    
    var pokemonInfo: Card?
    
    //var weakness: Weakness?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    func updateUI() {
        guard let pokemon = pokemonInfo else {
            fatalError("cpokemonInfo is nil, verify prepare for seque")
        }
//        guard let weak = weakness else {
//            fatalError("")
//        }
        view.backgroundColor = .yellow
        nameLabel.text = pokemon.name
        typesLabel.text = pokemon.types?.first
       
        weaknessesLabel.text = "\(pokemon.weaknesses?[0].type ?? "") and \(pokemon.weaknesses?[0].value ?? "")"
        setLabel.text = pokemon.set
        imageView.getImage(with: pokemon.imageUrlHiRes ) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "excaimationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }
   
}
