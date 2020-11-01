//
//  QuestionDataModel.swift
//  TandemCodeChallenge
//
//  Created by Boris Goncharov on 10/26/20.
//

import Foundation

struct Question: Decodable, Equatable {
    var question: String
    var incorrect = [String]()
    var correct: String
}
