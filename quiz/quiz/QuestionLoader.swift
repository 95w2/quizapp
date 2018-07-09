//
//  QuestionLoader.swift
//  quiz
//
//  Created by Brian Xu on 6/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

import UIKit

class QuestionLoader {
    var firstQuestion = true
    var previousQuestionIndex = 0
    var questionsRemaining = Array(0...24)
    
    func getQuestions(path: String) -> [Question] {
        if let questions = NSArray(contentsOfFile: path) {
            var allQuestions = [Question]()
            
            for q in questions {
                let question = Question()
                guard let dict = q as? [String: Any] else {
                    return []
                }
                if let title = dict["question"] as? String {
                    question.question = title
                    if let answers = dict["answers"] as? NSArray {
                        for answer in answers {
                            question.answers.append(answer as! String)
                        }
                    }
                }
                allQuestions.append(question)
            }
            return allQuestions
        }
        return []
        
    }
    
    func setQuestionAnswers(answers: Array<String>, randomQuestionIndex: Int) {
        var randomAnswerIndexArray = [0, 1, 2, 3]
        for b in GameViewController.buttonsArray {
            let randomAnswerIndex = Int(arc4random_uniform(UInt32(randomAnswerIndexArray.count)))
            b.setTitle(answers[randomAnswerIndexArray[randomAnswerIndex]], for: .normal)
            randomAnswerIndexArray.remove(at: randomAnswerIndex)
        }
        
        previousQuestionIndex = questionsRemaining[randomQuestionIndex]
        questionsRemaining.remove(at: randomQuestionIndex)
    }
    
    func checkAnswer(sender: UIButton, quiz: Quiz, scoreLabel: UILabel) {
        if sender.titleLabel?.text == quiz.quiz[previousQuestionIndex].answers[0] {
            GameState.score += 1
            scoreAnimation(scoreLabel: scoreLabel)
            sender.backgroundColor = UIColor(red: 0.3, green: 0.84, blue: 0.58, alpha: 1.0)
        }
        else {
            GameState.livesLeft -= 1
            sender.backgroundColor = UIColor(red: 0.91, green: 0.3, blue: 0.24, alpha: 1.0)
        }
    }
    
    func scoreAnimation(scoreLabel: UILabel) {
        scoreLabel.text = String(GameState.score)
        
        UIView.animate(withDuration: 0.3, animations: {
            scoreLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { (finished) in
            UIView.animate(withDuration: 0.3, animations: {
                scoreLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        })
        
    }
}
