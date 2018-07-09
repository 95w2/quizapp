//
//  Question.swift
//  quiz
//
//  Created by Brian Xu on 6/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

import Foundation

class Question : CustomStringConvertible {
   
    
    var question: String = ""
    var answers: [String] = []
    
    // MARK: CustomStringConvertible
    
    var description: String {
        return "\(question)\n"
    }
}
