//
//  Bool+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension Bool {
    /// Bool 값의 반대값
    var not: Bool {
        !self
    }
    
    /// Bool 값이 false인지 확인
    var isNot: Bool {
        self == false
    }
}

