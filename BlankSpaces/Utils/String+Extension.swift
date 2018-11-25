//
//  String+Extension.swift
//  BlankSpaces
//
//  Muchas gracias https://stackoverflow.com/a/46133083
//
//  Created by Jordan Pichler on 25/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import Foundation

extension String {
    
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
