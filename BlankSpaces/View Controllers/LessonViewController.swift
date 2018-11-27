//
//  LessonViewController.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 25/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LessonViewController: UIViewController {

    // MARK: - UI Properties -
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), for: .normal)
        button.setBackgroundColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0.5018193493), for: .highlighted)
        button.setBackgroundColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .disabled)
        button.setTitle("Great job! Continue", for: .normal)
        button.setTitle("Continue", for: .disabled)
        button.layer.cornerRadius = 15
        return button
    }()
    
    let codeView = CodeView()
    
    // MARK: - Properties -
    
    private var lessonLibrary: [LessonViewModel]!
    var currentLesson: BehaviorRelay<LessonViewModel>!
    var lessonNumber = 0
    private var userInput = BehaviorRelay<String>(value: "")
    private let bag = DisposeBag()
    
    // MARK: - Functions -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set first lesson
        guard let firstLesson = lessonLibrary.first else { return }
        currentLesson = BehaviorRelay<LessonViewModel>(value: firstLesson)
        
        // Subscribe in order to update codeView for following lessons
        currentLesson
            .subscribe({ lessonEvent in
                let lesson = lessonEvent.element!
                self.codeView.setCode(text: lesson.formatText(puzzled: true))
            }).disposed(by: bag)
        
        // Observe userinput
//        codeView.codeTextField.rx.textInput.text.asObservable().subscribe(onNext: {string in
//            //self.checkSolution(input: string!)
//        }).disposed(by: bag)
//
        // Create flag checking if input is correct
        let isSolved = codeView.codeTextField.rx.textInput.text
            .map { $0 == self.currentLesson.value.text }
        
        // Bind flag to button
        isSolved
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: bag) // FIXME: when lesson is completed, button should reset
        
        // Add Button
        nextButton.addTarget(for: .touchUpInside) { _ in
            self.showNextLesson()
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
    
    // MARK: -
    
    func checkSolution(input: String) {
        if input == currentLesson.value.text {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    func showNextLesson() {
        lessonNumber += 1
        if lessonNumber == lessonLibrary.count {
            self.dismiss(animated: true, completion: nil)
        } else {
            currentLesson.accept(lessonLibrary[lessonNumber])
        }
        
    }
}
