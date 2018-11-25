//
//  LessonViewModel.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 24/11/2018.
//

import Foundation
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
        let fullText = NSMutableAttributedString()
        
        // Iterate over content and append all text snippets
        for textSection in lesson.content {
            let attributes = [NSAttributedString.Key.foregroundColor: textSection.uicolor,
                              NSAttributedString.Key.font: UIFont(name: "CourierNewPS-BoldMT", size: 17)!]
            let attributedString = NSAttributedString(string: textSection.text,
                                                      attributes: attributes)
            
            fullText.append(attributedString)
        }

        if needsInput {
            let length = (lesson.endIndex! - lesson.startIndex!)
            let range = NSRange(location: lesson.startIndex!,
                                length: length)
            let solution = fullText.string[lesson.startIndex!..<lesson.endIndex!]
            fullText.replaceCharacters(in: range, with: String(repeating: "⬜️", count: length))
            
            print("\(lesson.startIndex!) and \(lesson.endIndex!)")
        }
        
        return fullText
    }
    
}
