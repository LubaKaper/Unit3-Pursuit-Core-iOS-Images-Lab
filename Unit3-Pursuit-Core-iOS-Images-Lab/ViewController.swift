//
//  ViewController.swift
//  Unit3-Pursuit-Core-iOS-Images-Lab
//
//  Created by Liubov Kaper  on 12/9/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var comivImageView: UIImageView!
    
    @IBOutlet weak var comicStepper: UIStepper!
    
    
    @IBOutlet weak var textField: UITextField!
    
    var comic: Comic!
    
    
    // create variable for a number of the comic(before didSet)
    //
    
    var comicNum = 1 {
        didSet {
            updateComicUI(comicNum)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        updateComicUI(0)
    }
    
    // function to put into didset to update image if the stepper is clicked(didset is for comicNum, that we have in IBAction for stepper)
    // takes in number of the comic
    func updateComicUI(_ num: Int) {
        ComicAPIClient.getComic(for: num) { [weak self] (result) in
            switch result {
            case .failure(let appErr):
                print("\(appErr)")
            case .success(let comic):
                DispatchQueue.main.async {
                self?.updateImage(for: comic)
                    //self?.comic.img(for: comic)
                }
            }
        }
    }
    
    func updateImage(for comic: Comic) {
        // update textview
        comivImageView.getImage(with: comic.img) { (result) in
            switch result {
            case .failure(let appError):
                print("error is \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.comivImageView.image = image
                }
                
            }
        }
        
    }
    
    @IBAction func changeComicStepper(_ sender: UIStepper) {
        comicNum = Int(sender.value)
    }
    
    
    @IBAction func recentButtonPressed(_ sender: UIButton) {
        updateComicUI(0)
        
    }
    
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        updateComicUI(.random(in: 1...2300))
    }
    
    
}

extension ViewController: UITextFieldDelegate {
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        print("textFieldShouldBeginEditing")
//        return true
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print("textFieldDidBeginEditing")
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       // if let x = string.rangeOfCharacter(from: NSCharacterSet.decimalDigits)
        if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
             return true
        } else if string == ""{
            return true
        } else {
             return false
          }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldshouldreturn")
//        guard let userInput = textField.text else {
//            return false
//        }
//        
//        for char in userInput{
//            if !char.isNumber{
//                return false
//            }
//        }
        let intTextField = Int(textField.text ?? "") ?? 0
       updateComicUI(intTextField)
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        textField.resignFirstResponder()
        return false
    }
}

