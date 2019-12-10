//
//  ComicAPIClient.swift
//  Unit3-Pursuit-Core-iOS-Images-Lab
//
//  Created by Liubov Kaper  on 12/9/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import Foundation

struct ComicAPIClient {
    
    static func getComic(completion: @escaping (Result<[Comic], AppError>) ->()) {
        var comic: Comic!
        let endpointURLString = "https://xkcd.com/\(comic.num)/info.0.json"
        
        NetworkHelper.shared.performDataTask(with: endpointURLString) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let comics = try JSONDecoder().decode([Comic].self, from: data)
                   // let comic = searches.r
                    completion(.success(comics))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
