//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation


struct Clue: Decodable {
    var id:Int
        var answer:String
        var question:String
        var category_id: Int
        var category:Category
    
}

struct Category:Decodable {
    var id:Int
    var title:String
    var clues_count:Int
}
