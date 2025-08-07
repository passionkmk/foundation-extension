//
//  StringExtensionTests.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Testing
import Foundation
@testable import FoundationExtension

struct StringExtensionTests {
    
    @Test("빈 문자열 체크")
    func testIsBlank() {
        #expect("".isBlank == true)
        #expect("   ".isBlank == true)
        #expect("\n\t ".isBlank == true)
        #expect("hello".isBlank == false)
        #expect(" hello ".isBlank == false)
    }
    
    @Test("빈 문자열이 아님 체크")
    func testIsNotBlank() {
        #expect("".isNotBlank == false)
        #expect("   ".isNotBlank == false)
        #expect("hello".isNotBlank == true)
        #expect(" hello ".isNotBlank == true)
    }
    
    @Test("문자열 trim 기능")
    func testTrimmed() {
        #expect("  hello  ".trimmed == "hello")
        #expect("\n\thello\t\n".trimmed == "hello")
        #expect("hello".trimmed == "hello")
        #expect("".trimmed == "")
    }
    
    @Test("안전한 문자열 범위 접근 - 유효한 범위")
    func testSafeSubscriptValidRange() {
        let text = "hello"
        #expect(text[safe: 0..<2] == "he")
        #expect(text[safe: 1..<4] == "ell")
        #expect(text[safe: 0..<5] == "hello")
    }
    
    @Test("안전한 문자열 범위 접근 - 무효한 범위")
    func testSafeSubscriptInvalidRange() {
        let text = "hello"
        #expect(text[safe: -1..<2] == nil)
        #expect(text[safe: 0..<10] == nil)
        #expect(text[safe: 5..<10] == nil)
    }
    
    @Test("URL 인코딩")
    func testUrlEncoded() {
        let text = "hello world"
        #expect(text.urlEncoded() == "hello%20world")
        
        let korean = "안녕하세요"
        #expect(korean.urlEncoded() != nil)
        #expect(korean.urlEncoded()?.contains("%") == true)
    }
    
    @Test("이메일 유효성 검증")
    func testIsValidEmail() {
        #expect("test@example.com".isValidEmail == true)
        #expect("user.name+tag@domain.co.uk".isValidEmail == true)
        #expect("invalid.email".isValidEmail == false)
        #expect("@example.com".isValidEmail == false)
        #expect("test@".isValidEmail == false)
        #expect("".isValidEmail == false)
    }
    
    @Test("첫 글자 대문자 변환")
    func testCapitalizingFirstLetter() {
        #expect("hello".capitalizingFirstLetter == "Hello")
        #expect("HELLO".capitalizingFirstLetter == "HELLO")
        #expect("h".capitalizingFirstLetter == "H")
        #expect("".capitalizingFirstLetter == "")
    }
}

// iOS 16+ 테스트들은 조건부로만 실행
#if compiler(>=5.7) && canImport(_RegexParser)
@available(iOS 16.0, macOS 13.0, *)
struct StringExtensionModernTests {
    
    func testLines() {
        let multilineText = "line1\nline2\nline3"
        let lines = multilineText.lines
        #expect(lines == ["line1", "line2", "line3"])
        
        let singleLine = "single"
        #expect(singleLine.lines == ["single"])
    }
    
    func testRegexMatches() {
        #expect("hello123".matches(regex: #"\d+"#) == true)
        #expect("hello".matches(regex: #"\d+"#) == false)
        #expect("test@example.com".matches(regex: #".+@.+\..+"#) == true)
    }
}
#endif