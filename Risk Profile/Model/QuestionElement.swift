//
//  QuestionElement.swift
//  Risk Profile
//
//  Created by Ikhtiyor Nurmatov on 16/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import Foundation

// MARK: - QuestionElement
struct QuestionElement: Codable {
    let question: String
    let answers: Answers
}

// MARK: - Answers
struct Answers: Codable {
    let a, b: String
    let c, d, e: String?
}


