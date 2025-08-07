//
//  String+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension String {
    /// 문자열이 비어있거나 공백문자만 있는지 확인
    var isBlank: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// 문자열이 비어있지 않고 공백문자만 있지 않은지 확인
    var isNotBlank: Bool {
        !isBlank
    }
    
    /// 앞뒤 공백문자를 제거한 문자열
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// 안전한 문자열 범위 접근
    /// - Parameter range: 추출할 범위
    /// - Returns: 유효한 범위인 경우 부분 문자열, 아니면 nil
    subscript(safe range: Range<Int>) -> String? {
        guard range.lowerBound >= 0,
              range.upperBound <= count else { return nil }
        
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = index(self.startIndex, offsetBy: range.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    /// URL 인코딩된 문자열 반환
    /// - Returns: 인코딩된 문자열 또는 nil
    func urlEncoded() -> String? {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    /// 이메일 형식 유효성 검증
    var isValidEmail: Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
    
    /// 첫 글자를 대문자로 변환
    var capitalizingFirstLetter: String {
        guard let first = first else { return self }
        return String(first).uppercased() + dropFirst()
    }
}

@available(iOS 16.0, macOS 13.0, *)
public extension String {
    /// 문자열을 줄 단위로 분리
    var lines: [String] {
        components(separatedBy: .newlines)
    }
    
    /// 정규식 패턴 매칭 확인
    /// - Parameter regex: 정규식 패턴
    /// - Returns: 매칭되는지 여부
    func matches(regex: String) -> Bool {
        do {
            let regex = try Regex(regex)
            return firstMatch(of: regex) != nil
        } catch {
            return false
        }
    }
}