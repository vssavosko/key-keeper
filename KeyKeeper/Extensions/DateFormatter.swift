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
        
        formatter.dateFormat = dateFormat
        
        guard let dateWithDateType = formatter.date(from: date) else { return date }
        
        return formatter.string(from: dateWithDateType)
    }
    
}
