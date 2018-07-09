//
//  Scoreboard.swift
//  quiz
//
//  Created by Brian Xu on 9/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

import UIKit

class ScoreboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let scores = UserDefaults.standard.array(forKey: "scores") as? [Int] {
            GameState.scoreArray = scores
        }

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.performSegue(withIdentifier: "back", sender: nil)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameState.scoreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "score", for: indexPath) as! TableViewCell
        cell.textLabel?.text = String(GameState.scoreArray[indexPath.row])
        return cell
    }
    
  
}
