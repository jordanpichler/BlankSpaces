//
//  LessonViewController.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 25/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {

    let nextButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(#colorLiteral(red: 0.3949374766, green: 0.733126826, blue: 0.8587999683, alpha: 1), for: .normal)
        button.setBackgroundColor(#colorLiteral(red: 0.3949374766, green: 0.733126826, blue: 0.8587999683, alpha: 0.5), for: .highlighted)
        button.setBackgroundColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .selected)
        button.layer.cornerRadius = 15
        button.setTitle("Next", for: .normal)
        return button
    }()
    
    let codeView = CodeView()
    
    private var lessonLibrary: [LessonViewModel]!
    var currentLesson: LessonViewModel!
    private var lessonNumber = 0
    var userInput = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let firstLesson = lessonLibrary.first else { return }
        
        currentLesson = firstLesson
        codeView.setCode(text: currentLesson.puzzledText())
        
        if currentLesson.needsInput {
            nextButton.isSelected = true
            nextButton.isUserInteractionEnabled = false
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(codeView)
        view.addSubview(nextButton)

        view.addConstraintsWithFormat(format: "H:|[v0]|", views: codeView)
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: nextButton)
        view.addConstraintsWithFormat(format: "V:|-100-[v0]-(>=25)-[v1(70)]-25-|", views: codeView, nextButton)
    }
    
    convenience init?(lessons: [Lesson]) {
        if lessons.isEmpty { return nil }
        
        self.init()
        lessonLibrary = [LessonViewModel]()
        
        for lesson in lessons {
            lessonLibrary.append(LessonViewModel(with: lesson))
        }
    }
    
    func checkSolution() -> Bool {
        if currentLesson.needsInput {
            return userInput == currentLesson.solution
        }
        return true
    }
    
    func showNextLesson() {
        lessonNumber += 1
        currentLesson = lessonLibrary[lessonNumber]
    }
    
}
