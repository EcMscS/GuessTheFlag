//
//  MainVC.swift
//  GuessTheFlag
//
//  Created by Jeffrey Lai on 7/26/19.
//  Copyright © 2019 Jeffrey Lai. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    //Views
    let button1: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 200, height: 100)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.tag = 0
        return button
    }()
    
    let button2: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 200, height: 100)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.tag = 1
        return button
    }()
    
    let button3: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 200, height: 100)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.tag = 2
        return button
    }()
    
    let stackedButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        return stackView
    }()
    
    //Variables
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupData()
        self.askQuestion(action: nil)
        
        self.setupViews()
        self.setupNavigationController()
        self.setupContraints()
    }
    
    
    //Functions
    func setupData() {
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    }
    
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2) //Value between 0, 1, 2
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
        
        button1.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        button3.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
    }
    
    func setupViews() {
        //Background of Main Screen
        self.view.backgroundColor = .white
        
        //Add Buttons
        stackedButtons.addArrangedSubview(button1)
        stackedButtons.addArrangedSubview(button2)
        stackedButtons.addArrangedSubview(button3)
        
        self.view.addSubview(stackedButtons)
    }
    
    func setupNavigationController() {
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.lightGray
    }
    
    func setupContraints() {
        stackedButtons.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackedButtons.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @objc fileprivate func buttonTapped(sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        let answerAlert = UIAlertController(title: title, message: "Your Score is \(score)", preferredStyle: .alert)
        answerAlert.addAction(UIAlertAction(title: "Coninue", style: .default, handler: askQuestion))
        
        present(answerAlert, animated: true)
    }

}
