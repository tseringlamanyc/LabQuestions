//
//  PostAnswer.swift
//  LabQuestions
//
//  Created by Tsering Lama on 12/16/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

// Encodable converts Swift models to Data
struct PostAnswer: Encodable {
  let questionTitle: String
  let questionId: String // for searching all answers to a question
  let questionLabName: String
  let answerDescription: String
  let createdAt: String // timestamp of the created date of the Question
}
