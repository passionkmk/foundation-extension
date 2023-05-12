//
//  Float+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/13.
//

import Foundation

public extension Float {
    func precision(_ point: DecimalFormat) -> String {
        point.format().string(for: self) ?? String(self)
    }
}
