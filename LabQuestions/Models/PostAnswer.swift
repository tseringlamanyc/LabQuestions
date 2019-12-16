//
//  PostAnswer.swift
//  LabQuestions
//
//  Created by Tsering Lama on 12/16/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct PostAnswer: Encodable {
    let questionTitle: String
    let questionId: String
    let questionLabName: String
    //let id: String
    let answerDescription: String
}
