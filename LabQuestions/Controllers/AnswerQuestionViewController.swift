//
//  AnswerQuestionViewController.swift
//  LabQuestions
//
//  Created by Tsering Lama on 12/16/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class AnswerQuestionViewController: UIViewController {
    
    @IBOutlet weak var answerTextView: UITextView!
    
    var question: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func postPressed(_ sender: UIBarButtonItem) {
        // Able to post the users answer to the web api
        sender.isEnabled = false
         guard let answerText = answerTextView.text,
            !answerText.isEmpty,
            let question = question else {
            showAlert(title: "Missing Fields", message: "Answer is required, fellow is waiting...")
                sender.isEnabled = true
            return
          }
          
          // create a PostedAnswer instance
          let postedAnswer = PostAnswer(questionTitle: question.title, questionId: question.id, questionLabName: question.labName, answerDescription: answerText, createdAt: String.getISOTimestamp())
          
        LabQuestionsAPI.postAnswer(postedAnswer: postedAnswer) { [weak self, weak sender](result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Post Error", message: "\(appError)")
                    sender?.isEnabled = true
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Answer posted", message: "Thanks") {alert in self?.dismiss(animated: true)}
                }
            }
        }
    }
}
