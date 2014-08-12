//
//  GameScene.swift
//  ZachsHouse
//
//  Created by Jonathan Gilmour on 20/07/2014.
//  Copyright (c) 2014 Jonathan Gilmour. All rights reserved.
//

import SpriteKit

struct PlatformDefaults: Printable {
	var height: CGFloat
	var width: CGFloat
	
	var description: String {
		return
			"{\n\tHeight: \(height)\n\tWidth: \(width)\n}"
	}
}

class GameScene: SKScene {
	init(size:CGSize)  {
		super.init(size: size)
		let path = NSBundle.mainBundle().pathForResource("config", ofType: "plist") as String
		let dict = NSDictionary(contentsOfFile: path) as Dictionary
		if let platformDefaultsDict = dict["Platform defaults"]! as? Dictionary<String,CGFloat> {
			let platformDefaults = PlatformDefaults(height: platformDefaultsDict["Height"]!, width: platformDefaultsDict["Height"]!)
			println(platformDefaults)
			println("\nDefaults loaded")
		}
		println("Init gamescene with default initialiser")
	}
	
	init(coder aDecoder: NSCoder!)
	{
		super.init(coder: aDecoder)
	}
	
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
		self.backgroundColor = SKColor(red: 156.0/255.0, green: 208.0/255.0, blue: 221.0/255.0, alpha: 1.0)
		self.scaleMode = SKSceneScaleMode.AspectFit
		self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
		self.physicsWorld.gravity = CGVectorMake(0.0, -3.0)
		
		let screenW = self.frame.size.width
		let screenH = self.frame.size.height
		
		let levelMinHeight = 100.0 as CGFloat
		let levelWidth = screenW as CGFloat
		
		/* Game Level Floor */
		let level = SKSpriteNode(imageNamed: "floor_i5s.png")
		level.position = CGPoint(x: levelWidth/2.0, y: levelMinHeight/2.0)
		level.physicsBody = SKPhysicsBody(rectangleOfSize: (level.texture.size()))
		level.physicsBody.restitution = 0.0
		level.physicsBody.dynamic = false
		level.physicsBody.friction = 0.2
		level.name = "level"
		level.userInteractionEnabled = true
		level.physicsBody.affectedByGravity = false
		self.addChild(level)
		
		/* Game Platform */
		var platformSize = CGSize(width: 256.0, height: 32.0)
		let platformA = SKShapeNode(rectOfSize: platformSize, cornerRadius: 3.0)
		platformA.fillColor = SKColor(red: 7.0/255.0, green: 158.0/255.0, blue: 71.0/255.0, alpha: 1.0)
		platformA.strokeColor = platformA.fillColor
		platformA.position = CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0 - 100.0)
		platformA.physicsBody = SKPhysicsBody(rectangleOfSize: (platformA.frame.size))
		platformA.physicsBody.restitution = 0.0
		platformA.physicsBody.dynamic = false
		platformA.physicsBody.friction = 0.2
		platformA.name = "platform"
		platformA.userInteractionEnabled = false
		platformA.physicsBody.affectedByGravity = false
		self.addChild(platformA)
		/* Game Platform */
		platformSize = CGSize(width: 128.0, height: 32.0)
		let platformB = SKShapeNode(rectOfSize: platformSize, cornerRadius: 3.0)
		platformB.fillColor = SKColor(red: 0.0/255.0, green: 188.0/255.0, blue: 71.0/255.0, alpha: 1.0)
		platformB.strokeColor = platformB.fillColor
		platformB.position = CGPoint(x: self.frame.size.width/2.0 + 150.0, y: self.frame.size.height/2.0 + 200.0)
		platformB.physicsBody = SKPhysicsBody(rectangleOfSize: (platformB.frame.size))
		platformB.physicsBody.restitution = 0.0
		platformB.physicsBody.dynamic = false
		platformB.physicsBody.friction = 0.2
		platformB.name = "platform"
		platformB.userInteractionEnabled = false
		platformB.physicsBody.affectedByGravity = false
		self.addChild(platformB)
		/* Game Platform */
		platformSize = CGSize(width: 180.0, height: 32.0)
		let platformC = SKShapeNode(rectOfSize: platformSize, cornerRadius: 3.0)
		platformC.fillColor = SKColor(red: 7.0/255.0, green: 108.0/255.0, blue: 11.0/255.0, alpha: 1.0)
		platformC.strokeColor = platformC.fillColor
		platformC.position = CGPoint(x: self.frame.size.width/2.0 - 150.0, y: self.frame.size.height/2.0)
		platformC.physicsBody = SKPhysicsBody(rectangleOfSize: (platformC.frame.size))
		platformC.physicsBody.restitution = 0.0
		platformC.physicsBody.dynamic = false
		platformC.physicsBody.friction = 0.2
		platformC.name = "platform"
		platformC.userInteractionEnabled = false
		platformC.physicsBody.affectedByGravity = false
		self.addChild(platformC)
		
		/* Character */
		let charSize = 64.0 as CGFloat
		let boxtangle = SKShapeNode(rectOfSize:(CGSize(width: charSize, height: charSize)))
		boxtangle.position = CGPoint(x: level.position.x, y: level.position.y + level.frame.height/2.0 + boxtangle.frame.height/2.0)
		boxtangle.frame.size
		boxtangle.physicsBody = SKPhysicsBody(rectangleOfSize: (boxtangle.frame.size))
		boxtangle.physicsBody.dynamic = true
		boxtangle.fillColor = SKColor.blackColor()
		boxtangle.strokeColor = SKColor.blackColor()
		boxtangle.physicsBody.restitution = 0.0
		//boxtangle.physicsBody.mass = 30 //kg
		boxtangle.name = "hero"
		boxtangle.physicsBody.affectedByGravity = true
		boxtangle.physicsBody.angularVelocity = 0.1
		//boxtangle.physicsBody.allowsRotation = false
		self.addChild(boxtangle)
		
		/* Placeholder label */
        let myLabel = SKLabelNode(fontNamed:"")
        myLabel.text = "Test Game"
        myLabel.fontSize = 65
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(myLabel)
		
		
		
    }
	
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
		
		let touch = touches.anyObject() as UITouch
		
		if(touch.locationInNode(self).x < self.childNodeWithName("hero").position.x) {
			//touch on left side of screen
			self.childNodeWithName("hero").runAction(SKAction.repeatActionForever(SKAction.moveByX(-1, y: 0, duration: 0.01)), withKey: "goLeft")
		}
		else if(touch.locationInNode(self).x > self.childNodeWithName("hero").position.x){
			//touch on left side of screen
			self.childNodeWithName("hero").runAction(SKAction.repeatActionForever(SKAction.moveByX(1, y: 0, duration: 0.01)), withKey: "goRight")
		}
		
    }
	
	override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
		self.childNodeWithName("hero").removeActionForKey("goLeft")
		self.childNodeWithName("hero").removeActionForKey("goRight")
	}
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
	
	func jump() {
		self.childNodeWithName("hero").removeAllActions()
		self.childNodeWithName("hero").physicsBody.applyImpulse(CGVectorMake(0.0, 80.0), atPoint:self.childNodeWithName("hero").position)
	}
}
