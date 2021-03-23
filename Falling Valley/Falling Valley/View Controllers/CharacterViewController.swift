//
//  CharacterViewController.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/15/21.
//

import UIKit

class CharacterViewController: UIViewController {
    /// To be implemented
//    var CBCharacterSelect
    var homeViewController: HomeViewController? = nil
    
    var character: Characters = .climber1

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Choose Character
    @IBAction func Character1Chosen(_ sender: UIButton) {
        character = .climber1
        homeViewController?.setCharacter(character: character)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Character2Chosen(_ sender: UIButton) {
        character = .climber2
        homeViewController?.setCharacter(character: character)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Character3Chosen(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Character4Chosen(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Exit
    @IBAction func exit(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
