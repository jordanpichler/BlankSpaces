//
//  LessonViewModel.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 24/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import Foundation
import UIKit

class LessonViewModel {
    
    var lesson: Lesson
    
    // MARK: - Initializer -
    
    init(with lesson: Lesson) {
        self.lesson = lesson
    }
    
    // MARK: - View Model functions -
    
    /// Checks if a startIndex and endIndex is present for user input
    var needsInput: Bool {
        return lesson.startIndex != nil && lesson.endIndex != nil
    }
    
    /// Returns entire lesson content text as a plain string
    var text: String {
        var string = ""
        lesson.content.forEach { string += $0.text }
        return string
    }
    
    /// Returns the solution string the user needs to input
    var solution: String {
        if needsInput {
            return text[lesson.startIndex!..<lesson.endIndex!]
        }
        
        return ""
    }
    
    /// Returns text from content fully visible and colored.
    func formattedText() -> NSMutableAttributedString {
        let fullText = NSMutableAttributedString()
        
        // Iterate over content and append all text snippets
        for textSection in lesson.content {
            let attributes = [NSAttributedString.Key.foregroundColor: textSection.uicolor,
                              NSAttributedString.Key.font: UIFont(name: "CourierNewPS-BoldMT", size: 17)!]
            let attributedString = NSAttributedString(string: textSection.text,
                                                      attributes: attributes)
            
            fullText.append(attributedString)
        }
        return fullText
    }
    
    /// Returns text from content formated and with white boxes if input is required.
    func puzzledText() -> NSMutableAttributedString {
        let fullText = formattedText()

        if needsInput {
            let length = (lesson.endIndex! - lesson.startIndex!)
            let range = NSRange(location: lesson.startIndex!,
                                length: length)
            fullText.replaceCharacters(in: range, with: String(repeating: "⬜️", count: length))
        }
        
        return fullText
    }
}
