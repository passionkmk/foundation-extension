//
//  Double+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension Double {
    func precision(_ point: DecimalFormat) -> String {
        point.format().string(for: self) ?? String(self)
    }
}
