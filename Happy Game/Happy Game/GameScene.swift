//
//  GameScene.swift
//  Happy Game
//
//  Created by veli on 2/3/16.
//  Copyright (c) 2016 veli. All rights reserved.
//

import SpriteKit
import AVFoundation
import CoreMotion

/// Game Scene Class that allows us to create animation from different atlases
class GameScene: SKScene {
    /// atlas name that we set when loading the Game Scene
    var atlasName : String!;
    
    /// container for our atlas images
    var animationFrames: [SKTexture]!;
    
    var count = 0; /// counter for the objects
    var isActive: Bool!;
    var backgroundImageName: String!;
    var audioPlayer: AVAudioPlayer!;
    var soundControl: SKLabelNode!;
    var deathNotification: SKLabelNode!;
    var gameOver: SKLabelNode!;
    var isSoundOn = true;
    var gestureArea: SKSpriteNode!;
    var timer: NSTimer!;
    var countDead = 0;
    var score = 0.0;
    var motionManager = CMMotionManager();
    var navigator: UINavigationController!;
    
    /**
     This func is called when the Game Scene is ready.
     - Parameter SKView:   the View we work with
     */
    override func didMoveToView(view: SKView) {
        /// creates texture to animate with the atlasName we have set on GameScene load
        let bgNode = SKSpriteNode(imageNamed: backgroundImageName);
        bgNode.size = self.frame.size;
        bgNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        bgNode.name = "background";
        self.addChild(bgNode);
        bgNode.zPosition = -1
        let animateAtlas = SKTextureAtlas(named: self.atlasName);
        
        /// array that holds our atlas images
        var animateFrames = [SKTexture]();
        
        /// gets the number of images in the atlas
        let numberOfImages = animateAtlas.textureNames.count;
        
        /// gesture for swipe that calls the gesture handler func

        
        gestureArea = SKSpriteNode(imageNamed: "save.png");
        gestureArea.position = CGPoint(x: (self.frame.size.width)*(0.38), y:CGRectGetMidY(self.frame));
        gestureArea.xScale = 0.60;
        gestureArea.yScale = 0.60;
        gestureArea.name = "command"
        self.addChild(gestureArea);
        gestureArea.zPosition = 300;
        
        //belt 
        let beltTexture = SKTexture(imageNamed: "tmp0");

        let beltNode = SKSpriteNode(texture: beltTexture);
        beltNode.position = CGPoint(x: CGRectGetMidX(self.frame), y: (CGRectGetMidY(self.frame)) - ((gestureArea.size.height)*0.85));
        addChild(beltNode)
        beltNode.name="belt";

        /// animates the atlas holder
        for var i=1; i <= numberOfImages; i++ {
            let textureName = atlasName+String(i);
            animateFrames.append(animateAtlas.textureNamed(textureName))
        }
        
        
        self.animationFrames = animateFrames;
        
        self.setUpAudio();
        
        /// Generates animated objects in a certain time interval with timer
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "makeHappy", userInfo: nil, repeats: true);
        self.isActive = true;
        

        // **New**
        let gestureRecognizerSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
        
        self.view!.addGestureRecognizer(gestureRecognizerSwipe)
        gestureRecognizerSwipe.direction = [.Left,.Right];
        
        
        let gestureRecognizerPinch = UIPinchGestureRecognizer(target: self, action: Selector("handlePinch:"))
        self.view!.addGestureRecognizer(gestureRecognizerPinch)
        
        let gestureRecognizerRotation = UIRotationGestureRecognizer(target: self, action: Selector("handleRotation:"))
        self.view!.addGestureRecognizer(gestureRecognizerRotation)
        
        let gestureRecognizerLongPress = UILongPressGestureRecognizer(target: self, action: Selector("handleLongPress:"))
        self.view!.addGestureRecognizer(gestureRecognizerLongPress)
        
