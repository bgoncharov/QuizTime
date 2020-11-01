//
//  GameViewController+extension.swift
//  TandemCodeChallenge
//
//  Created by Boris Goncharov on 10/29/20.
//

import Foundation
import UIKit

///
//
/// Helping functions for GameViewController
extension GameViewController {
    
    func greenOrRedBorder(_ sender: UIButton, correctAnswer: String) {
        var timer: Timer?
        
        if (sender.titleLabel?.text == correctAnswer) {
            sender.layer.borderColor = UIColor.green.cgColor
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { _ in
                sender.layer.borderColor = UIColor.black.cgColor
            })
        } else {
            sender.layer.borderColor = UIColor.red.cgColor
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { _ in
                sender.layer.borderColor = UIColor.black.cgColor
            })
        }
    }
    
    /// Check if answer is correct
    func isAnswerCorrect(selectedAnswer: String) -> Bool {
        if (currentQuestion?.correct == selectedAnswer) {
            return true
        } else {
            return false
        }
    }
    
    /// Next question switcher
    func nextQuestion() {
        if iteration < 10 {
            currentQuestion = questionsArray?[iteration]
            updateElementsForNewQuestion(question: currentQuestion)
            iteration += 1
        } else {
            let finalVC = FinalViewController()
            finalVC.setupScore(score: self.score)
            finalVC.modalPresentationStyle = .fullScreen
            self.present(finalVC, animated: true, completion: nil)
        }
    }
    
    /// Setup elements for new question
    func updateElementsForNewQuestion(question: Question?) {
        var answers: [String] = []
        
        guard let question = question else { return }

        answers.append(question.correct)
        question.incorrect.forEach { (answer) in
            answers.append(answer)
        }
        answers.shuffle()
        
        questionLabel.text = question.question
        answer0Button.setTitle(answers[0], for: .normal)
        answer1Button.setTitle(answers[1], for: .normal)
        answer2Button.setTitle(answers[2], for: .normal)
        
        answer0Button.isEnabled = true
        answer1Button.isEnabled = true
        answer2Button.isEnabled = true
        answer3Button.isEnabled = true
        
        if question.incorrect.count == 2 {
            answer3Button.isHidden = true
        } else {
            answer3Button.setTitle(answers[3], for: .normal)
            answer3Button.isHidden = false
        }
        view.backgroundColor = bgColors.randomElement()
        setupAttemptsImages()
    }
    
    func correctAnswerButton(b1: UIButton, b2: UIButton, b3: UIButton, b4: UIButton) -> UIButton {
        var correctButton = UIButton()
        var buttonArray = [UIButton]()
        buttonArray = [b1, b2, b3, b4]
        
        buttonArray.forEach { (button) in
            if (button.titleLabel?.text == currentQuestion?.correct) {
                correctButton = button
            }
        }
        return correctButton
    }
}
