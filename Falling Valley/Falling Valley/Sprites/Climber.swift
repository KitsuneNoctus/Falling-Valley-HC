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
        let size = CGSize(width: 45, height: 45)
        super.init(texture: square, color: .clear, size: size)
        self.name = "Climber"
        self.zPosition = 3

        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.Climber
//        self.physicsBody?.collisionBitMask = PhysicsCategory.Rope
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Rope
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
