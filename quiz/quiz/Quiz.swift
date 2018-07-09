
//
//  Quiz.swift
//  quiz
//
//  Created by Brian Xu on 6/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

class Quiz : CustomStringConvertible {
    var quiz = [Question]()
    
    var description: String {
        return "\(quiz)\n"
    }
}
