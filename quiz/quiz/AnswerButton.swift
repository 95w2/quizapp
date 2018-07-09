//
//  AnswerButton.swift
//  quiz
//
//  Created by Brian Xu on 4/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

import UIKit

class AnswerButton: UIButton {
    required init(coder aDecoder: NSCoder) {
        fatalError("you dead")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 0.13, green: 0.64, blue: 0.62, alpha: 1.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.size.height/2
    }
}
