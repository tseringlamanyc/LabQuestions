//
//  ViewController.swift
//  LabQuestions
//
//  Created by Alex Paul on 12/10/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class LabQuestionsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var refreshControl: UIRefreshControl!
    
    private var questions = [Question]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadQuestion()
    }
    
    func loadQuestion() {
        LabQuestionsAPI.getQuestions { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                     self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let questionData):
                self?.questions = questionData
            }
        }
    }
}

extension LabQuestionsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
        let aQuestion = questions[indexPath.row]
        cell.textLabel?.text = aQuestion.title
        return cell
    }
}
