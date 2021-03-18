//
//  Clouds.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/17/21.
//

import UIKit
import SpriteKit

class Clouds: SKSpriteNode {
    init(){
        let texture = SKTexture(imageNamed: "clouds")
        let size = CGSize(width: 300, height: 110)
        super.init(texture: texture, color: .clear, size: size)
        self.zPosition = -10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func movement(){
//        let moveDown = SKAction.moveTo(y: - 30, duration: 20)
//        let moveUp = SKAction.moveTo(y: self.position.y + 30, duration: 20)
        
//        let objects = SKAction.sequence([moveDown,moveUp])
//        let startMoving = SKAction.repeatForever(objects)
//        self.run(startMoving)
    }
}
