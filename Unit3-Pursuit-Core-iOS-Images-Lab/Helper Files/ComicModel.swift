//
//  ComicModel.swift
//  Unit3-Pursuit-Core-iOS-Images-Lab
//
//  Created by Liubov Kaper  on 12/9/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import Foundation

struct Comic: Decodable {
    var num: Int
    var img: String
    var title: String
    var month: String
    let year: String
    let day: String
}
