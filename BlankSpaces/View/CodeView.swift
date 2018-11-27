//
//  CodeView.swift
//  BlankSpaces
//
//  Styled UITextField to display the lessons
//
//  Created by Jordan Pichler on 25/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import UIKit

protocol CodeViewDelegate {
    func textDidChange(to text: String)
}

// MARK: -

class CodeView: UIView {

    // MARK: - Properties -
    
    let codeTextField = UITextField()
    var delegate: CodeViewDelegate?
    var shouldSetupConstraints = true
    
    // MARK: - Initialization -
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = #colorLiteral(red: 0.3939092385, green: 0.4034299317, blue: 0.4693845178, alpha: 1)
        codeTextField.text = "Oh my god! Look at you!"
        codeTextField.textColor = .white
        codeTextField.font = UIFont(name: "Courier New", size: 17)
        
        codeTextField.returnKeyType = .done
        codeTextField.spellCheckingType = .no
        codeTextField.autocorrectionType = .no
        
        codeTextField.delegate = self
        codeTextField.addTarget(self,
                                action: #selector(textFieldDidChange(_:)),
                                for: .editingChanged)
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
    
    public func hideKeyboard() {
        codeTextField.resignFirstResponder()
    }
}

// MARK: -

extension CodeView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        delegate?.textDidChange(to: text)
    }
}
