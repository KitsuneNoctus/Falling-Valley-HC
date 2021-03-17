//
//  Rock.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/16/21.
//

import UIKit
import SpriteKit
import GameplayKit

class Rock: SKSpriteNode {
    
    //MARK: Init
    init(){
        let square = SKTexture(imageNamed: "basicRock")
        let size = CGSize(width: 55, height: 55)
        super.init(texture: square, color: .clear, size: size)
        /// Physics
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.friction = 0
        self.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
//        self.physicsBody?.collisionBitMask =
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func spawn(scene: SKScene){
        
    }
    
    //MARK: Actions
    func fall(){
        
    }

}
