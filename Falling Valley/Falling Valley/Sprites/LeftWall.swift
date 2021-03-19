//
//  LeftWall.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/17/21.
//

import UIKit
import SpriteKit

class LeftWall: SKSpriteNode {
    init(scene: SKScene) {
        let texture = SKTexture(imageNamed: "leftWall")
        let size = CGSize(width: 20, height: scene.size.height + 100)
        super.init(texture: texture, color: .clear, size: size)
        self.name = "leftWall"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
