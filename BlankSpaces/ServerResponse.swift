//
//  ServerResponse.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 23/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import Foundation

struct RawServerResponse: Decodable {
    var lessons: [RawLesson]
}

struct RawLesson: Decodable {
    let id: Int
    let content: [RawContent]
    let input: RawInput?
}

struct RawContent: Decodable {
    let color, text: String
}

struct RawInput: Decodable {
    let startIndex, endIndex: Int
}
