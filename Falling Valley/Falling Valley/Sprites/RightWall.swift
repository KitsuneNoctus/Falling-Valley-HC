//
//  RightWall.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/17/21.
//

import UIKit
import SpriteKit

class RightWall: SKSpriteNode {
    init(scene: SKScene) {
        let texture = SKTexture(imageNamed: "rightWall")
        let size = CGSize(width: 20, height: scene.size.height + 100)
        super.init(texture: texture, color: .clear, size: size)
        self.name = "rightWall"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
