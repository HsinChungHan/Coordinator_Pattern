//
//  Kanji.swift
//  CoordinatorPattern
//
//  Created by Chung Han Hsin on 2019/5/1.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation
struct WordExample: Codable {
    let word: String
    let meaning: String
}

struct Kanji: Codable {
    let character: String
    let meaning: String
    let examples: [WordExample]
}

