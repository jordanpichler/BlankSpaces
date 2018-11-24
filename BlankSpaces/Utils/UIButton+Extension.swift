//
//  UIButton+Extension.swift
//  BlankSpaces
//
//  K thx https://stackoverflow.com/a/27095410
//  and http://swiftpearls.com/selectors-with-pure-swift.html
//
//  Created by Jordan Pichler on 24/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import UIKit

var handle: Int = 0

// Parameter is the type of parameter passed in the selector
public class ClosureSelector<Parameter> {
    
    public let selector: Selector
    private let closure: (Parameter) -> ()
    
    init(withClosure closure: @escaping (Parameter) -> ()) {
        self.selector = #selector(ClosureSelector.target(_:))
        self.closure = closure
    }
    
    // Unfortunately we need to cast to AnyObject here
    @objc func target(_ param: AnyObject) {
        if let parameter = param as? Parameter {
            closure(parameter)
        }
    }
}

extension UIButton {
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// Set background colors for various control states.
    /// - Parameters:
    ///     - color: Button's desired background color
    ///     - state: Control states which color should be applied to
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(image(withColor: color), for: state)
    }
    
    /// Set a Swifty closure for occured control events!
    /// - Parameters:
    ///     - closure: Action to execute upon occurence of control event
    ///     - controlEvents: Control events which should execute the closure
    func add(target closure: @escaping (UIButton) -> Void, for controlEvents: UIControl.Event) {
        let closureSelector = ClosureSelector<UIButton>(withClosure: closure)
        objc_setAssociatedObject(self, &handle, closureSelector, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.addTarget(closureSelector, action: closureSelector.selector, for: controlEvents)
    }
}
