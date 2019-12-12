//
//  LabQuestionAPI.swift
//  LabQuestions
//
//  Created by Tsering Lama on 12/12/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct LabQuestionsAPI {
    static func getQuestions(completionHandler: @escaping (Result<[Question],AppError>) -> ()) {
        
        let labEndpointURL = "https://5df04c1302b2d90014e1bd66.mockapi.io/questions"
        
        // create URL from endpoint String
        guard let url = URL(string: labEndpointURL) else {
            completionHandler(.failure(.badURL(labEndpointURL)))
            return
        }
        
        // urlrequest
        let request = URLRequest(url: url)
        
        // GET, POST, UPDATE, DELETE, PUT .......
        // request.httpMethod = "POST"
        // request.httpBody = data
        
        
        // ========================================================================
        // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // required when posting so we inform the POST the type of data it is, need header value as "application/json" or else we will get a decodin error
        // ========================================================================
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completionHandler(.failure(.networkClientError(appError)))
            case .success(let data):
                // [Question] needs to be created
                // getting resquest , NOT POSTING
                // Decoder to convert web data to swift
                // Encoder to convert swift to web data 
                do {
                    let questionArr = try JSONDecoder().decode([Question].self, from: data)
                    completionHandler(.success(questionArr))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
    
}
