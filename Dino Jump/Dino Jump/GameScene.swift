//
//  GameScene.swift
//  Dino Jump
//
//  Created by Akbar Priyonggo on 09/05/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player:SKSpriteNode?
    var ground:SKSpriteNode?
    var actualDuration:CGFloat = 7.0
    var obstacle:SKSpriteNode?
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        player = (childNode(withName: "player") as! SKSpriteNode)
        ground = (childNode(withName: "ground") as! SKSpriteNode)
       
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
        if player?.physicsBody?.velocity.dy == 0 {
            jump()
        }
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
    
    func addObstacle() {
        obstacle = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "obstacle.png")))
        
        if let obstacleUnwrap = obstacle {
            
            obstacleUnwrap.position = CGPoint(x: size.width, y: -97)
            
            addChild(obstacleUnwrap)
        }
        
        actualDuration -= 0.05
        if actualDuration <= 3.0 {
            actualDuration = 3.0
        }
        print(actualDuration)
        
        let actualMove = SKAction.move(to: CGPoint(x: -(scene?.frame.width)!, y: -78.5), duration: TimeInterval(actualDuration))
        
        let actualMoveDone = SKAction.removeFromParent()
        
        if let obstacleUnwrap = obstacle {
            obstacleUnwrap.run(SKAction.sequence([actualMove, actualMoveDone]))
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let playerUnwrap = player, let obstacleUnwrap = obstacle {
            if playerUnwrap.intersects(obstacleUnwrap) {
                print("intersect")
            }
        }
    }
}
