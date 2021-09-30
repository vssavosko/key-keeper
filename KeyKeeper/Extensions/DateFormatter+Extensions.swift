//
//  Formatter.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 11.08.2021.
//

import UIKit

extension DateFormatter {
    
    static func configure(timeZone: TimeZone = .current, dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss") -> DateFormatter {
        let formatter = DateFormatter()
        
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        
        return formatter
    }
    
    static func changeDateFormatFor(date: String, dateFormat: String = "dd MMMM yyyy, hh:mm") -> String {
        let formatter = DateFormatter()
        let ISODateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        formatter.dateFormat = ISODateFormat
        
        guard let dateWithDateType = formatter.date(from: date) else { return date }
        
        formatter.dateFormat = dateFormat
        
        return formatter.string(from: dateWithDateType)
    }
    
}
