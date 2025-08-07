//
//  Double+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension Double {
    /// 지정된 소수점 자릿수로 포매팅
    /// - Parameter point: 소수점 자릿수 포맷
    /// - Returns: 포맷된 문자열
    func precision(_ point: DecimalFormat) -> String {
        point.format().string(for: self) ?? String(self)
    }
}
