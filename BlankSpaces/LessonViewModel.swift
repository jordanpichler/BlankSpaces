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
                              NSAttributedString.Key.font: UIFont(name: "Courier New", size: 14)!]
            let attributedString = NSAttributedString(string: textSection.text,
                                                      attributes: attributes)
            
            fullText.append(attributedString)
        }
        return fullText
    }
}
