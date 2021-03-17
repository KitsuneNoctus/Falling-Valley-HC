//
//  GameScene.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/15/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: Climber!
    
    //MARK: Did Move
    override func didMove(to view: SKView) {
        
        //Physics World
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.5)
        
        createPlayer()
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    //MARK: Creation
    func createPlayer(){
        player = Climber()
        player.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        self.addChild(player)
    }
    
    
    //MARK: Touches
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
