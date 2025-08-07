//
//  CollectionExtensionTests.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Testing
import Foundation
@testable import FoundationExtension

struct CollectionExtensionTests {
    
    @Test("비어있지 않음 체크")
    func testIsNotEmpty() {
        let emptyArray: [Int] = []
        let nonEmptyArray = [1, 2, 3]
        
        #expect(emptyArray.isNotEmpty == false)
        #expect(nonEmptyArray.isNotEmpty == true)
        
        let emptyString = ""
        let nonEmptyString = "hello"
        #expect(emptyString.isNotEmpty == false)
        #expect(nonEmptyString.isNotEmpty == true)
    }
    
    @Test("안전한 인덱스 접근")
    func testSafeIndexAccess() {
        let array = ["a", "b", "c"]
        
        #expect(array[safe: array.startIndex] == "a")
        #expect(array[safe: array.index(array.startIndex, offsetBy: 1)] == "b")
        
        let string = "hello"
        #expect(string[safe: string.startIndex] == "h")
    }
    
    @Test("중복 제거 (Equatable)")
    func testRemovingDuplicates() {
        let numbers = [1, 2, 2, 3, 3, 3, 4]
        let unique = numbers.removingDuplicates()
        #expect(unique == [1, 2, 3, 4])
        
        let words = ["apple", "banana", "apple"]
        let uniqueWords = words.removingDuplicates()
        #expect(uniqueWords == ["apple", "banana"])
    }
    
    @Test("배열 청킹")
    func testChunked() {
        let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let chunks = numbers.chunked(into: 3)
        
        #expect(chunks.count == 4)
        #expect(chunks[0] == [1, 2, 3])
        #expect(chunks[1] == [4, 5, 6])
        #expect(chunks[2] == [7, 8, 9])
        #expect(chunks[3] == [10])
    }
    
    @Test("안전한 요소 제거")
    func testSafeRemove() {
        var array = [1, 2, 3, 4, 5]
        
        array.safeRemove(at: 2)
        #expect(array == [1, 2, 4, 5])
        
        array.safeRemove(at: 10) // 무효한 인덱스
        #expect(array == [1, 2, 4, 5]) // 변화 없음
        
        array.safeRemove(at: -1) // 무효한 인덱스
        #expect(array == [1, 2, 4, 5]) // 변화 없음
    }
    
    @Test("안전한 요소 삽입")
    func testSafeInsert() {
        var array = [1, 2, 3]
        
        array.safeInsert(0, at: 0)
        #expect(array == [0, 1, 2, 3])
        
        array.safeInsert(4, at: 4) // 마지막에 삽입
        #expect(array == [0, 1, 2, 3, 4])
        
        array.safeInsert(99, at: -1) // 무효한 인덱스
        #expect(array == [0, 1, 2, 3, 4]) // 변화 없음
        
        array.safeInsert(99, at: 10) // 무효한 인덱스
        #expect(array == [0, 1, 2, 3, 4]) // 변화 없음
    }
    
    @Test("조건부 첫 번째 요소 제거")
    func testRemoveFirstWhere() {
        var numbers = [1, 2, 3, 2, 4]
        
        numbers.removeFirst { $0 == 2 }
        #expect(numbers == [1, 3, 2, 4]) // 첫 번째 2만 제거됨
        
        numbers.removeFirst { $0 == 5 }
        #expect(numbers == [1, 3, 2, 4]) // 5가 없으므로 변화 없음
    }
}