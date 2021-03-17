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
//        var size = CGSize(width: 5, height: 2000)
//        if let view = scene.view{
//            self.size = CGSize(width: 5, height: view.bounds.height+10)
//        }
//        super.init(texture: texture, color: .clear, size: size)
//        self.zPosition = 1
        super.init(texture: texture, color: .clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moving(){
        
    }
}
