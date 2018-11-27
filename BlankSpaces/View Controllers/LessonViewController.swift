//
//  LessonViewController.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 25/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {

    //MARK: - UI Elements -
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), for: .normal)
        button.setBackgroundColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0.5), for: .highlighted)
        button.setBackgroundColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .disabled)
        button.layer.cornerRadius = 15
        button.setTitle("Great job! Next", for: .normal)
        button.setTitle("Next", for: .disabled)
        return button
    }()
    
    let codeView = CodeView()
    
    // MARK: - Properties -
    private var lessonLibrary: [LessonViewModel]!
    private var currentLesson: LessonViewModel! {
        didSet {
            codeView.setCode(text: currentLesson.formatText(puzzled: true))
            toggleButton(enabled: !currentLesson.needsInput)
        }
    }
    private var lessonNumber = 0
    
    // MARK: - Initialization -
    
    convenience init?(lessons: [Lesson]) {
        if lessons.isEmpty { return nil }
        
        self.init()
        lessonLibrary = [LessonViewModel]()
        lessons.forEach { lessonLibrary.append(LessonViewModel(with: $0)) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set first lesson, updates the view
        guard let firstLesson = lessonLibrary.first else { return }
        currentLesson = firstLesson
        
        // Next lesson on Button tap
        nextButton.addTarget(for: .touchUpInside) { [unowned self] button in
            self.showNextLesson()
        }
        
        // Listen for changes in text field and check if solved
        codeView.delegate = self
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
    
    // MARK: - Helpers -
    
    func showNextLesson() {
        lessonNumber += 1
        if lessonNumber < lessonLibrary.count {
            currentLesson = lessonLibrary[lessonNumber]
        } else {
            let doneViewController = CompletionViewController()
            present(doneViewController, animated: false)
        }
    }
    
    func solveLesson() {
        toggleButton(enabled: true)
        codeView.setCode(text: currentLesson.formatText(puzzled: false))
        codeView.hideKeyboard()
    }
    
    private func toggleButton(enabled: Bool) {
        nextButton.isEnabled = enabled
        nextButton.isUserInteractionEnabled = enabled
    }
}

// MARK: - CodeViewDelegate

extension LessonViewController: CodeViewDelegate {
    func textDidChange(to text: String) {
        let isSolved = currentLesson.checkSolution(input: text)
        isSolved ? solveLesson() : toggleButton(enabled: false)
    }
}
