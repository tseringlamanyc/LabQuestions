//
//  CreateQuestionController.swift
//  LabQuestions
//
//  Created by Alex Paul on 12/11/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class CreateQuestionController: UIViewController {
    
    @IBOutlet weak var questionText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var labPickerView: UIPickerView!
    
    // for lab picker view
    private let labs = ["Concurrency", "Comic", "Parsing JSON - Weather, Color, User", "Image and Error Handling",
    "StocksPeople", "Intro to Unit testing - Jokes, Star Wars, Trivia", "Text-based adventure",
    "Hangman CLI", "Calculator CLI", "Three Card Monte", "ColorGuessingGame", "TextTwist","Autolayout-Lab",
    "CardGenerator", "TableView-Sections-Lab", "ZooAnimals", "Game of Thrones", "UpdatingFont", "GroceryList",
    "Tic Tac Toe", "Hangman iOS app", "Making GET requests - Shows, Episodes"].sorted() // ascending by default a - z
    
    private var labName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labName = labs.first
        labPickerView.dataSource = self
        labPickerView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // change border and color of the text view
        // semantic color new to IOS 13 , works with light or dark
        // CG - Core graphics
        descriptionText.layer.borderColor = UIColor.systemGray.cgColor
        descriptionText.layer.borderWidth = 1
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func createPressed(_ sender: UIBarButtonItem) {
        // 3 required parameters to create PostedQuestion
        guard let questionTitle = questionText.text,
            !questionTitle.isEmpty,
            let labName = labName,
            let labDescription = descriptionText.text,
            !labDescription.isEmpty else {
                showAlert(title: "Missing Fields", message: "Title, Description are required")
                return 
        }
        let question = PostedQuestion.init(title: questionTitle, labName: labName, description: labDescription, createdAt: String.getISOTimestamp())
        
        // POST question using API Client
        LabQuestionsAPI.postQuestion(question: question) { [weak self ](result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Post Error", message: "\(appError)")
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Success in posting", message: "\(questionTitle) was posted")
                }
            }
        }
    }
}

extension CreateQuestionController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return labs.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return labs[row]
    }
}
