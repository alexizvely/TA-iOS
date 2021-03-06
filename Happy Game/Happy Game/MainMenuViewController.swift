//
//  MainMenuViewController.swift
//  Happy Game
//
//  Created by veli on 2/3/16.
//  Copyright © 2016 veli. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var bgImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bgImage.image = UIImage(named: "mainTree")
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func StartGame(sender: AnyObject) {
        let id = "LevelSelection";
        print("go to level selection");
        let gameVC = self.storyboard?.instantiateViewControllerWithIdentifier(id);
        self.navigationController?.pushViewController(gameVC!, animated: true);
    }

    @IBAction func HighScore(sender: AnyObject) {
        let id = "HighScore";
        print("go to highscore");
        let gameVC = self.storyboard?.instantiateViewControllerWithIdentifier(id);
        self.navigationController?.pushViewController(gameVC!, animated: true);
    }
    
    @IBAction func About(sender: AnyObject) {
        let id = "About";
        print("go to about");
        let gameVC = self.storyboard?.instantiateViewControllerWithIdentifier(id);
        self.navigationController?.pushViewController(gameVC!, animated: true);
    }
}
