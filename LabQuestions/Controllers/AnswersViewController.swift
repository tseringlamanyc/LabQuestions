//
//  AnswersViewController.swift
//  LabQuestions
//
//  Created by Tsering Lama on 12/17/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class AnswersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var answers = [Answer]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAnswers()
    }
    
    private func getAnswers() {
       
    }
}

extension AnswersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath)
        let answer = answers[indexPath.row]
        cell.textLabel?.text = answer.answerDescription
        cell.textLabel?.numberOfLines = 0 
        return cell
    }
}
