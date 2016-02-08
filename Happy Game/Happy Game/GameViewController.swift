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
        self.navigationItem.hidesBackButton = true
        print(String(self.levelManager.level));
        
        scene = GameScene(size: view.bounds.size)
        scene.backgroundImageName = levelManager.backGroundname;
        scene.navigator = self.navigationController;
        
        let name = Int(arc4random_uniform(10));
        print(name)
        if (name>5){
            scene.atlasName = "cuddles";
        }
        else{
            scene.atlasName = "petunia";
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
