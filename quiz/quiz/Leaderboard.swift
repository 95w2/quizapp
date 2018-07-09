//
//  Leaderboard.swift
//  quiz
//
//  Created by Brian Xu on 5/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var text = ""
    var array = Array(1...10)
    var array2 = [Int]()
    
    func shuffleArray(array: Array<Int>) {
        array2.removeAll()
        var randomIndexArray = array
        for _ in array {
            let randomIndex = Int(arc4random_uniform(UInt32(randomIndexArray.count)))
            
            array2.append(randomIndexArray[randomIndex])
            randomIndexArray.remove(at: randomIndex)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "match", for: indexPath) as! TableViewCell
        
        switch (array2.count > 0, indexPath.row == array2.index(of: 5)) {
        case (true, true):
            cell.textLabel?.text = String(array2[indexPath.row]) + " " + String(text)
        case (true, false):
            cell.textLabel?.text = String(array2[indexPath.row])
        case (false, _):
            if indexPath.row == 4 {
                cell.textLabel?.text = "5 " + String(text)
            }
            else {
                cell.textLabel?.text = String(indexPath.row+1)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        guard let cellText = cell.textLabel?.text else {
            return
        }
        
        if cellText == "5 " + String(text) {
            let winAlert = UIAlertController(title: "You win!", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            winAlert.addAction(UIAlertAction(title: "close", style: .default, handler: { (Void) in
                self.text = ""
                self.shuffleArray(array: self.array)
                tableView.reloadData()
            }))
            self.present(winAlert, animated: true)
            
        }
        else {
            let alert = UIAlertController(title: "User tapped cell no. \(indexPath.row)", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "close", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            text = "TAP ME!!!!"
            tableView.reloadData()
        }
        
    }
    
    
    
}
