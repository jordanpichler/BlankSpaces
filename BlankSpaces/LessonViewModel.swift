//
//  LessonViewModel.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 24/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import UIKit

class LessonViewModel {
    
    let lesson: Lesson
    
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
        return needsInput ? text[lesson.startIndex!..<lesson.endIndex!] : ""
    }
    
    /// Returns the range which should be guessed by the user
    var inputRange: NSRange? {
        return needsInput ? NSRange(location: lesson.startIndex!,
                                    length: solution.count) : nil
    }
    
    /// Returns text from content fully visible and colored.
    func formatText(puzzled: Bool) -> NSAttributedString {
        let fullText = NSMutableAttributedString()
        
        // Iterate over content and append all text snippets
        for textSection in lesson.content {
            let attributes = [NSAttributedString.Key.foregroundColor: textSection.uicolor,
                              NSAttributedString.Key.font: UIFont(name: "CourierNewPS-BoldMT", size: 17)!]
            let attributedString = NSAttributedString(string: textSection.text,
                                                      attributes: attributes)
            
            fullText.append(attributedString)
        }
        
        if needsInput && puzzled {
            fullText.replaceCharacters(in: inputRange!,
                                       with: String(repeating: "⬜️", count: solution.count))
        }
        
        return fullText
    }
    
    /// Checks if given String matches the entire lesson content text
    /// - Important: The entire string of the lesson is compared, not just the solution word!
    func checkSolution(input: String) -> Bool {
        return input == text
    }
}
