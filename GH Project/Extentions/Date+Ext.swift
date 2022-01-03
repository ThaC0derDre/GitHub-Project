//
//  Date+Ext.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/30/21.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
}
