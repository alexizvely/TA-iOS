//
//  GameViewController.swift
//  Happy Game
//
//  Created by veli on 2/3/16.
//  Copyright (c) 2016 veli. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {
    
    var levelManager: LevelManager!;
    var scene: GameScene!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(String(self.levelManager.level));
        
        scene = GameScene(size: view.bounds.size)
        scene.backgroundImageName = levelManager.backGroundname;
        
        var name = Int(arc4random_uniform(2)+1);
        name=2;
        switch(name){
        case 1:
            scene.atlasName = "cuddles";
            break;
        case 2:
            scene.atlasName = "giggles";
            break;
        case 3:
            scene.atlasName = "petunia";
            break;
        default:
            break;
        }
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
//    override func didMoveToParentViewController(parent: UIViewController?) {
//        if(parent != self.parentViewController){
//        scene.audioPlayer.stop();
//        }
//    }
}
