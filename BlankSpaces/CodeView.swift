//
//  CodeView.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 25/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import UIKit

class CodeView: UIView {

    let code = UILabel()
    var shouldSetupConstraints = true
    
    // MARK: - Initializers -
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = #colorLiteral(red: 0.2825384149, green: 0.2893673017, blue: 0.3366744028, alpha: 1)
        code.text = "Oh my god! Look at that ⬜️⬜️⬜️⬜️!"
        code.textColor = .white
        code.font = UIFont(name: "Courier New", size: 14)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if shouldSetupConstraints {
            shouldSetupConstraints = false
            
            self.addSubview(code)
            addConstraintsWithFormat(format: "H:|-25-[v0]-25-|", views: code)
            addConstraintsWithFormat(format: "V:|-25-[v0]-25-|", views: code)
        }
        
        super.updateConstraints()
    }
    
    // MARK: - Interface -
    
    public func setCode(text: NSAttributedString) {
        code.attributedText = text
    }
}
