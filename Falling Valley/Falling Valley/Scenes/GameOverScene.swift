//
//  GameOverScene.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/15/21.
//

import SpriteKit


class GameOverScene: SKScene {
    
    let overLabel = SKLabelNode(fontNamed: UIFont.boldSystemFont(ofSize: 16).fontName)
    let timeLabel = SKLabelNode(fontNamed: UIFont.boldSystemFont(ofSize: 16).fontName)
    
    var time = 0
    
    override init(size: CGSize) {
        // do initial configuration work here
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    //MARK: Did Move
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(named: "skyColor") ?? .blue
        setLabels()
        createButton()
    }
    
    func setLabels(){
        overLabel.text = "Game Over"
//        overLabel.color = .black
        overLabel.fontSize = 40
        overLabel.zPosition = 5
        overLabel.position = CGPoint(x: frame.size.width/2, y: self.frame.midY + 100)
        overLabel.horizontalAlignmentMode = .center
        overLabel.verticalAlignmentMode = .center
        self.addChild(overLabel)
        
        timeLabel.text = "Final Time: \(time) seconds"
//        overLabel.color = .black
        timeLabel.fontSize = 40
        timeLabel.zPosition = 5
        timeLabel.position = CGPoint(x: frame.size.width/2, y: self.frame.midY - 100)
        timeLabel.horizontalAlignmentMode = .center
        timeLabel.verticalAlignmentMode = .center
        self.addChild(timeLabel)
    }
    
    //MARK: Buttons
    func createButton(){
        let buttonTexture = SKTexture(imageNamed: "playAgain")
        
        let button = ButtonNode(normalTexture: buttonTexture, selectedTexture: buttonTexture, disabledTexture: buttonTexture)
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameOverScene.playAgain))
        button.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        button.size.height = self.size.width/4
        button.size.width = self.size.width/2
        button.zPosition = 20
        button.name = "button"
        self.addChild(button)
    }
    
    @objc func playAgain(){
        let gameScene = GameScene(size: (self.view?.bounds.size)!)
        gameScene.scaleMode = .aspectFill
        let crossFade = SKTransition.crossFade(withDuration: 0.75)
        if let spriteview = self.view{
            spriteview.presentScene(gameScene, transition: crossFade)
        }
    }
}
