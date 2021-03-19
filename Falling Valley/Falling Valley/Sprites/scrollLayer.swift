//
//  scrollLayer.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/17/21.
//

import UIKit
import SpriteKit

class scrollLayer: SKNode {
    init(scene: SKScene){
        super.init()
        self.name = "scrollLayer"

        let leftBottom = LeftWall()
        let rightBottom = RightWall()
        rightBottom.position = CGPoint(x: scene.frame.width/2, y: scene.frame.height/2)
        self.addChild(rightBottom)
        leftBottom.position = CGPoint(x: 0+30, y: 0+100)
        self.addChild(leftBottom)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
