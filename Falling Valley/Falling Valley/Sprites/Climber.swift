//
//  Climber.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/15/21.
//

import UIKit
import SpriteKit
import GameplayKit

class Climber: SKSpriteNode {

    //MARK: Init
    init(){
        let square = SKTexture(imageNamed: "climberCharacter")
        let size = CGSize(width: 30, height: 30)
        super.init(texture: square, color: .clear, size: size)

        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Climber
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Actions
    func move(){
        
    }
    
    func jump(){
        
    }
}
