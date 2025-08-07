//
//  Optional+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension Optional {
    /// Optional 값이 존재하는지 확인 (nil이 아니지)
    var isExist: Bool {
        guard case .some = self else { return false }
        return true
    }
    
    /// Optional 값이 존재하지 않는지 확인 (nil인지)
    var isNotExist: Bool {
        isExist.not
    }
}
