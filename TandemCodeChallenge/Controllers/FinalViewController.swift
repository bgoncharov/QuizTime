//
//  FinalViewController.swift
//  TandemCodeChallenge
//
//  Created by Boris Goncharov on 10/29/20.
//

import UIKit

class FinalViewController: UIViewController {

    // UI Elements
    let finalTextLabel = UILabel()
    let scoreLabel = UILabel()
    let newGameButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.7661601027, green: 0.8343589469, blue: 1, alpha: 1)
        
        setupElements()
        setupContraints()
    }
    
    /// Setup score after game
    func setupScore(score: Int) {
        scoreLabel.text = String(score)
    }
    
    /// Setup elements
    private func setupElements() {
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        finalTextLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        finalTextLabel.text = "Your score is"
        finalTextLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
        
        scoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 42)
        
        newGameButton.backgroundColor = .blue
        newGameButton.layer.cornerRadius = 12
        newGameButton.setTitle("Play again", for: .normal)
        newGameButton.setTitleColor(.black, for: .normal)
        newGameButton.backgroundColor = UIColor.clear
        newGameButton.layer.borderColor = UIColor.black.cgColor
        newGameButton.layer.borderWidth = 2.0

        newGameButton.addTarget(self, action: #selector(startNewGame), for: .touchUpInside)
    }
    
    /// setup constraints
    private func setupContraints() {
        view.addSubview(finalTextLabel)
        view.addSubview(scoreLabel)
        view.addSubview(newGameButton)
        
        NSLayoutConstraint.activate([
            finalTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finalTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 3),
            
        ])
        
        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: finalTextLabel.bottomAnchor, constant: 16)
        ])

        NSLayoutConstraint.activate([
            newGameButton.widthAnchor.constraint(equalToConstant: view.layer.frame.width / 2),
            newGameButton.heightAnchor.constraint(equalToConstant: view.layer.frame.height / 11),
            newGameButton.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 48),
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    /// New game button
    @objc func startNewGame() {
        let gameVC = GameViewController()
        gameVC.modalPresentationStyle = .fullScreen
        self.present(gameVC, animated: true, completion: nil)
    }
}
