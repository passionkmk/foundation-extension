//
//  Date+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension Date {
    /// 지정된 형식으로 Date를 문자열로 변환
    /// - Parameters:
    ///   - format: 날짜 형식 문자열
    ///   - timeZone: 시간대
    ///   - locale: 로케일
    /// - Returns: 포맷된 날짜 문자열
    func string(format: String, timeZone: TimeZone, locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.locale = locale
        
        return dateFormatter.string(from: self)
    }
}
