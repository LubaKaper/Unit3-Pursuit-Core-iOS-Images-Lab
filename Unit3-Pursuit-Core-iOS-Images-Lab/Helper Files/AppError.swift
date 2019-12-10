//
//  AppError.swift
//  Unit3-Pursuit-Core-iOS-Images-Lab
//
//  Created by Liubov Kaper  on 12/9/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import Foundation

enum AppError: Error {
    
    case badURL(String) // associated value
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case badStatusCode(Int)// 404, 500
    case badMimeType(String)// image, jpeg
}
