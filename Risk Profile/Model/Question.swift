//
//  QuestionElement.swift
//  Risk Profile
//
//  Created by Ikhtiyor Nurmatov on 16/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import Foundation

struct Question: Decodable {
    let id: Int
    let question: String
    let answers: Answers
    let imageName: String
}


struct Answers: Decodable {
    let a, b: String
    let c, d, e: String?
}


