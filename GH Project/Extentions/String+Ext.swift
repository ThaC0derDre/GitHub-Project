//
//  String+Ext.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/30/21.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        
        let formatter        = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale     = Locale(identifier: "en_US_POSIX")
        formatter.timeZone   = .current
        return formatter.date(from: self)
    }
    
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return ""}
        return date.convertToMonthYearFormat()
    }
}
