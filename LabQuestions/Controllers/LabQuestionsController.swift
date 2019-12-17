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
        configureRefreshControl()
    }
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        
        // runtime API
        // programmable target-action using objective-c runtime api
        
        refreshControl.addTarget(self, action: #selector(loadQuestion), for: .valueChanged)
    }
    
    @objc
    private func loadQuestion() {
        LabQuestionsAPI.getQuestions { [weak self] (result) in
            // stops the refresh controller
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let questionData):
                // sorting by date ,,, most recent
                self?.questions = questionData.sorted {$0.createdAt.isoStringToDate() > $1.createdAt.isoStringToDate()}
                DispatchQueue.main.async {
                    self?.navigationItem.title = "Lab questions: \(questionData.count)"
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuestionVC" {
            guard let detailVC = segue.destination as? QuestionDetailController, let indexpath = tableView.indexPathForSelectedRow else {
                fatalError()
            }
            detailVC.question = questions[indexpath.row]
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
        cell.detailTextLabel?.text = aQuestion.createdAt.convertISODate() + " - \(aQuestion.labName)"
        return cell
    }
}
