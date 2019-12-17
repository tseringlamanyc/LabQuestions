//
//  Answer.swift
//  LabQuestions
//
//  Created by Tsering Lama on 12/17/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

// an "UPDATE" is a HTTP method would be able to do partial updates of an object 
struct Answer: Decodable {
    let id: String
    let name: String
    let avatar: String
    let questionId: String
    let questionLabName: String
    let questionTitle: String
    let answerDescription: String
    let createdAt: String
}
