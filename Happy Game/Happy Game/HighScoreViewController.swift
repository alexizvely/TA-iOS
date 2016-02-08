//
//  HighScoreViewController.swift
//  Happy Game
//
//  Created by veli on 2/8/16.
//  Copyright © 2016 veli. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController {

    @IBOutlet weak var top1: UILabel!
    @IBOutlet weak var top2: UILabel!
    @IBOutlet weak var top3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var query = PFQuery(className: "Highscore")
        query.orderByDescending("TotalScore")
        query.limit = 3
        query.findObjectsInBackgroundWithBlock{ (objs: [PFObject]?, err: NSError?) -> Void in
            if((err) == nil){
                let top1Score = objs![0].valueForKey("TotalScore");
                let top2Score = objs![1].valueForKey("TotalScore");
                let top3Score = objs![2].valueForKey("TotalScore");
                
                self.top1.text = "First Place: " + String(top1Score!)
                self.top2.text = "Second Place: " + String(top2Score!)
                self.top3.text = "Third Place: " + String(top3Score!)
            }
        }

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

}
