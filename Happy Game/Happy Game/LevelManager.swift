//
//  LevelManager.swift
//  Happy Game
//
//  Created by veli on 2/5/16.
//  Copyright © 2016 veli. All rights reserved.
//

import UIKit

class LevelManager: NSObject {
    
    var level: Int!;
    var levelFriendsCount: Int!;
    var backGroundname: String!;
    
    
    init(withLevel level:Int) {
        
        self.level = level;
        self.levelFriendsCount = level*10;
        
        switch(level){
        case 1:
            self.backGroundname = "levelOneBg"
            break;
        case 2:
            self.backGroundname = "levelTwoBg"
            break;
        case 3:
            self.backGroundname = "levelThreeBg"
            break;
        default:
            break;
        }
    }
}

