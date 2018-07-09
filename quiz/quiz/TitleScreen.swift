//
//  TitleScreen.swift
//  quiz
//
//  Created by Brian Xu on 9/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

import UIKit

class TitleScreen: UIViewController {
    
    @IBOutlet weak var helloPlayer: UILabel!
    
    @IBOutlet weak var newPButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var leaderboardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let playerName = UserDefaults.standard.string(forKey: Players.recentPlayerKey) {
            helloPlayer.text = "Hello, \(playerName)"
        }
        
        newPButton.layer.cornerRadius = newPButton.frame.size.height/2
        playButton.layer.cornerRadius = playButton.frame.size.height/2
        leaderboardButton.layer.cornerRadius = leaderboardButton.frame.size.height/2
    }
    
    @IBAction func newPButtonPressed(_ sender: Any) {
        let newPlayerCreate = UIAlertController(title: "Please enter your name.", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        newPlayerCreate.addTextField(configurationHandler: { (textField) in
            textField.keyboardType = .default
            textField.textAlignment = .center
        })
        newPlayerCreate.addAction(UIAlertAction(title: "confirm", style: .default, handler: { (alert: UIAlertAction!) in
            let textField = newPlayerCreate.textFields![0]
            if let text = textField.text, !text.isEmpty {
                let playerName: String = text
                Players.players.append(playerName)
                UserDefaults.standard.set(playerName, forKey: Players.recentPlayerKey)
                self.helloPlayer.text = "Hello, \(playerName)"
            }
        }))
        newPlayerCreate.addAction(UIAlertAction(title: "nevermind lol", style: .default, handler: nil))
        self.present(newPlayerCreate, animated: true, completion: nil)
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "game", sender: nil)
    }

    @IBAction func leaderboardButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "scoreboard", sender: nil)
    }
}
