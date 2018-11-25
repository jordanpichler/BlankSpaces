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
    
    var lessonViewModel: LessonViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeView.setCode(text: lessonViewModel.puzzledText())
        
        if lessonViewModel.needsInput {
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
    
    convenience init(lesson: LessonViewModel) {
        self.init()
        lessonViewModel = lesson
    }
}
