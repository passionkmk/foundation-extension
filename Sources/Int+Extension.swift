//
//  v.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension Int {
    /// 숫자를 콤마 표기법으로 변환 (1000 -> "1,000")
    var commaNotation: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? String(self)
    }
}
