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
        
//        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        bgImage.image = UIImage(named: "mainTree")
//        self.view.insertSubview(backgroundImage, atIndex: 0)
        // Do any additional setup after loading the view.
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
        let id = "GameScene";
        print("whatever");
        let gameVC = self.storyboard?.instantiateViewControllerWithIdentifier(id);
        self.navigationController?.pushViewController(gameVC!, animated: true);
    }

}
