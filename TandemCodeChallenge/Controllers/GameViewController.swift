//
//  ViewController.swift
//  TandemCodeChallenge
//
//  Created by Boris Goncharov on 10/26/20.`
//

import UIKit

class GameViewController: UIViewController {
    let jsonFetcher = JsonDataFetcher()
    
    var questionsArray: [Question]?
    var currentQuestion: Question?
    
    // Setup variables
    var score = 0
    var attemptsCount = 2
    var correctAnswers = 0
    var iteration = 1
    
    // UI Elements
    let questionLabel = UILabel()
    let currentScore = UILabel()
    let attemptImageViewOne = UIImageView()
    let attemptImageViewTwo = UIImageView()
    let currentScoreCount = UILabel()
    let answer0Button = UIButton()
    let answer1Button = UIButton()
    let answer2Button = UIButton()
    let answer3Button = UIButton()
    
    let bgColors = [UIColor(red: 0.77, green: 0.87, blue: 0.96, alpha: 1.00),
                    UIColor(red: 0.76, green: 0.88, blue: 0.77, alpha: 1.00),
                    UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00),
                    UIColor(red: 0.99, green: 0.80, blue: 0.00, alpha: 1.00),
                    UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 1.00),
                    UIColor(red: 0.83, green: 0.98, blue: 0.98, alpha: 1.00),
                    UIColor(red: 0.71, green: 0.67, blue: 0.98, alpha: 1.00)]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        setupElements()
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        updateElementsForNewQuestion(question: questionsArray?.first)
    }
    
    /// Data fetcher from JSON
    private func fetchData() {
        jsonFetcher.fetchQuestions { (result) in
            switch result {
            
            case .success(let data):
                self.questionsArray = data
                self.questionsArray?.shuffle()
                self.currentQuestion = self.questionsArray?.first
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Setup elements on the screen
    private func setupElements() {
        currentScore.text = "Current score: "
        currentScoreCount.text = "0"
        
        attemptImageViewOne.layer.cornerRadius = 15
        attemptImageViewTwo.layer.cornerRadius = 15
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.numberOfLines = .zero
        questionLabel.textColor = .black
        questionLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 32)
        
        answer0Button.setupButton(button: answer0Button)
        answer1Button.setupButton(button: answer1Button)
        answer2Button.setupButton(button: answer2Button)
        answer3Button.setupButton(button: answer3Button)
        
        attemptImageViewOne.backgroundColor = .white
        attemptImageViewTwo.backgroundColor = .white
        
        answer0Button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        answer1Button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        answer2Button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        answer3Button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    }
    
    /// Setup constraints
    private func setupConstraints() {
        let stackCurrentScore = UIStackView(arrangedSubviews: [currentScore, currentScoreCount])
        stackCurrentScore.axis = .horizontal
        stackCurrentScore.spacing = 2
        stackCurrentScore.translatesAutoresizingMaskIntoConstraints = false
        
        let stackButtons = UIStackView(arrangedSubviews: [answer0Button, answer1Button, answer2Button, answer3Button])
        stackButtons.axis = .vertical
        stackButtons.translatesAutoresizingMaskIntoConstraints = false
        stackButtons.spacing = 8
        
        let stackAttempts = UIStackView(arrangedSubviews: [attemptImageViewOne, attemptImageViewTwo])
        stackAttempts.axis = .horizontal
        stackAttempts.spacing = 16
        stackAttempts.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackCurrentScore)
        view.addSubview(questionLabel)
        view.addSubview(stackButtons)
        view.addSubview(stackAttempts)
        
        // Score constraints
        NSLayoutConstraint.activate([
            stackCurrentScore.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackCurrentScore.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32)
        ])
        
        // Question constraints
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.size.height / 6),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
        
        // Buttons constraints
        NSLayoutConstraint.activate([
            stackButtons.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: view.frame.height / 15),
            stackButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            answer0Button.heightAnchor.constraint(equalToConstant: view.frame.height / 10),
            answer1Button.heightAnchor.constraint(equalToConstant: view.frame.height / 10),
            answer2Button.heightAnchor.constraint(equalToConstant: view.frame.height / 10),
            answer3Button.heightAnchor.constraint(equalToConstant: view.frame.height / 10)
        ])
        
        // Attempts constraints
        NSLayoutConstraint.activate([
            stackAttempts.topAnchor.constraint(equalTo: stackButtons.bottomAnchor, constant: 32),
            stackAttempts.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            attemptImageViewOne.widthAnchor.constraint(equalToConstant: view.frame.width / 14),
            attemptImageViewOne.heightAnchor.constraint(equalToConstant: view.frame.width / 14),
            attemptImageViewTwo.widthAnchor.constraint(equalToConstant: view.frame.width / 14),
            attemptImageViewTwo.heightAnchor.constraint(equalToConstant: view.frame.width / 14)
        ])
    }
    
    /// Attempts
    func setupAttemptsImages() {
        if attemptsCount == 2 {
            attemptImageViewOne.isHidden = false
            attemptImageViewTwo.isHidden = false
        } else if attemptsCount == 1{
            attemptImageViewOne.isHidden = false
            attemptImageViewTwo.isHidden = true
        } else {
            attemptImageViewOne.isHidden = true
            attemptImageViewTwo.isHidden = true
        }
    }
    
    /// Action for any pressed button
    @objc func buttonAction(_ sender: UIButton) {
        greenOrRedBorder(sender, correctAnswer: currentQuestion?.correct ?? "")
        if (isAnswerCorrect(selectedAnswer: sender.currentTitle!)) {
            sender.isEnabled = false
            score += 1
            self.currentScoreCount.text = String(score)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.nextQuestion()
        }

            self.attemptsCount = 2
            
        } else {
            attemptsCount -= 1
            if attemptsCount == 0 {
                let button = self.correctAnswerButton(
                    b1: self.answer0Button,
                    b2: self.answer1Button,
                    b3: self.answer2Button,
                    b4: self.answer3Button)
                button.isEnabled = false
                button.backgroundColor = .green
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
                    button.backgroundColor = .none
                    self.attemptsCount = 2
                    self.nextQuestion()
                }

            }
            setupAttemptsImages()
        }
    }
}
