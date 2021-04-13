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
        self.name = "Rock"
        /// Physics
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.friction = 0
        self.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
        self.physicsBody?.collisionBitMask = PhysicsCategory.Climber
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Climber
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func placeRock(scene: SKScene){
        if let view = scene.view{
            let pos1 = CGPoint(x: view.bounds.width-20, y: view.bounds.height+self.size.height)
            let pos2 = CGPoint(x: view.bounds.width/2, y: view.bounds.height+self.size.height)
            let pos3 = CGPoint(x: 20, y: view.bounds.height+self.size.height)
            let positions = [pos1,pos2,pos3,pos2]
            
            self.position = positions.randomElement()!
        }
    }
    
    //MARK: Actions
    func fall(){
        
    }

}
