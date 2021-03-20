//
//  HomeViewController.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/15/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var charactersButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var creditsButton: UIButton!
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersButton.isEnabled = false
        settingsButton.isEnabled = false
    }
    
    //MARK: Button Actions
    @IBAction func pressPlay(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "gameViewController") as! GameViewController
        vc.chosenCharacter = .climber1
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func characterNav(_ sender: UIButton) {
        print("Nothing Yet!")
    }
    
    @IBAction func settingsNAV(_ sender: UIButton) {
        print("Nothing Yet!")
    }
    
    @IBAction func creditsNav(_ sender: UIButton) {
        print("Is this working?")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "creditsViewController") as! CreditsViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}
