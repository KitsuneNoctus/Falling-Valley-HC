//
//  HomeViewController.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/15/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupView()
    }
    @IBAction func pressPlay(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "gameViewController") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}
