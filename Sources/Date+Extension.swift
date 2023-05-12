//
//  Date+Extension.swift
//  
//
//  Created by MIN KU KIM on 2023/05/12.
//

import Foundation

public extension Date {
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
