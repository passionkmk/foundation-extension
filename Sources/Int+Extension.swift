//
//  v.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension Int {
    var commaNotation: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? String(self)
    }
}
