//
//  CompletionViewController.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 27/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import UIKit

class CompletionViewController: UIViewController {

    // MARK: - UI Elements -

    let button: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), for: .normal)
        button.setBackgroundColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0.5018193493), for: .highlighted)
        button.setTitle("Hooray!", for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    let message: UILabel = {
        let label = UILabel()
        label.text = "✅ All done!"
        label.font = UIFont(name: "Chalkduster", size: 32)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = RealmManager()
        print(realm.retrieveAll())
        
        button.addTarget(for: .touchUpInside) { [unowned self] _ in
            self.dismiss(animated: false)
            self.presentingViewController?.dismiss(animated: false)
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(button)
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: button)
        view.addConstraintsWithFormat(format: "V:[v0(70)]-25-|", views: button)
        
        view.addSubview(message)
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: message)
        view.addConstraintsWithFormat(format: "V:|-100-[v0]-(>=25)-|", views: message)
    }
}
