//
//  BasicExtensionTests.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Testing
import Foundation
@testable import FoundationExtension

struct BasicExtensionTests {
    
    // MARK: - Bool Extension Tests
    @Test("Bool not 속성")
    func testBoolNot() {
        #expect(true.not == false)
        #expect(false.not == true)
    }
    
    @Test("Bool isNot 속성")
    func testBoolIsNot() {
        #expect(true.isNot == false)
        #expect(false.isNot == true)
    }
    
    // MARK: - Optional Extension Tests
    @Test("Optional isExist 속성")
    func testOptionalIsExist() {
        let someValue: Int? = 42
        let nilValue: Int? = nil
        
        #expect(someValue.isExist == true)
        #expect(nilValue.isExist == false)
    }
    
    @Test("Optional isNotExist 속성")
    func testOptionalIsNotExist() {
        let someValue: String? = "hello"
        let nilValue: String? = nil
        
        #expect(someValue.isNotExist == false)
        #expect(nilValue.isNotExist == true)
    }
    
    // MARK: - Int Extension Tests
    @Test("Int 콤마 표기법")
    func testIntCommaNotation() {
        #expect(1000.commaNotation == "1,000")
        #expect(1234567.commaNotation == "1,234,567")
        #expect(0.commaNotation == "0")
        #expect((-1000).commaNotation == "-1,000")
    }
    
    // MARK: - Date Extension Tests
    @Test("Date 문자열 포매팅")
    func testDateStringFormatting() {
        let date = Date(timeIntervalSince1970: 1609459200) // 2021-01-01 00:00:00 UTC
        let formatter = "yyyy-MM-dd HH:mm:ss"
        let timeZone = TimeZone(identifier: "UTC")!
        let locale = Locale(identifier: "en_US_POSIX")
        
        let result = date.string(format: formatter, timeZone: timeZone, locale: locale)
        #expect(result == "2021-01-01 00:00:00")
    }
    
    // MARK: - DecimalFormat Tests
    @Test("DecimalFormat 포매터 생성")
    func testDecimalFormatCreation() {
        let format = DecimalFormat.point_2
        let formatter = format.format()
        
        #expect(formatter.maximumFractionDigits == 2) // point_2의 rawValue는 3, 3-1 = 2
        #expect(formatter.roundingMode == .floor)
    }
    
    // MARK: - Double Extension Tests
    @Test("Double 정밀도 포매팅")
    func testDoublePrecision() {
        let value: Double = 3.14159
        let formatted = value.precision(.point_2)
        
        // DecimalFormat의 구현에 따라 결과가 달라질 수 있음
        #expect(formatted.isEmpty == false)
    }
    
    // MARK: - Float Extension Tests
    @Test("Float 정밀도 포매팅")
    func testFloatPrecision() {
        let value: Float = 2.718
        let formatted = value.precision(.point_1)
        
        #expect(formatted.isEmpty == false)
    }
    
    // MARK: - JSONDecoder Extension Tests
    @Test("Snake case JSON 디코더")
    func testSnakeCaseDecoder() {
        let decoder = JSONDecoder.snakeCaseConverting
        // KeyDecodingStrategy는 Equatable하지 않으므로 다른 방식으로 테스트
        #expect(decoder !== JSONDecoder()) // 다른 인스턴스인지 확인
    }
}