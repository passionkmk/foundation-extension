//
//  Array+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        indices ~= index ? self[index] : nil
    }
}

extension Sequence where Element: Hashable {
    var unique: [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
