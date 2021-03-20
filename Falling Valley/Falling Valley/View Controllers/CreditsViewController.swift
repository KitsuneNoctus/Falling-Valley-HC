//
//  CreditsViewController.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/20/21.
//

import UIKit

class CreditsViewController: UIViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func exitPage(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
