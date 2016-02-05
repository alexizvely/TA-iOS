//
//  GameScene.swift
//  Happy Game
//
//  Created by veli on 2/3/16.
//  Copyright (c) 2016 veli. All rights reserved.
//

import SpriteKit

/// Game Scene Class that allows us to create animation from different atlases
class GameScene: SKScene {
    /// atlas name that we set when loading the Game Scene
    var atlasName : String!;
    
    /// container for our atlas images
    var animationFrames: [SKTexture]!;
    
    var count = 0; /// counter for the objects
    var isActive: Bool!;
    
    /**
     This func is called when the Game Scene is ready.
     
     - Parameter SKView:   the View we work with
     */
    override func didMoveToView(view: SKView) {
        /// creates texture to animate with the atlasName we have set on GameScene load
        let bgNode = SKSpriteNode(imageNamed: "levelOneBg");
        bgNode.size = self.frame.size;
        bgNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        self.addChild(bgNode);
        let animateAtlas = SKTextureAtlas(named: self.atlasName);
        
        /// array that holds our atlas images
        var animateFrames = [SKTexture]();
        
        /// gets the number of images in the atlas
        let numberOfImages = animateAtlas.textureNames.count;
        
        /// gesture for swipe that calls the gesture handler func
        let swipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"));
        
        /// animates the atlas holder
        for var i=1; i <= numberOfImages; i++ {
            let textureName = atlasName+String(i);
            animateFrames.append(animateAtlas.textureNamed(textureName))
        }
        
        self.animationFrames = animateFrames;
        
        /// Generates animated objects in a certain time interval with timer
        var timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "makeHappy", userInfo: nil, repeats: true);
        self.isActive = true;
        
        /// gesture listener
        self.view?.addGestureRecognizer(swipe);
    }
    
    /// swipe handler
    func handleSwipe(sender: UIGestureRecognizer){
        if(sender.state == .Ended){ /// check if gesture is ended
            var location = sender.locationInView(sender.view); /// get location of gesture on the view
            location = self.convertPointFromView(location); /// transform the location in game scene coordinates
            
            if let node = self.nodeAtPoint(location) as? SKSpriteNode{ /// try to cast the gesture to spritekitNode object
                print(node); /// if successfull do code... :)
            }
        }
    }
    
    /// initializes the happy tree friend
    func makeHappy(){
        self.makeNewObject();
    }
    
    /// starts action to animate object - frame animation
    func addAnimationToObj(node: SKSpriteNode){
        node.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(self.animationFrames,
                timePerFrame: 0.2,
                resize: false,
                restore: true)),
            withKey:"animationMain");
    }
    
    /// Move animation
    func startMoving(node: SKSpriteNode){
        node.runAction(SKAction.moveToX(self.frame.size.width, duration: 5));
    }
    
    /// makes object with animation
    func makeNewObject(){
        let startingImage = self.animationFrames[0];
        let obj = SKSpriteNode(texture: startingImage); /// creates the node (from AppleDev: SKSpriteNode is a node that draws a textured image, a colored square, or a textured image blended with a color)
        
        obj.position = CGPoint(x: 20, y:CGRectGetMidY(self.frame)); /// sets position for our node
        addChild(obj); /// adds it to the scene
        obj.name = String(count);
        count++; /// update the count for the new object
        self.addAnimationToObj(obj); /// runs action on the node
        self.startMoving(obj);  /// calls the animation
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
    
}
