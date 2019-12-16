//
//  LabQuestionAPI.swift
//  LabQuestions
//
//  Created by Tsering Lama on 12/12/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct LabQuestionsAPI {
    
    // to get the questions
    
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
    
    // to post the questions
    static func postQuestion(question: PostedQuestion, completionHandler: @escaping (Result<Bool,AppError>) -> ()) {
        
        let endpointURLString = "https://5df04c1302b2d90014e1bd66.mockapi.io/questions"
        
        // create a URL
        guard let url = URL(string: endpointURLString) else {
            completionHandler(.failure(.badURL(endpointURLString)))
            return
        }
        
        // convert PostQuestion to data
        do {
            let data = try JSONEncoder().encode(question)
            
            // configure URL Request
            var request = URLRequest(url: url)
            // type of method
            request.httpMethod = "POST"
            // type of data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // provide the data being sent to the API
            request.httpBody = data
            // execute POST request
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                // have data or appError
                switch result {
                case .failure(let appError):
                    completionHandler(.failure(.networkClientError(appError)))
                case .success:
                    completionHandler(.success(true))
                }
            }
            
        } catch {
            completionHandler(.failure(.encodingError(error)))
        }
    }
    
    
    
}
