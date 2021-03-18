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
    var time: CFTimeInterval = 0
    let timerLabel = SKLabelNode(fontNamed: UIFont.boldSystemFont(ofSize: 16).fontName)
    
    //Game Management
    var gameState: GameSceneState = .active
    
    var sinceTouch: CFTimeInterval = 0
    let fixedDelta: CFTimeInterval = 1.0 / 60.0
//    let fixedDelta: CFTimeInterval = 1.0 / 60.0
    
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
        
        createTimer()
        createClouds()
        generateRope()
        createPlayer()
        spawnRocks()
        startTimer()
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        time += fixedDelta
        timerLabel.text = "Time: \(time)"
        
        for node in self.children{
            if node.name == "Rock"{
                if node.position.y < -70{
                    node.removeFromParent()
                }
            }
            
            if node.name == "Climber"{
                if node.position.y < -70{
                    node.removeFromParent()
                    gameOver()
                }
            }
        }
        
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
        player.position = CGPoint(x: (frame.size.width/2), y: (frame.size.height/2))
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
    
    func generateRope(){
        let rope = Rope(scene: self)
        rope.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        self.addChild(rope)
    }
    
    func createClouds(){
        let clouds = Clouds()
        clouds.movement()
        clouds.position = CGPoint(x: self.frame.width/2, y: (self.frame.height/2)+70)
        self.addChild(clouds)
    }
    
    //MARK: Timer
    func createTimer(){
        timerLabel.text = "Time: \(time)"
        timerLabel.fontSize = 40
        timerLabel.zPosition = 10
        timerLabel.position = CGPoint(x: 30, y: self.frame.height-50)
        timerLabel.horizontalAlignmentMode = .left
        timerLabel.verticalAlignmentMode = .top
        self.addChild(timerLabel)
    }
    
    func startTimer(){
        
    }
    
    func endTimer(){
        
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
    
    //MARK: Physics Collision
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.Climber | PhysicsCategory.Obstacle{
            print("Collision occurred - end game")
            gameOver()
        }else if collision == PhysicsCategory.Climber | PhysicsCategory.Rope{
            print("Thats the rope")
        }
    }
    
    //MARK: Game Over
    func gameOver(){
        let gameOverScene = GameOverScene(size: (self.view?.bounds.size)!)
        gameOverScene.scaleMode = .aspectFill
        let crossFade = SKTransition.crossFade(withDuration: 0.75)
        view?.presentScene(gameOverScene, transition: crossFade)
    }
}
