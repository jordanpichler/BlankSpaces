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
        button.setBackgroundColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0.5018193493), for: .highlighted)
        button.setBackgroundColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .selected)
        button.layer.cornerRadius = 15
        button.setTitle("Get started!", for: .normal)
        button.setTitle("Loading... ⏳", for: .selected)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networker = NetworkingManager()
        networker.fetchLessons(completion: printLessons)
    }
    
    func printLessons(lessons: [Lesson]) {
        if lessons.isEmpty { print("FML") }
        
        for l in lessons {
            print("We got lesson \(l.id) here.")
        }
    }
}
