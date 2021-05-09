//
//  GameScene.swift
//  Dino Jump
//
//  Created by Akbar Priyonggo on 09/05/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player:SKSpriteNode!
    var ground:SKSpriteNode!
    var actualDuration:CGFloat = 7.0
    var obstacle: [SKSpriteNode]! = []
    var gameOverLabel : SKLabelNode!
    var tapAnywhareToReset : SKLabelNode!
    var isGameOver : Bool = false
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        player = (childNode(withName: "player") as! SKSpriteNode)
        ground = (childNode(withName: "ground") as! SKSpriteNode)
        setupGameOverLabel()
        
       addObstacle()
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addObstacle), SKAction.wait(forDuration: 1.75)])))
        run(SKAction.stop())
 
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
       
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isGameOver{
            if player?.physicsBody?.velocity.dy == 0 {
                jump()
            }
        }
        
        
        if(isGameOver){
            resumeGame()
        }
        
        
    }
    func resumeGame(){
        player.isPaused = false
        gameOverLabel.isHidden = true
        tapAnywhareToReset.isHidden = true
        isGameOver = false
        resetGame()
    }
    func setupGameOverLabel(){
        gameOverLabel = SKLabelNode(fontNamed: "SanFranciscoDisplay-Regular")
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        gameOverLabel.fontSize = 40
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontColor = .black
        gameOverLabel.isHidden = true
        addChild(gameOverLabel)
        // setup Tap Anywhere
        tapAnywhareToReset = SKLabelNode(fontNamed: "SanFranciscoDisplay-Regular")
        tapAnywhareToReset.position = CGPoint(x: frame.midX, y: frame.midY-60)
        tapAnywhareToReset.fontSize = 30
        tapAnywhareToReset.text = "Tap Anywhare to Restart"
        tapAnywhareToReset.fontColor = .black
        tapAnywhareToReset.isHidden = true
        addChild(tapAnywhareToReset)
    }
    func resetGame(){
        for obs in obstacle{
            obs.removeFromParent()
        }
        obstacle = []
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func jump() {
        player?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30))
    }
    var tempObstacle : SKSpriteNode?
    func addObstacle() {
        tempObstacle = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "obstacle.png")))
        
        
        if let obstacleUnwrap = tempObstacle {
            
            obstacleUnwrap.position = CGPoint(x: size.width, y: -97)
            obstacle.append(obstacleUnwrap)
            addChild(obstacleUnwrap)
        }
        
        actualDuration -= 0.05
        if actualDuration <= 3.0 {
            actualDuration = 3.0
        }
        print(actualDuration)
        
        let actualMove = SKAction.move(to: CGPoint(x: -(scene?.frame.width)!, y: -78.5), duration: TimeInterval(actualDuration))
        
        let actualMoveDone = SKAction.removeFromParent()
        
        if let obstacleUnwrap = tempObstacle {
            obstacleUnwrap.run(SKAction.sequence([actualMove, actualMoveDone]))
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        for obs in obstacle{
            if let playerUnwrap = player, let obstacleUnwrap = obs as? SKSpriteNode {
                if playerUnwrap.intersects(obstacleUnwrap) {
                    pauseGame()
                }
            }
        }
        
        
    }
    func pauseGame(){
        player.isPaused = true
        isGameOver = true
        for obs in obstacle{
            obs.isPaused = true;
        }
        gameOverLabel.isHidden = false
        tapAnywhareToReset.isHidden = false
    }

}
