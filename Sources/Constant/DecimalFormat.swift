//
//  DecimalFormat.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

/// 소수점 자릿수 포매팅 옵션
public enum DecimalFormat: Int {
    case point_0 = 1  // 소수점 0자리
    case point_1      // 소수점 1자리
    case point_2      // 소수점 2자리
    case point_3      // 소수점 3자리
}

public extension DecimalFormat {
    /// NumberFormatter 생성
    /// - Parameter roundingMode: 반올림 모드 (기본: .floor)
    /// - Returns: 설정된 NumberFormatter
    func format(
        _ roundingMode: NumberFormatter.RoundingMode = .floor
    ) -> NumberFormatter {
        let numberFormat = NumberFormatter()
        numberFormat.roundingMode = roundingMode
        numberFormat.maximumFractionDigits = self.rawValue - 1
        return numberFormat
    }
}
