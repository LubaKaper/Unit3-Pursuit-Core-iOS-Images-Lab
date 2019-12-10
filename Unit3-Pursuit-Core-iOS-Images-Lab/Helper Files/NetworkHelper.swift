//
//  NetworkHelper.swift
//  Unit3-Pursuit-Core-iOS-Images-Lab
//
//  Created by Liubov Kaper  on 12/9/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import Foundation

class NetworkHelper {
    
    // we will create a "shared" instance of NetworkHelper
    static let shared = NetworkHelper()
    
    private var session: URLSession
    
    // we will make the default initializer private
    // required in order to be considered a singleton
    // also forbids anyone from creating an instance of NetworkHelper
    
    private init() {
        session = URLSession(configuration: .default)
    }
    
    //() or Void at the end of escaping closure is the same thing
    // when see angled brackets <> think of Generic type
    // in place of Data below could be anything, in place of Error only Error, Result<success, failure>, failure is only Error
    func performDataTask(with urlString: String, completion: @escaping (Result<Data, AppError>) -> ()) {
        
        guard let url = URL(string: urlString) else {
            
            // handle bad url error case
            completion(.failure(.badURL(urlString)))
            return
        }
        // two states on dataTask, resume() and suspanded by default
        // suspendee simply wont perform network request
        // this ultimatly leads to debugging errors and time lost if you dont explicitly resume() request
       let dataTask = session.dataTask(with: url) {(data, response, error) in
        
        // 1. deal with error if any
        // check for client networking errors
        if let error = error {
            completion(.failure(.networkClientError(error)))
        }
        // 2. downcast UTLResponse (response) to HTTPURLResponse to get access to statusCode property of  HTTPURLResponse
        guard let urlResponse = response as? HTTPURLResponse else {
            completion(.failure(.noResponse))
            return
        }
        //3. unwrap the data object
        guard let data = data else {
            completion(.failure(.noData))
            return
        }
        // 4. validate thet the status code is in 200 range otherwise it is a bad status code
        switch urlResponse.statusCode {
        case 200...299: break // everything went well here
        default:
            completion(.failure(.badStatusCode(urlResponse.statusCode)))
            return
        }
        
        // 5. capture data as success case
        completion(.success(data))
        }
        dataTask.resume()
    }
}
