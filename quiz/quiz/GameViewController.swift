//
//  ViewController.swift
//  quiz
//
//  Created by Brian Xu on 4/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

import UIKit
import SnapKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var heart1: UIImageView!
    @IBOutlet weak var heart2: UIImageView!
    @IBOutlet weak var heart3: UIImageView!
    
    let answerButton1 = AnswerButton(frame: CGRect())
    let answerButton2 = AnswerButton(frame: CGRect())
    let answerButton3 = AnswerButton(frame: CGRect())
    let answerButton4 = AnswerButton(frame: CGRect())
    
    static var buttonsArray = [UIButton]()
    static var heartsArray = [UIImageView]()
    
    let questionLoader = QuestionLoader()
    let quiz = Quiz()

    var timer = Timer()
    var timeLeft = 10800

    var path = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createConstraints()
        GameViewController.heartsArray = [heart1, heart2, heart3]
        if Bundle.main.path(forResource: "questions", ofType: "plist") != nil {
            path = Bundle.main.path(forResource: "questions", ofType: "plist")!
        }
        quiz.quiz = questionLoader.getQuestions(path: path)
        newQuestion(sender: answerButton1)
        
    }
    
    @objc func buttonPressed(sender: UIButton) {
        newQuestion(sender: sender)
    }
    
    @objc func updateProgress() {
        timeLeft -= 1
        progressBar.setProgress(Float(timeLeft)/Float(10800), animated: false)
        if timeLeft == 0 {
            gameOver(sender: nil)
        }
    }
    
    func createConstraints() {
        GameViewController.buttonsArray = [answerButton1, answerButton2, answerButton3, answerButton4]
        
        for b in GameViewController.buttonsArray {
            b.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            if let index = GameViewController.buttonsArray.index(of: b) {
                view.addSubview(b)
                if  b == GameViewController.buttonsArray.first {
                    b.snp.makeConstraints { (make) in
                        make.left.equalToSuperview().offset(20)
                        make.right.equalToSuperview().offset(-20)
                        make.center.equalToSuperview().offset(20)
                    }
                }
                else {
                    b.snp.makeConstraints { (make) in
                        make.top.equalTo(GameViewController.buttonsArray[index - 1]).offset(60)
                        make.center.equalTo(GameViewController.buttonsArray[0])
                        make.width.height.equalTo(GameViewController.buttonsArray[0])
                    }
                }
            }
        }
    }
    
    func gameOver(sender: UIButton?) {
        timer.invalidate()
        
        let gameOver = UIAlertController(title: "GAME OVER", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        gameOver.addAction(UIAlertAction(title: "retry", style: .default, handler: { (Void) in
            if let b = sender {
                b.backgroundColor = UIColor(red: 0.13, green: 0.64, blue: 0.62, alpha: 1.0)
            }
            self.quiz.quiz = self.questionLoader.getQuestions(path: self.path)
            self.newQuestion(sender: self.answerButton1)
            self.timeLeft = 10800
            self.scoreLabel.text = "0"
            GameState.score = 0
            GameState.livesLeft = 3
        }))
        self.present(gameOver, animated: true, completion: nil)
        
//        if var currentViewController = UIApplication.shared.keyWindow?.rootViewController {
//            while let presentedViewController = currentViewController.presentedViewController {
//                currentViewController = presentedViewController
//            }
//            currentViewController.present(gameOver, animated: true, completion: nil)
//        }
    }
    
    func newQuestion(sender: UIButton) {
        let randomQuestionIndex = Int(arc4random_uniform(UInt32(questionLoader.questionsRemaining.count)))
        
        if !questionLoader.firstQuestion {
            questionLoader.checkAnswer(sender: sender, quiz: quiz, scoreLabel: scoreLabel)
            
            if GameState.livesLeft == 0 {
                questionLoader.firstQuestion = true
                questionLoader.questionsRemaining = Array(0...24)
                gameOver(sender: sender)
                return
            }
            for b in GameViewController.buttonsArray {
                b.isEnabled = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.questionLabel.text = self.quiz.quiz[self.questionLoader.questionsRemaining[randomQuestionIndex]].question
                self.questionLoader.setQuestionAnswers(answers: self.quiz.quiz[self.questionLoader.questionsRemaining[randomQuestionIndex]].answers, randomQuestionIndex: randomQuestionIndex)
                sender.backgroundColor = UIColor(red: 0.13, green: 0.64, blue: 0.62, alpha: 1.0)

                for b in GameViewController.buttonsArray {
                    b.isEnabled = true
                }
            })
        }
        else {
            timer = Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
            
            questionLoader.firstQuestion = false
            questionLabel.text = quiz.quiz[questionLoader.questionsRemaining[randomQuestionIndex]].question
            questionLoader.setQuestionAnswers(answers: quiz.quiz[questionLoader.questionsRemaining[randomQuestionIndex]].answers, randomQuestionIndex: randomQuestionIndex)
            
        }
        
    }
    
}


