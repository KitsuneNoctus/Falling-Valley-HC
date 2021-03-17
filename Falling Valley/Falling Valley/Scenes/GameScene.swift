//
//  GameScene.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/15/21.
//

import SpriteKit
import GameplayKit

enum GameSceneState {
    case active, gameOver
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var points = 0
    
    //Game Management
    var gameState: GameSceneState = .active
    
    var sinceTouch: CFTimeInterval = 0
    let fixedDelta: CFTimeInterval = 1.0 / 60.0
    
    //Items
    var player: Climber!
    
    //MARK: Did Move
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(named: "skyColor") ?? .blue
        
        /// Swipe Right
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight(sender:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        /// Swipe Left
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft(sender:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        //Physics World
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.5)
        
        createPlayer()
        spawnRocks()
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        let playerVelocityY = player.physicsBody?.velocity.dy ?? 0
        if playerVelocityY > 100{
            player.physicsBody?.velocity.dy = 100
        }
        
        if playerVelocityY < -110{
            player.physicsBody?.velocity.dy = -110
        }
        
        // Update Timer
        sinceTouch += fixedDelta
    }
    
    //MARK: Creation
    func createPlayer(){
        player = Climber()
        player.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        self.addChild(player)
    }
    
    func spawnRocks(){
        var randomTime:Double = 5.0
        let generateTime = SKAction.run {
            randomTime = Double.random(in: 1...5)
        }
        let wait = SKAction.wait(forDuration: randomTime)
        let createObject = SKAction.run{
            self.creatRock()
        }
        let objects = SKAction.sequence([generateTime,wait,createObject])
        let showerObjects = SKAction.repeatForever(objects)
        self.run(showerObjects)
    }
    
    func creatRock(){
        let rock = Rock()
        rock.placeRock(scene: self)
        rock.zPosition = 2
        self.addChild(rock)
    }
    
    
    //MARK: Touches
    
    @objc func swipedRight(sender:UISwipeGestureRecognizer){
        print("swiped right")
        let moveRight = SKAction.move(to: CGPoint(x: self.frame.width - (player.size.width/2), y: player.position.y), duration: 2)
        player.run(SKAction.sequence([moveRight]))
    }
    
    @objc func swipedLeft(sender:UISwipeGestureRecognizer){
        print("Swiped left")
        let moveLeft = SKAction.move(to: CGPoint(x: 0 + (player.size.width/2), y: player.position.y), duration: 2)
        player.run(SKAction.sequence([moveLeft]))
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameState != .active { return }
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))
        sinceTouch = 0
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
