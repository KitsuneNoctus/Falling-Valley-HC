//
//  HomeViewController.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/15/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Falling Valley"
        return label
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let characterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.axis = .vertical
        return stack
    }()
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: Setup
    func setupView(){
        self.view.addSubview(titleLabel)
        self.view.addSubview(vStack)
        self.vStack.addArrangedSubview(playButton)
        self.vStack.addArrangedSubview(characterButton)
        self.vStack.addArrangedSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            
        ])
    }
    
}
