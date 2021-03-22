//
//  GameScene.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/15/21.
//

import SpriteKit
import GameplayKit
import AVFoundation

enum GameSceneState {
    case active, gameOver
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var time: Int = 0
    var timing: CFTimeInterval = 0
    
    let timerLabel = SKLabelNode(fontNamed: UIFont.boldSystemFont(ofSize: 16).fontName)
    let scrollSpeed: CGFloat = 100
    
    //Game Management
    var gameState: GameSceneState = .active
    
    var sinceTouch: CFTimeInterval = 0
    let fixedDelta: CFTimeInterval = 1.0 / 60.0
    
    //Items
    var player: Climber!
    var chosenCharacter: Characters = .climber1
    var scroll: SKNode!
    var rope1: SKSpriteNode!
    var rope2: SKSpriteNode!
    
    var leftWallBottom: SKSpriteNode!
    var leftWallTop: SKSpriteNode!
    var rightWallBottom: SKSpriteNode!
    var rightWallTop: SKSpriteNode!
    
    //Sounds
    let jump = SKAction.playSoundFileNamed("jumpSound1.mp3", waitForCompletion: false)
    
    //MARK: Did Move
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(named: "skyColor") ?? .blue
        
//        scroll = scrollLayer(scene: self)
//        scroll.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
//        self.addChild(scroll)
        
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
        
//        scrollWorld()
        createWalls()
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
//        timing += fixedDelta
//        time += Int(timing/0.6)
//        timerLabel.text = "Time: \(time)"
        
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
        
        if (self.frame.width/2)-40 <= player.position.x && player.position.x <= (self.frame.width/2)+40{
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0.2))
            let playerVelocityY = player.physicsBody?.velocity.dy ?? 0
            if playerVelocityY > 10{
                player.physicsBody?.velocity.dy = 10
            }
        }
        scrollRope()
        scrollWalls()
        
        let playerVelocityY = player.physicsBody?.velocity.dy ?? 0
        if playerVelocityY > 100{
            player.physicsBody?.velocity.dy = 100
        }
        
        if playerVelocityY < -110{
            player.physicsBody?.velocity.dy = -110
        }
        
        if player.position.y >= self.frame.height - (player.size.height/2){
            player.position.y = self.frame.height - (player.size.height/2)
        }
        
        // Update Timer
        sinceTouch += fixedDelta
    }
    
    //MARK: Creation
    func createPlayer(){
        player = Climber(character: chosenCharacter)
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
        self.rope1 = Rope(scene: self)
        self.rope2 = Rope(scene: self)
        self.rope1.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        self.rope2.position = CGPoint(x: self.frame.width/2, y: self.frame.height + (self.frame.height/2))
        self.addChild(rope1)
        self.addChild(rope2)
    }
    
    func createClouds(){
        let clouds = Clouds()
        clouds.movement()
        clouds.position = CGPoint(x: self.frame.width/2, y: (self.frame.height/2)+70)
        self.addChild(clouds)
    }
    
    func createWalls(){
        self.leftWallBottom = LeftWall(scene: self)
        self.leftWallTop = LeftWall(scene: self)
        
        self.rightWallBottom = RightWall(scene: self)
        self.rightWallTop = RightWall(scene: self)
        
        self.leftWallBottom.position = CGPoint(x: 10, y: 0)
        self.leftWallTop.position = CGPoint(x:10,y:self.frame.height+100)
        self.rightWallBottom.position = CGPoint(x: self.frame.width-10, y: 0)
        self.rightWallTop.position = CGPoint(x:self.frame.width-10,y:self.frame.height+100)
        
        self.addChild(leftWallBottom)
        self.addChild(leftWallTop)
        self.addChild(rightWallBottom)
        self.addChild(rightWallTop)
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
        timerLabel.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run({
                self.time += 1
                self.timerLabel.text = "Time: \(self.time)"
            }),
             SKAction.wait(forDuration: 1)
             ])))
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
//        rightWallTop.position.y -= 10
//        rightWallBottom.position.y -= 10
//        leftWallTop.position.y -= 10
//        leftWallBottom.position.y -= 10
        
        if gameState != .active { return }
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))
        player.run(jump)
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
            player.removeAllActions()
        }
    }
    
    //MARK: Game Over
    func gameOver(){
        let gameOverScene = GameOverScene(size: (self.view?.bounds.size)!)
        gameOverScene.scaleMode = .aspectFill
        gameOverScene.time = Int(time)
        let crossFade = SKTransition.crossFade(withDuration: 0.75)
        view?.presentScene(gameOverScene, transition: crossFade)
    }
    
    //MARK: Scroll World
//    func scrollWorld(){
//        /* Scroll World */
//        scroll.position.x -= scrollSpeed * CGFloat(fixedDelta)
//
//        /* Loop through scroll layer nodes */
//        for wall in scroll.children as! [SKSpriteNode] {
//
//            /* Get ground node position, convert node position to scene space */
//            let wallPosition = scroll.convert(wall.position, to: self)
//
//            /* Check if ground sprite has left the scene */
//            if wallPosition.y <= -wall.size.width / 2 {
//
//                /* Reposition ground sprite to the second starting position */
//                let newPosition = CGPoint(x: wallPosition.x, y: (self.size.width / 2) + wall.size.height)
//
//                /* Convert new node position back to scroll layer space */
//                wall.position = self.convert(newPosition, to: scroll)
//            }
//        }
//    }
    
    func scrollRope(){
        rope1.position.y -= scrollSpeed * CGFloat(fixedDelta)
        rope2.position.y -= scrollSpeed * CGFloat(fixedDelta)
        for node in self.children{
            if node.name == "Rope"{
                if node.position.y <= -node.frame.size.height / 2 {
                    let newPosition = CGPoint(x: self.frame.width/2, y: self.size.height + (self.size.height/2))
                    node.position = newPosition
                }
            }
        }

    }
//    func scrollWallsL(){
//        leftWallTop.position.y -= scrollSpeed * CGFloat(fixedDelta)
//        leftWallBottom.position.y -= scrollSpeed * CGFloat(fixedDelta)
//        for node in self.children{
//        }
//    }
    
    func scrollWalls(){
        rightWallTop.position.y -= scrollSpeed * CGFloat(fixedDelta)
        rightWallBottom.position.y -= scrollSpeed * CGFloat(fixedDelta)
        leftWallTop.position.y -= scrollSpeed * CGFloat(fixedDelta)
        leftWallBottom.position.y -= scrollSpeed * CGFloat(fixedDelta)
        
        for node in self.children{
            if node.name == "leftWall"{
                if node.position.y <= -node.frame.size.height / 2 {
                    let newPosition = CGPoint(x: node.position.x, y: (self.size.height+100) + ((self.size.height+100)/2))
                    node.position = newPosition
                }
            }
            
            if node.name == "rightWall"{
                if node.position.y <= -node.frame.size.height / 2 {
                    let newPosition = CGPoint(x: node.position.x, y: (self.size.height+100) + ((self.size.height+100)/2))
                    node.position = newPosition
                }
            }
        }
    }
}