        if (motionManager.accelerometerAvailable == true) {
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler:{
                data, error in
                if ((data!.acceleration.x + data!.acceleration.y + data!.acceleration.z) < 0) {
                    self.audioPlayer.stop();
                    print("music is off")
                    self.soundControl.text = "-Sound Off-"
                    let transitionTimer =  NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "NavTransition", userInfo: nil, repeats: false);
                }
            })
        }
        
        self.deathNotification = SKLabelNode(text: "- -");
        self.deathNotification.fontColor = SKColor.blackColor();
        self.deathNotification.fontName = "Papyrus"
        deathNotification.position = CGPoint(x: (self.frame.size.width)*(0.80), y:CGRectGetMidY(self.frame));
        deathNotification.name = "deathNotification";
        self.addChild(deathNotification);

    }
    
    // **New**
    func handlePinch(recognizer: UIPinchGestureRecognizer) {
        
        if(recognizer.state != .Ended){
            return;
        }
        
        var touchLocation = recognizer.locationInView(recognizer.view)
        touchLocation = self.convertPointFromView(touchLocation)
        let nodes = self.nodesAtPoint(touchLocation);
        let nodeAtFront = nodes[0];
        let targetNode = nodes[1];
        
        if(nodeAtFront.name == "command"){
            if(targetNode.name != "background" && targetNode.name != "belt"){
                self.addAnimationToObj(nodes[1] as! SKSpriteNode);
                score = score + 2;
            }
            else{
                self.deathNotification.text = "Missed!"
            }
        }
    }
    
    // **New**
    func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        
        if(recognizer.state != .Ended){
            return;
        }
        
        var touchLocation = recognizer.locationInView(recognizer.view)
        touchLocation = self.convertPointFromView(touchLocation)
        let nodes = self.nodesAtPoint(touchLocation);
        let nodeAtFront = nodes[0];
        let targetNode = nodes[1];
        
        if(nodeAtFront.name == "command"){
            if(targetNode.name != "background" && targetNode.name != "belt"){
                self.addAnimationToObj(nodes[1] as! SKSpriteNode);
                score = score + 0.5;
            }
            else{
                self.deathNotification.text = "Missed!"
            }
        }
    }
    
    // **New**
    func handleRotation(recognizer: UIRotationGestureRecognizer) {
        
        if(recognizer.state != .Ended){
            return;
        }
        
        var touchLocation = recognizer.locationInView(recognizer.view)
        touchLocation = self.convertPointFromView(touchLocation)
        let nodes = self.nodesAtPoint(touchLocation);
        let nodeAtFront = nodes[0];
        let targetNode = nodes[1];
        
        if(nodeAtFront.name == "command"){
            if(targetNode.name != "background" && targetNode.name != "belt"){
                self.addAnimationToObj(nodes[1] as! SKSpriteNode);
                score = score + 1.5;
            }
            else{
                self.deathNotification.text = "Missed!"
            }
        }
    }
    
    // **New**
    func handleSwipe(recognizer: UISwipeGestureRecognizer) {
        if(recognizer.state != .Ended){
            return;
        }
       
        
        var touchLocation = recognizer.locationInView(recognizer.view)
        touchLocation = self.convertPointFromView(touchLocation)
        let node = self.nodeAtPoint(touchLocation);
        let nodes = self.nodesAtPoint(touchLocation);
        let treeFrined = nodes[1].name;
        
        if(node.name == "command"){
            if(treeFrined != "background" && treeFrined != "belt"){
                self.addAnimationToObj(nodes[1] as! SKSpriteNode);
                score = score + 0.5;
            }
            else{
                self.deathNotification.text = "Missed!"
            }
        }
    }
    
    /// Audio Controller
    func setUpAudio(){
        let path = NSBundle.mainBundle().resourcePath!+"/htf-sound.mp3";
        let url = NSURL(fileURLWithPath: path);
        do{
            audioPlayer = try AVAudioPlayer(contentsOfURL: url);
        }
        catch {
            print(" Sound Error");
        }
        audioPlayer.numberOfLoops = -1;
        audioPlayer.play();
        self.soundControl = SKLabelNode(text: "-Sound On-");
        self.soundControl.fontColor = SKColor.blackColor();
        self.soundControl.fontName = "Papyrus"
        soundControl.position = CGPoint(x: (self.frame.size.width)*(0.75), y:(self.frame.size.height)-100);
        soundControl.name = "soundControl";
        self.addChild(soundControl);
        
    }
    
    /// initializes the happy tree friend
    func makeHappy(){
        if(count>3){
            self.timer.invalidate();
            self.gameOver = SKLabelNode(text: "Killed: "+String(countDead)+" Alive: "+String(count-countDead)+" Score: "+String(score));
            self.gameOver.fontColor = SKColor.blackColor();
            self.gameOver.fontName = "Papyrus"
            gameOver.position = CGPoint(x: CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
            gameOver.name = "gameOver";
            self.deathNotification.removeFromParent()
            self.gestureArea.removeFromParent()
            self.timer.invalidate()
            self.addChild(gameOver);
            gameOver.zPosition = 99999;
            let obj = PFObject(className: "Highscore");
            obj["Killed"] = countDead;
            obj["Saved"] = count-countDead;
            obj["TotalScore"] = score;
            obj.saveInBackground();
            self.audioPlayer.stop();
            print("music is off")
            self.soundControl.text = "-Sound Off-"
            let transitionTimer =  NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "NavTransition", userInfo: nil, repeats: false);
        }
        self.makeNewObject();
    }
    
    func NavTransition(){
        self.navigator.popViewControllerAnimated(true)
    }
    
    func addAnimationToObj(node: SKSpriteNode){
        node.runAction(SKAction.animateWithTextures(
        self.animationFrames,
        timePerFrame: 0.50,
        resize: false,
        restore: true),
        completion:{
            print("killed")
            node.texture = self.animationFrames[self.animationFrames.count-1];
            node.removeFromParent();
            self.countDead++;
            self.deathNotification.text = "Killed!"
        })
    }
    
    /// Move animation
    func startMoving(node: SKSpriteNode){
        node.runAction(SKAction.moveToX((self.frame.size.width)*(0.75), duration: 5),
            completion:{
                print("saved")
                node.removeFromParent()
        });
    }
    
    /// makes object with animation
    func makeNewObject(){
        let startingImage = self.animationFrames[0];
        let obj = SKSpriteNode(texture: startingImage); /// creates the node (from AppleDev: SKSpriteNode is a node that draws a textured image, a colored square, or a textured image blended with a color)
        
        obj.position = CGPoint(x: 20, y:CGRectGetMidY(self.frame)); /// sets position for our node
        obj.xScale = 0.5;
        obj.yScale = 0.5;

        addChild(obj); /// adds it to the scene
        obj.name = String(count);
        count++; /// update the count for the new object
        
        self.startMoving(obj);  /// calls the animation
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch = touches.first! as UITouch;
        let positionInScene = touch.locationInNode(self);
        let touchNode = self.nodeAtPoint(positionInScene);
        let nodeName = touchNode.name;
        
        if(nodeName == "soundControl"){
            self.isSoundOn = !isSoundOn;
            if(isSoundOn){
                audioPlayer.play();
                print("music is on")
                soundControl.text = "-Sound On-"
            }
            else{
                audioPlayer.stop();
                print("music is off")
                soundControl.text = "-Sound Off-"
            }
        }
    }
}
