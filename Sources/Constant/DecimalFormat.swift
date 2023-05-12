//
//  DecimalFormat.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public enum DecimalFormat: Int {
    case point_0 = 1
    case point_1
    case point_2
    case point_3
}

public extension DecimalFormat {
    func format(
        _ roundingMode: NumberFormatter.RoundingMode = .floor
    ) -> NumberFormatter {
        let numberFormat = NumberFormatter()
        numberFormat.roundingMode = roundingMode
        numberFormat.maximumSignificantDigits = self.rawValue
        return numberFormat
    }
}
