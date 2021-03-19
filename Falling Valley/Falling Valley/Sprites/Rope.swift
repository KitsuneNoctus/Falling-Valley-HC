//
//  Rope.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/17/21.
//

import UIKit
import SpriteKit

class Rope: SKSpriteNode {
    init(scene: SKScene){
        let texture = SKTexture(imageNamed: "rope")
        let size = CGSize(width: 5, height: (scene.view?.bounds.height)!+100)
        super.init(texture: texture, color: .clear, size: size)
        self.name = "Rope"
        
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.isDynamic = false
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.Rope
//        self.physicsBody?.collisionBitMask = PhysicsCategory.Climber
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Climber
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moving(){
        
    }
}
