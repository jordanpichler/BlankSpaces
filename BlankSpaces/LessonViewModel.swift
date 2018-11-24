//
//  LessonViewModel.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 24/11/2018.
//

import Foundation

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
            let colorAttribute = [NSAttributedString.Key.foregroundColor: textSection.uicolor]
            let attributedString = NSAttributedString(string: textSection.text,
                                                      attributes: colorAttribute)
            
            fullText.append(attributedString)
        }
        return fullText
    }
}
