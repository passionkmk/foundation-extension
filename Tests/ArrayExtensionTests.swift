//
//  ArrayExtensionTests.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Testing
import Foundation
@testable import FoundationExtension

struct ArrayExtensionTests {
    
    @Test("안전한 배열 인덱스 접근 - 유효한 인덱스")
    func testSafeSubscriptValidIndex() {
        let array = [1, 2, 3, 4, 5]
        #expect(array[safe: 0] == 1)
        #expect(array[safe: 2] == 3)
        #expect(array[safe: 4] == 5)
    }
    
    @Test("안전한 배열 인덱스 접근 - 무효한 인덱스")
    func testSafeSubscriptInvalidIndex() {
        let array = [1, 2, 3]
        #expect(array[safe: -1] == nil)
        #expect(array[safe: 3] == nil)
        #expect(array[safe: 10] == nil)
    }
    
    @Test("빈 배열 안전한 인덱스 접근")
    func testSafeSubscriptEmptyArray() {
        let emptyArray: [Int] = []
        #expect(emptyArray[safe: 0] == nil)
        #expect(emptyArray[safe: -1] == nil)
    }
    
    @Test("중복 제거 기능")
    func testUniqueElements() {
        let numbers = [1, 2, 2, 3, 3, 3, 4]
        let uniqueNumbers = numbers.unique
        #expect(uniqueNumbers == [1, 2, 3, 4])
    }
    
    @Test("문자열 배열 중복 제거")
    func testUniqueStrings() {
        let words = ["apple", "banana", "apple", "cherry", "banana"]
        let uniqueWords = words.unique
        #expect(uniqueWords == ["apple", "banana", "cherry"])
    }
    
    @Test("이미 고유한 요소들")
    func testUniqueAlreadyUnique() {
        let numbers = [1, 2, 3, 4, 5]
        let uniqueNumbers = numbers.unique
        #expect(uniqueNumbers == [1, 2, 3, 4, 5])
    }
    
    @Test("빈 배열 중복 제거")
    func testUniqueEmptyArray() {
        let emptyArray: [Int] = []
        let uniqueArray = emptyArray.unique
        #expect(uniqueArray.isEmpty)
    }
}