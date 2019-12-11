//
//  UIImageView+Extension.swift
//  Unit3-Pursuit-Core-iOS-Images-Lab
//
//  Created by Liubov Kaper  on 12/10/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

extension UIImageView {
    func getImage(with urlString: String, completion: @escaping(Result<UIImage, AppError>) ->()) {
        
        NetworkHelper.shared.performDataTask(with: urlString) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }
        }
    }
}
