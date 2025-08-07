//
//  Array+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension Array {
    /// 배열의 안전한 인덱스 접근
    /// - Parameter index: 접근할 인덱스
    /// - Returns: 유효한 인덱스인 경우 요소, 아니면 nil
    subscript (safe index: Int) -> Element? {
        indices ~= index ? self[index] : nil
    }
}

public extension Sequence where Element: Hashable {
    /// 중복 요소를 제거한 배열 반환
    /// - Returns: 중복이 제거된 요소들의 배열
    var unique: [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
