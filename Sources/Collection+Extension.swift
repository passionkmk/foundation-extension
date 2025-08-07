//
//  Collection+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension Collection {
    /// 컵렉션이 비어있지 않은지 확인
    var isNotEmpty: Bool {
        !isEmpty
    }
    
    /// 안전한 인덱스 접근
    /// - Parameter index: 접근할 인덱스
    /// - Returns: 유효한 인덱스인 경우 요소, 아니면 nil
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

public extension Collection where Element: Equatable {
    /// 중복 요소를 제거한 배열 반환 (Equatable 타입용)
    /// - Returns: 중복이 제거된 요소들의 배열
    func removingDuplicates() -> [Element] {
        var result: [Element] = []
        for element in self {
            if !result.contains(element) {
                result.append(element)
            }
        }
        return result
    }
}

public extension Array {
    /// 배열을 지정된 크기로 분할
    /// - Parameter size: 각 청크의 크기 (1 이상이어야 함)
    /// - Returns: 분할된 청크들의 배열
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0 else { return [] }
        
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
    
    /// 안전한 요소 제거 (범위 밖 인덱스 무시)
    /// - Parameter index: 제거할 인덱스
    mutating func safeRemove(at index: Int) {
        guard indices.contains(index) else { return }
        remove(at: index)
    }
    
    /// 안전한 요소 삽입 (범위 밖 인덱스 무시)
    /// - Parameters:
    ///   - element: 삽입할 요소
    ///   - index: 삽입할 위치
    mutating func safeInsert(_ element: Element, at index: Int) {
        guard index >= 0 && index <= count else { return }
        insert(element, at: index)
    }
}

public extension Array where Element: Equatable {
    /// 조건에 맞는 첫 번째 요소 제거
    /// - Parameter predicate: 제거 조건
    mutating func removeFirst(where predicate: (Element) throws -> Bool) rethrows {
        if let index = try firstIndex(where: predicate) {
            remove(at: index)
        }
    }
}