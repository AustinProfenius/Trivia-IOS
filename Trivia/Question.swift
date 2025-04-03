//
//  Question.swift
//  Trivia
//
//  Created by Austin Profenius on 3/28/25.
//

import Foundation

struct Question {
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int // index 0-3
    let topic: String
}
