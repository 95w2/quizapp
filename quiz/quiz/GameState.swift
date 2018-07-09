//
//  GameState.swift
//  quiz
//
//  Created by Brian Xu on 9/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

import UIKit

class GameState {
    static var score: Int = 0
    static var scoreArray = [Int]()
    
    static var livesLeft: Int = 3 {
        didSet {
            if livesLeft < 3 {
                GameViewController.heartsArray[livesLeft].isHidden = true
            }
            else {
                for h in GameViewController.heartsArray {
                    h.isHidden = false
                }
            }
        }
    }
}
