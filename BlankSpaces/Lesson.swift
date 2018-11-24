//
//  Lesson.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 22/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import UIKit

struct Lesson: Decodable {
    
    // MARK: - Properties -

    var id: Int
    var content: [LessonContent]
    
    var startIndex: Int?
    var endIndex: Int?
    
    // MARK: - Initializers -
    
    init(id: Int, content: [LessonContent], startIndex: Int? = nil, endIndex: Int? = nil) {
        self.id = id
        self.content = content
        self.startIndex = startIndex
        self.endIndex = endIndex
    }
    
    init(rawLesson: RawLesson) {
        // Extract lesson content
        var contentArray = [LessonContent]()
        rawLesson.content.forEach {
            contentArray.append(LessonContent(rawContent: $0))
        }
        
        self.init(id: rawLesson.id,
                  content: contentArray,
                  startIndex: rawLesson.input?.startIndex,
                  endIndex: rawLesson.input?.endIndex)
    }
    
    // MARK: -
    
    struct LessonContent: Decodable {
        
        var color: String
        var text: String
        var uicolor: UIColor {
            return UIColor(hexString: color)
        }
        
        init(color: String, text: String) {
            self.color = color
            self.text = text
        }
        
        init(rawContent: RawContent) {
            self.init(color: rawContent.color,
                      text: rawContent.text)
        }
    }
}
