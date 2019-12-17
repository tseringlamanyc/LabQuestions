//
//  QuestionDetailController.swift
//  LabQuestions
//
//  Created by Alex Paul on 12/11/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class QuestionDetailController: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var questionTitle: UILabel!
    
    var question: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController, let answerVC = navigationVC.viewControllers.first as? AnswerQuestionViewController else {
            fatalError()
        }
        answerVC.question = question
    }
    
    private func updateUI() {
        guard let question = question else {
            fatalError("prepare for segue not properly setup")
        }
        labName.text = question.name
        questionTitle.text = question.title
        questionTextView.text = question.description
        avatarImage.getImage(with: question.avatar) { [weak self](result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.avatarImage.image = UIImage(systemName: "person.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.avatarImage.image = image
                }
            }
        }
    }
}
