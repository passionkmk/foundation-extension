//
//  Optional+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension Optional {
    var isExist: Bool {
        guard case .some = self else { return false }
        return true
    }
    
    var isNotExist: Bool {
        isExist.not
    }
}
