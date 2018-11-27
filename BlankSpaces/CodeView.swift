//
//  CodeView.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 25/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import UIKit

class CodeView: UIView {

    let codeTextField = UITextField()
    var shouldSetupConstraints = true
    
    // MARK: - Initializers -
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = #colorLiteral(red: 0.3939092385, green: 0.4034299317, blue: 0.4693845178, alpha: 1)
        codeTextField.text = "Oh my god! Look at that ⬜️⬜️⬜️⬜️!"
        codeTextField.textColor = .white
        codeTextField.font = UIFont(name: "Courier New", size: 17)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if shouldSetupConstraints {
            shouldSetupConstraints = false
            
            self.addSubview(codeTextField)
            addConstraintsWithFormat(format: "H:|-25-[v0]-25-|", views: codeTextField)
            addConstraintsWithFormat(format: "V:|-25-[v0]-25-|", views: codeTextField)
        }
        
        super.updateConstraints()
    }
    
    // MARK: - Interface -
    
    public func setCode(text: NSAttributedString) {
        codeTextField.attributedText = text
    }
}
