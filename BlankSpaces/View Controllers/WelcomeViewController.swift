//
//  WelcomeViewController.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 22/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    // MARK: - UI Elements -
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), for: .normal)
        button.setBackgroundColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .selected)
        button.setBackgroundColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0.5018193493), for: .highlighted)
        button.setBackgroundColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .disabled)
        button.setTitle("Get started!", for: .normal)
        button.setTitle("Try again", for: .selected)
        button.setTitle("Loading... ⏳", for: .disabled)
        button.layer.cornerRadius = 15
        return button
    }()

    let introHeader: UILabel = {
        let label = UILabel()
        label.text = "Hello there! 👋"
        label.font = UIFont(name: "Chalkduster", size: 26)
        label.numberOfLines = 0
        return label
    }()
    
    let introText: UILabel = {
        let label = UILabel()
        label.text = "Ready to test your coding knowledge?\nTap the button below!"
        label.numberOfLines = 0
        return label
    }()
    
    var lessonLibrary = [Lesson]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up start Button
        startButton.addTarget(for: .touchUpInside) { sender in
            // Show loading state of button and disable from user
            sender.isSelected = false
            sender.isEnabled = false
            sender.isUserInteractionEnabled = false

            let networker = NetworkingManager()
            networker.fetchLessons(completion: self.processFetchedLessons)
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(startButton)
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: startButton)
        view.addConstraintsWithFormat(format: "V:[v0(70)]-25-|", views: startButton)
        
        view.addSubview(introHeader)
        view.addSubview(introText)
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: introHeader)
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: introText)
        view.addConstraintsWithFormat(format: "V:|-100-[v0]-[v1]-(>=25)-|", views: introHeader, introText)
    }
    
    func processFetchedLessons(lessons: [Lesson]) {
        // Reenable button for user
        startButton.isUserInteractionEnabled = true
        startButton.isEnabled = true

        if lessons.isEmpty {
            // Set error state on button
            startButton.isSelected = true
            return
        }
        
        lessonLibrary.removeAll()
        lessonLibrary.append(contentsOf: lessons)
        
        presentLessons()
    }
    
    func printLessons(lessons: [Lesson]) {
        if lessons.isEmpty { print("FML") }
        
        for l in lessons {
            print("We got lesson \(l.id) here.")
        }
    }
    
    func presentLessons() {
        // Wait a second...
        
        let vc = LessonViewController(lesson: LessonViewModel(with: lessonLibrary[2]))
        present(vc, animated: true, completion: nil)
    }
}
