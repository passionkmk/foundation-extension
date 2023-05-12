//
//  Bool+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension Bool {
    var not: Bool {
        !self
    }
    
    var isNot: Bool {
        self == false
    }
}

