//
//  LevelSelectionViewController.swift
//  Happy Game
//
//  Created by veli on 2/5/16.
//  Copyright © 2016 veli. All rights reserved.
//

import UIKit

class LevelSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func levelLoad(level: Int){
        let id = "GameScene";
        let levelManager = LevelManager(withLevel: level);
        let gameVC = self.storyboard?.instantiateViewControllerWithIdentifier(id) as! GameViewController;
        gameVC.levelManager = levelManager;
        self.navigationController?.pushViewController(gameVC, animated: true);        
    }
    
    @IBAction func LevelOne(sender: AnyObject) {
        print("level one");
        self.levelLoad(1);        
    }
    
    @IBAction func LevelTwo(sender: AnyObject) {
        print("level two");
        self.levelLoad(2);
    }

    @IBAction func LevelThree(sender: AnyObject) {
        print("level three");
        self.levelLoad(3);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
